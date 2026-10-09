#!/usr/bin/env python3
"""Turn `exec/results.json` into an interactive chart of the whole matrix.

`exec/harness.py` measures; this reads what it measured and writes one
self-contained HTML file -- the data is embedded in the page, so it opens from
the filesystem with no server and no network.

    python exec/plot.py                 # exec/results.json -> exec/results.html
    python exec/plot.py --open          # ...and open it in the browser
    python exec/plot.py --json other.json --html other.html

The matrix has two axes and the page is built around both.  A row is a **front
end**: a language and the toolchain that turns its source into something
runnable.  A **backend** is what then actually executes it -- the code generator
or virtual machine the front end hands its program to -- and there are far fewer
backends than front ends, because many front ends share one: `ada`, `fortran`,
`modula-2`, `c++` and `c` are all GCC, `java`, `kotlin`, `scala`, `clojure` and
`groovy` are all HotSpot, and one WebAssembly module runs unchanged on six
runtimes.  So most rows are the same backend wearing a different front end, and
the page is built to say so:

  * every series is tagged with its backend and coloured by the backend's *kind*
    (`native-aot`, `native-jit`, `bytecode-vm`, `interpreter`, `wasm-runtime`,
    `assembler`) rather than by language -- six kinds is few enough for a
    readable, accessible palette;
  * the legend is grouped by backend: each backend is a heading (its display name
    and kind) with its rows/toolchains nested underneath, and clicking a heading
    collapses its group;
  * the multi-series chart has two modes, chosen with the View control --
    "per toolchain" (one line per row/toolchain) and "per backend" (one line per
    backend, each point the median of that backend's rows' medians for the task);
  * the ranked bar chart for a single task names the backend beside each row.

The page reads whichever metric is selected (the program's own `TIME_MS`, the
harness's end-to-end wall clock, peak working set, or artifact size), on a log
or linear axis.  The multi-series chart zooms with the wheel, pans with a drag,
isolates a series on a legend or bar click and shows the full cell record on
hover; the ranked bar chart sorts every toolchain so "which language is fastest
at task 13" is one glance.

The backend table travels in `results.json`.  When a cell has no backend (an older
results file), the registry (`cells.json`) is consulted for that row/toolchain's
backend, and anything still unknown is shown as `?` rather than dropped.

Cells that failed are drawn as hollow markers at the bottom of the chart rather
than dropped, because a row that is missing from a chart reads as "not
measured", which is a different fact from "measured and broken".
"""
import argparse
import json
import os
import sys
import time
import webbrowser

HERE = os.path.dirname(os.path.abspath(__file__))

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
# What each task measures, for the axis label and the task picker.
TASK_TITLES = {
    "01_branches": "branch chain",
    "02_switch_case": "switch/case",
    "03_func_sum": "function calls",
    "04_array_sum": "array sum",
    "05_alloc_churn": "allocation churn",
    "06_char_count": "char count",
    "07_string_append": "string append",
    "08_average": "float average",
    "09_fib_recursive": "recursive fib",
    "10_pi": "pi spigot",
    "11_parallel_sum": "4 threads",
    "12_matrix_add": "matrix add",
    "13_matrix_mul": "matrix multiply",
    "14_file_read": "read 50 MiB",
    "15_file_write": "write 50 MiB",
}

TEMPLATE = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>StUpIdSpEeD -- __COUNT__ cells</title>
<style>
:root{
  --bg:#ffffff; --fg:#1a1d21; --muted:#6b7280; --border:#e3e6ea; --surface:#f6f7f9;
  --accent:#2563eb; --ok:#16a34a; --warn:#d97706; --err:#dc2626;
  --grid:#eceef1; --grid-strong:#d8dce1;
}
@media (prefers-color-scheme: dark){
  :root{
    --bg:#14171a; --fg:#e8eaed; --muted:#9aa3ad; --border:#2b3036; --surface:#1b1f24;
    --accent:#60a5fa; --ok:#4ade80; --warn:#fbbf24; --err:#f87171;
    --grid:#23282e; --grid-strong:#333a42;
  }
}
*{box-sizing:border-box}
html,body{margin:0;padding:0;background:var(--bg);color:var(--fg);
  font:13px/1.45 ui-sans-serif,-apple-system,"Segoe UI",Roboto,sans-serif}
body{padding:14px 16px 40px}
h1{font-size:16px;margin:0 0 2px;font-weight:650;letter-spacing:-.01em}
h2{font-size:13px;margin:22px 0 8px;font-weight:650}
.sub{color:var(--muted);font-size:12px;margin-bottom:12px}
.sub b{color:var(--fg);font-weight:600}
.controls{display:flex;flex-wrap:wrap;gap:10px 16px;align-items:center;
  padding:10px 12px;border:1px solid var(--border);border-radius:8px;
  background:var(--surface);margin-bottom:12px}
.controls label{display:flex;gap:6px;align-items:center;color:var(--muted);font-size:12px}
select,input[type=text]{background:var(--bg);color:var(--fg);border:1px solid var(--border);
  border-radius:5px;padding:4px 7px;font:inherit;font-size:12px}
input[type=text]{min-width:170px}
button{background:var(--bg);color:var(--fg);border:1px solid var(--border);border-radius:5px;
  padding:4px 10px;font:inherit;font-size:12px;cursor:pointer}
button:hover{border-color:var(--accent);color:var(--accent)}
.spacer{flex:1}
.wrap{display:flex;gap:14px;align-items:flex-start}
.chartbox{position:relative;flex:1;min-width:0;border:1px solid var(--border);border-radius:8px;
  background:var(--bg);overflow:hidden}
svg{display:block;width:100%;touch-action:none;cursor:crosshair}
.legend{width:270px;flex:0 0 270px;max-height:620px;overflow-y:auto;
  border:1px solid var(--border);border-radius:8px;background:var(--surface);padding:6px}
.lg{display:flex;align-items:center;gap:7px;padding:2px 5px;border-radius:4px;cursor:pointer;
  font-size:11.5px;white-space:nowrap}
.lg:hover{background:var(--bg)}
.lg.off{opacity:.32}
.lg .sw{width:11px;height:11px;border-radius:2px;flex:0 0 11px}
.lg .nm{overflow:hidden;text-overflow:ellipsis;color:var(--fg)}
.lg .vl{margin-left:auto;color:var(--muted);font-variant-numeric:tabular-nums}
.lgh{display:flex;align-items:center;gap:6px;padding:3px 5px;border-radius:4px;cursor:pointer;
  font-size:11.5px;font-weight:650;white-space:nowrap}
.lgh:hover{color:var(--accent)}
.lgh .caret{width:9px;color:var(--muted);font-size:9px;flex:0 0 9px}
.lgh .sw{width:11px;height:11px;border-radius:2px;flex:0 0 11px}
.lgh .kd{margin-left:auto;color:var(--muted);font-weight:400;font-size:10.5px}
.lgrow{padding-left:16px}
.tip{position:absolute;pointer-events:none;background:var(--bg);border:1px solid var(--border);
  border-radius:6px;padding:7px 9px;font-size:11.5px;box-shadow:0 4px 16px rgba(0,0,0,.18);
  max-width:290px;display:none;z-index:5}
.tip .t{font-weight:650;margin-bottom:3px}
.tip .r{display:flex;gap:8px;color:var(--muted)}
.tip .r b{color:var(--fg);font-weight:600;margin-left:auto;font-variant-numeric:tabular-nums}
.bars{border:1px solid var(--border);border-radius:8px;overflow:hidden}
.bar{display:flex;align-items:center;gap:8px;padding:2px 8px;font-size:11.5px;cursor:pointer}
.bar:hover{background:var(--surface)}
.bar .rk{width:34px;color:var(--muted);text-align:right;font-variant-numeric:tabular-nums}
.bar .nm{width:310px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.bar .tr{flex:1;height:13px;background:var(--surface);border-radius:2px;overflow:hidden}
.bar .fl{display:block;height:100%;border-radius:2px}
.bar .vl{width:86px;text-align:right;font-variant-numeric:tabular-nums;color:var(--fg)}
.bar.bad .nm{color:var(--err)}
.note{color:var(--muted);font-size:11.5px;margin-top:8px}
.hint{color:var(--muted);font-size:11.5px}
</style>
</head>
<body>
<h1>StUpIdSpEeD</h1>
<div class="sub" id="sub"></div>

<div class="controls">
  <label>Metric
    <select id="metric">
      <option value="speed">Speed -- program's own TIME_MS</option>
      <option value="wall">Wall clock -- end to end</option>
      <option value="mem">Peak memory</option>
      <option value="size">Program size</option>
    </select>
  </label>
  <label>Scale
    <select id="scale">
      <option value="log">log</option>
      <option value="lin">linear</option>
    </select>
  </label>
  <label>Show
    <select id="status">
      <option value="ok">measured only</option>
      <option value="all">measured + failed</option>
      <option value="bad">failed only</option>
    </select>
  </label>
  <label>View
    <select id="view">
      <option value="toolchain">per toolchain</option>
      <option value="backend">per backend (rollup)</option>
    </select>
  </label>
  <label>Search <input type="text" id="search" placeholder="row, toolchain or backend"></label>
  <button id="reset">Reset zoom</button>
  <button id="iso">Clear isolation</button>
  <span class="spacer"></span>
  <span class="hint">wheel = zoom &middot; shift+wheel = time axis &middot; drag = pan &middot; dbl-click = reset</span>
</div>
<div class="hint" id="viewnote"></div>

<div class="wrap">
  <div class="chartbox">
    <svg id="chart"></svg>
    <div class="tip" id="tip"></div>
  </div>
  <div class="legend" id="legend"></div>
</div>

<h2 id="barhead"></h2>
<div class="bars" id="bars"></div>
<div class="note" id="barnote"></div>

<script>
const DOC = __DATA__;
const TASK_TITLES = __TITLES__;

const METRICS = {
  speed: {field: "median_ms",      label: "TIME_MS (ms)",  unit: "ms",  fmt: fmtMs},
  wall:  {field: "median_wall_ms", label: "wall clock (ms)", unit: "ms", fmt: fmtMs},
  mem:   {field: "peak_bytes",     label: "peak memory",   unit: "B",   fmt: fmtBytes},
  size:  {field: "artifact_bytes", label: "program size",  unit: "B",   fmt: fmtBytes},
};

// Grouping is written out rather than left to toLocaleString: on a pt-BR host
// that renders 200000 as "200.000", which reads as 200 in a chart axis.
function group(n){
  return String(Math.round(n)).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function fmtMs(v){
  if (v == null) return "--";
  if (v >= 10000) return group(v);
  if (v >= 100) return v.toFixed(1);
  if (v >= 1) return v.toFixed(2);
  if (v >= 0.01) return v.toFixed(3);
  return String(Number(v.toPrecision(2)));
}
function fmtBytes(v){
  if (v == null) return "--";
  const u = ["B","KiB","MiB","GiB"];
  let i = 0;
  while (v >= 1024 && i < u.length-1){ v /= 1024; i++; }
  return (i === 0 ? v : v.toFixed(v < 10 ? 2 : 1)) + " " + u[i];
}

// ---- backend table ----------------------------------------------------------
// The registry's backend table travels in the results doc.  A cell may still
// lack a backend (an older results file, or a toolchain added since the file
// was written), so fall back to the registry copy that build() embeds, then to
// "?" -- a series is never dropped just because its backend is unknown.
const BACKENDS = DOC.backends || {};
const REG_BACKENDS = __BACKENDS__ || {};
function backendOf(c){
  if (!c) return "?";
  if (c.backend) return c.backend;
  const e = REG_BACKENDS[c.row + "/" + c.toolchain];
  return e || "?";
}
function backendMeta(id){
  return BACKENDS[id] || REG_BACKENDS["#" + id] || {name: id, kind: "", what: ""};
}
function backendName(id){ return backendMeta(id).name || id; }

// ---- kind palette ----------------------------------------------------------
// Six kinds, six hues, picked to stay distinguishable on both the light and the
// dark surface (mid-lightness, decent saturation).  Colour is by kind, not by
// language: the question the page answers is "what actually ran", and two rows
// of one backend share a hue on purpose.
const KIND_COLORS = {
  "native-aot":   "hsl(212 72% 50%)",   // blue
  "native-jit":   "hsl(28 88% 50%)",    // orange
  "bytecode-vm":  "hsl(280 62% 55%)",   // violet
  "interpreter":  "hsl(158 62% 38%)",   // green
  "wasm-runtime": "hsl(340 72% 52%)",   // pink
  "assembler":    "hsl(48 90% 40%)",    // amber
};
const KIND_FALLBACK = "hsl(215 12% 52%)";   // grey for an unknown kind
function kindColor(kind){ return KIND_COLORS[kind] || KIND_FALLBACK; }

// ---- series model ----------------------------------------------------------
// One series per (row, toolchain) in toolchain mode; one per backend in backend
// mode.  A series' `cells` map always holds a cell-shaped object, so the same
// drawing, tooltip and bar code works for both.
const SERIES = [];
const BY_KEY = new Map();
const BACKEND_SERIES = [];
const BY_BACKEND = new Map();
for (const c of DOC.cells){
  const key = c.row + "/" + c.toolchain;
  const backend = backendOf(c);
  let s = BY_KEY.get(key);
  if (!s){
    s = {key, row: c.row, toolchain: c.toolchain, language: c.language || c.row,
         backend: backend, cells: new Map()};
    BY_KEY.set(key, s);
    SERIES.push(s);
  }
  s.cells.set(c.task, c);
}
for (const s of SERIES){
  s.color = kindColor(backendMeta(s.backend).kind);
}
SERIES.sort((a,b) => a.row.localeCompare(b.row) || a.toolchain.localeCompare(b.toolchain));

// ---- backend rollup ---------------------------------------------------------
// One series per backend: for each task, the median of the rows' medians.  The
// median (rather than the fastest row) is labelled as such in the UI, because
// it is the robust summary of "what this backend typically does"; the fastest
// row would flatter a backend whose front ends disagree.  A cell the rollup
// synthesises is not a measurement, so its `median_wall_ms`/memory fields are
// copied from the chosen contributing cell only when that is meaningful -- for
// the median it is left null and the tooltip names the contributor count.
{
  const members = new Map();       // backend id -> [series]
  for (const s of SERIES){
    if (!members.has(s.backend)) members.set(s.backend, []);
    members.get(s.backend).push(s);
  }
  for (const [backend, list] of members){
    const meta = backendMeta(backend);
    const es = {key: "backend:" + backend, backend: backend, kind: meta.kind,
                name: meta.name || backend, rows: list, cells: new Map()};
    es.color = kindColor(meta.kind);
    for (const t of (DOC.tasks || [])){
      // Aggregate each metric the page can show, not just the speed one: the
      // rollup must survive the Metric control, and a field with no values in
      // this task's rows is left null (drawn as "not measured").
      const pick = (field) => {
        const vals = [];
        for (const s of list){
          const c = s.cells.get(t);
          if (!c || c.status !== "OK") continue;
          let v = c[field];
          if (v == null && field === "median_ms") v = c.median_wall_ms;
          if (v == null) continue;
          vals.push(v);
        }
        vals.sort((a,b) => a-b);
        return vals;
      };
      const sv = pick("median_ms");
      if (!sv.length) continue;
      const med = (vals) => {
        const n = vals.length;
        return n % 2 ? vals[(n-1)/2] : (vals[n/2 - 1] + vals[n/2]) / 2;
      };
      const wv = pick("median_wall_ms"), mv = pick("peak_bytes"), av = pick("artifact_bytes");
      es.cells.set(t, {row: meta.name || backend, toolchain: backend + " (rollup)",
                       task: t, status: "OK",
                       median_ms: med(sv), median_wall_ms: wv.length ? med(wv) : null,
                       peak_bytes: mv.length ? med(mv) : null,
                       artifact_bytes: av.length ? med(av) : null,
                       runs: sv.length, backend: backend,
                       _rollup: true, _members: sv.length, _min: sv[0], _max: sv[sv.length-1]});
    }
    BACKEND_SERIES.push(es);
  }
  BACKEND_SERIES.sort((a,b) => a.name.localeCompare(b.name));
}

// The active series set and lookup for the current view.
function activeSeries(){
  return state.view === "backend" ? BACKEND_SERIES : SERIES;
}
function seriesByKey(key){
  if (state.view === "backend") return BY_BACKEND.get(key);
  return BY_KEY.get(key);
}
for (const es of BACKEND_SERIES) BY_BACKEND.set(es.key, es);

const TASKS = DOC.tasks && DOC.tasks.length ? DOC.tasks : __TASKS__;
const taskIndex = new Map(TASKS.map((t,i) => [t,i]));

// ---- state -----------------------------------------------------------------
const state = {
  metric: "speed", scale: "log", status: "ok", view: "toolchain",
  search: "", hidden: new Set(), isolated: null, collapsed: new Set(),
  task: TASKS[0],
  // domains in transformed space (log10 of the value when scale is log)
  x0: -0.6, x1: TASKS.length - 0.4, y0: 0, y1: 1, yInit: false,
};

const svg = document.getElementById("chart");
const tip = document.getElementById("tip");
const NS = "http://www.w3.org/2000/svg";
function el(name, attrs){
  const e = document.createElementNS(NS, name);
  if (attrs) for (const k in attrs) e.setAttribute(k, attrs[k]);
  return e;
}

function matches(s, q){
  if (!q) return true;
  if (state.view === "backend") return (s.name + " " + s.backend + " " + (s.kind || "")).toLowerCase().includes(q);
  return (s.row + "/" + s.toolchain).toLowerCase().includes(q) ||
         (s.backend + " " + backendName(s.backend)).toLowerCase().includes(q);
}
function visibleSeries(){
  const q = state.search.trim().toLowerCase();
  return activeSeries().filter(s => {
    if (state.isolated && s.key !== state.isolated) return false;
    if (state.hidden.has(s.key)) return false;
    if (!matches(s, q)) return false;
    return true;
  });
}

function metric(){ return METRICS[state.metric]; }

// value -> transformed coordinate
function tf(v){
  if (v == null) return null;
  if (state.scale === "log"){
    if (!(v > 0)) return null;               // 0 or negative: no log position
    return Math.log10(v);
  }
  return v;
}
function untf(t){
  return state.scale === "log" ? Math.pow(10, t) : t;
}

// The value a cell shows for the current metric, honouring the status filter.
// A cell the row never had (a toolchain that does not cover that task) has no
// value, which is the same answer as a failed one: nothing to plot.
function valueOf(c){
  if (!c) return null;
  const m = metric();
  if (c.status !== "OK"){
    if (state.status === "ok") return null;
    return null;                              // failures are markers, not values
  }
  if (state.status === "bad") return null;
  let v = c[m.field];
  if (v == null && m.field === "median_ms") v = c.median_wall_ms;
  if (v == null) return null;
  return v;
}
function failedCells(){
  if (state.status === "ok") return [];
  if (state.view === "backend") return [];   // a rollup is an aggregate, not a cell
  return [...BY_KEY.values()].flatMap(s => [...s.cells.values()])
    .filter(c => c.status !== "OK");
}

// ---- layout ----------------------------------------------------------------
let W = 900, H = 560;
const PAD = {l: 66, r: 14, t: 12, b: 46};
function plotW(){ return W - PAD.l - PAD.r; }
function plotH(){ return H - PAD.t - PAD.b; }

function fitY(){
  const vals = [];
  for (const s of visibleSeries())
    for (const t of TASKS){
      const v = valueOf(s.cells.get(t));
      if (v != null) vals.push(tf(v));
    }
  if (!vals.length){ state.y0 = 0; state.y1 = 1; return; }
  let lo = Math.min(...vals), hi = Math.max(...vals);
  if (lo === hi){ lo -= 0.5; hi += 0.5; }
  const pad = (hi - lo) * 0.06;
  state.y0 = lo - pad; state.y1 = hi + pad;
}
function resetZoom(){
  state.x0 = -0.6; state.x1 = TASKS.length - 0.4;
  fitY();
  state.yInit = true;
  render();
}

// data -> pixel
function sx(i){ return PAD.l + (i - state.x0) / (state.x1 - state.x0) * plotW(); }
function sy(t){ return PAD.t + plotH() - (t - state.y0) / (state.y1 - state.y0) * plotH(); }

// ---- render ----------------------------------------------------------------
let pointIndex = [];   // for hit testing

function render(){
  const m = metric();
  if (!state.yInit) fitY();
  svg.setAttribute("viewBox", `0 0 ${W} ${H}`);
  svg.setAttribute("height", H);
  while (svg.firstChild) svg.removeChild(svg.firstChild);
  pointIndex = [];

  const g = el("g");
  svg.appendChild(g);

  // --- grid + y axis
  const yTicks = niceTicks(state.y0, state.y1);
  for (const t of yTicks){
    const y = sy(t);
    if (y < PAD.t - 1 || y > PAD.t + plotH() + 1) continue;
    g.appendChild(el("line", {x1: PAD.l, x2: PAD.l + plotW(), y1: y, y2: y,
      stroke: "var(--grid)", "stroke-width": 1}));
    const label = el("text", {x: PAD.l - 8, y: y + 4, "text-anchor": "end",
      fill: "var(--muted)", "font-size": 11});
    label.textContent = m.unit === "ms" ? fmtMs(untf(t)) + " ms" : fmtBytes(untf(t));
    g.appendChild(label);
  }

  // --- x axis: one column per task
  for (let i = 0; i < TASKS.length; i++){
    const x = sx(i);
    if (x < PAD.l - 1 || x > PAD.l + plotW() + 1) continue;
    g.appendChild(el("line", {x1: x, x2: x, y1: PAD.t, y2: PAD.t + plotH(),
      stroke: "var(--grid)", "stroke-width": 1}));
    const t1 = el("text", {x, y: H - PAD.b + 16, "text-anchor": "middle",
      fill: "var(--fg)", "font-size": 11, "font-weight": 600});
    t1.textContent = TASKS[i].slice(0, 2);
    g.appendChild(t1);
    const t2 = el("text", {x, y: H - PAD.b + 30, "text-anchor": "middle",
      fill: "var(--muted)", "font-size": 10});
    t2.textContent = (TASK_TITLES[TASKS[i]] || "").slice(0, 13);
    g.appendChild(t2);
  }

  // --- series
  const visible = visibleSeries();
  for (const s of visible){
    const pts = [];
    for (const t of TASKS){
      const c = s.cells.get(t);
      if (!c) continue;
      const v = valueOf(c);
      if (v == null) continue;
      const tv = tf(v);
      if (tv == null) continue;
      const i = taskIndex.get(t);
      const px = sx(i), py = sy(tv);
      pts.push({x: px, y: py, t, c});
      pointIndex.push({x: px, y: py, s, t, c});
    }
    if (pts.length > 1){
      g.appendChild(el("polyline", {
        points: pts.map(p => p.x + "," + p.y).join(" "),
        fill: "none", stroke: s.color,
        "stroke-width": s.key === state.isolated ? 2.6 : 1.7,
        "stroke-opacity": state.isolated ? 1 : 0.72,
        "stroke-linejoin": "round",
      }));
    }
    for (const p of pts){
      g.appendChild(el("circle", {cx: p.x, cy: p.y, r: s.key === state.isolated ? 3.4 : 2.4,
        fill: s.color, "fill-opacity": state.isolated ? 1 : 0.85}));
    }
  }

  // --- failures: hollow markers along the bottom, never silently dropped
  const bad = failedCells().filter(c => {
    const s = BY_KEY.get(c.row + "/" + c.toolchain);
    if (!s) return false;
    if (state.isolated && s.key !== state.isolated) return false;
    if (state.hidden.has(s.key)) return false;
    const q = state.search.trim().toLowerCase();
    if (!matches(s, q)) return false;
    return true;
  });
  const yBad = PAD.t + plotH() - 9;
  for (const c of bad){
    const i = taskIndex.get(c.task);
    if (i == null) continue;
    const x = sx(i);
    if (x < PAD.l - 1 || x > PAD.l + plotW() + 1) continue;
    const s = BY_KEY.get(c.row + "/" + c.toolchain);
    g.appendChild(el("path", {
      d: `M ${x-3.4} ${yBad-3.4} L ${x+3.4} ${yBad+3.4} M ${x+3.4} ${yBad-3.4} L ${x-3.4} ${yBad+3.4}`,
      stroke: c.status === "SKIP" ? "var(--muted)" : "var(--err)",
      "stroke-width": 1.6, fill: "none"}));
    pointIndex.push({x, y: yBad, s, t: c.task, c});
  }
  if (bad.length){
    const lbl = el("text", {x: PAD.l + plotW(), y: yBad - 8, "text-anchor": "end",
      fill: "var(--err)", "font-size": 10.5});
    lbl.textContent = bad.length + " cell" + (bad.length === 1 ? "" : "s") +
      " not measured (x = " + (state.status === "all" ? "wrong/skip/error" : "wrong/skip/error") + ")";
    g.appendChild(lbl);
  }

  // --- frame
  g.appendChild(el("rect", {x: PAD.l, y: PAD.t, width: plotW(), height: plotH(),
    fill: "none", stroke: "var(--grid-strong)", "stroke-width": 1}));

  const yl = el("text", {x: 14, y: PAD.t + plotH()/2, "text-anchor": "middle",
    fill: "var(--muted)", "font-size": 11,
    transform: `rotate(-90 14 ${PAD.t + plotH()/2})`});
  yl.textContent = m.label;
  g.appendChild(yl);

  renderLegend();
}

function niceTicks(t0, t1){
  const span = t1 - t0;
  // Never draw more labels than there is room for: a nine-decade log axis has
  // 27 candidates at three per decade, which at 560 px is unreadable.  The
  // labels are dropped, not the grid, so the shape of the data is unaffected.
  const room = Math.max(3, Math.floor(plotH() / 26));
  let cand = [];
  if (state.scale === "log"){
    const a = Math.floor(t0), b = Math.ceil(t1);
    // Prefer 1-2-5 within each decade only when a decade is wide on screen.
    const pxPerDecade = plotH() / Math.max(1e-9, span);
    const mantissas = pxPerDecade >= 90 ? [1, 2, 5] : pxPerDecade >= 40 ? [1, 5] : [1];
    for (let e = a; e <= b; e++){
      for (const m of mantissas){
        const v = Math.log10(m) + e;
        if (v >= t0 - 1e-9 && v <= t1 + 1e-9) cand.push(v);
      }
    }
  } else {
    const step = niceStep(span / 7);
    for (let v = Math.ceil(t0/step)*step; v <= t1; v += step) cand.push(v);
  }
  if (cand.length <= room) return cand;
  const stride = Math.ceil(cand.length / room);
  return cand.filter((_, i) => i % stride === 0);
}
function niceStep(x){
  const e = Math.pow(10, Math.floor(Math.log10(x)));
  const f = x / e;
  return (f <= 1 ? 1 : f <= 2 ? 2 : f <= 5 ? 5 : 10) * e;
}

function renderLegend(){
  const box = document.getElementById("legend");
  box.innerHTML = "";
  const m = metric();
  const q = state.search.trim().toLowerCase();

  // Per-backend view: a flat list, one line per backend, no grouping to do.
  if (state.view === "backend"){
    const list = BACKEND_SERIES.filter(s => matches(s, q)).map(s => ({s, med: seriesMedian(s)}));
    list.sort((a,b) => {
      if (a.med == null && b.med == null) return a.s.name.localeCompare(b.s.name);
      if (a.med == null) return 1;
      if (b.med == null) return -1;
      return a.med - b.med;
    });
    for (const {s, med} of list){
      box.appendChild(legendRow(s, med, false));
    }
    if (!list.length) box.innerHTML = `<div class="note" style="padding:6px">no match</div>`;
    return;
  }

  // Per-toolchain view, grouped by backend: the backend name (and kind) is a
  // heading, its rows nest underneath.  Groups are ordered by their fastest
  // member's median, so the backends that win float to the top, and inside a
  // group the rows keep the same fastest-first order.
  const groups = new Map();
  for (const s of SERIES){
    if (q && !matches(s, q)) continue;
    if (!groups.has(s.backend)) groups.set(s.backend, []);
    groups.get(s.backend).push(s);
  }
  const gList = [];
  for (const [backend, members] of groups){
    members.sort((a,b) => {
      const am = seriesMedian(a), bm = seriesMedian(b);
      if (am == null && bm == null) return a.row.localeCompare(b.row) || a.toolchain.localeCompare(b.toolchain);
      if (am == null) return 1;
      if (bm == null) return -1;
      return am - bm;
    });
    const best = members.reduce((acc,s) => {
      const v = seriesMedian(s);
      return v == null ? acc : (acc == null || v < acc ? v : acc);
    }, null);
    gList.push({backend, members, best});
  }
  gList.sort((a,b) => {
    if (a.best == null && b.best == null) return backendName(a.backend).localeCompare(backendName(b.backend));
    if (a.best == null) return 1;
    if (b.best == null) return -1;
    return a.best - b.best;
  });
  for (const {backend, members, best} of gList){
    const meta = backendMeta(backend);
    const collapsed = state.collapsed.has(backend);
    const allOff = members.every(s => state.hidden.has(s.key));
    const head = document.createElement("div");
    head.className = "lgh";
    head.title = (meta.what || meta.name || backend) + " -- " + members.length + " row(s)";
    head.innerHTML = `<span class="caret">${collapsed ? "\u25B8" : "\u25BE"}</span>` +
      `<span class="sw" style="background:${kindColor(meta.kind)}"></span>` +
      `<span>${esc(backendName(backend))}</span>` +
      `<span class="kd">${esc(meta.kind || "?")}${allOff ? " (off)" : ""}</span>`;
    head.onclick = () => {
      if (collapsed) state.collapsed.delete(backend); else state.collapsed.add(backend);
      renderLegend();
    };
    // A double-click on the heading toggles every row in the group, which is
    // how the reader isolates "all of GCC" without clicking fifteen rows.
    head.ondblclick = evt => {
      evt.stopPropagation();
      if (allOff) for (const s of members) state.hidden.delete(s.key);
      else for (const s of members) state.hidden.add(s.key);
      render();
    };
    box.appendChild(head);
    if (collapsed) continue;
    for (const s of members){
      const row = legendRow(s, seriesMedian(s), true);
      row.classList.add("lgrow");
      box.appendChild(row);
    }
  }
  if (!gList.length) box.innerHTML = `<div class="note" style="padding:6px">no match</div>`;
}
// The median of a series' visible tasks: the legend's sort key.
function seriesMedian(s){
  const vals = TASKS.map(t => valueOf(s.cells.get(t))).filter(v => v != null);
  vals.sort((a,b) => a-b);
  return vals.length ? vals[Math.floor(vals.length/2)] : null;
}
function legendRow(s, med, nested){
  const m = metric();
  const off = state.hidden.has(s.key);
  const row = document.createElement("div");
  row.className = "lg" + (off ? " off" : "");
  row.dataset.key = s.key;
  if (nested){
    const meta = backendMeta(s.backend);
    row.title = s.row + "/" + s.toolchain + " -- backend " + backendName(s.backend) +
      (meta.kind ? " (" + meta.kind + ")" : "");
  }
  const label = nested
    ? `<span class="nm">${esc(s.row)} <span style="color:var(--muted)">${esc(s.toolchain)}</span></span>`
    : `<span class="nm">${esc(s.name)} <span style="color:var(--muted)">${esc(s.kind || "?")}</span></span>`;
  row.innerHTML = `<span class="sw" style="background:${s.color}"></span>` + label +
    `<span class="vl">${med == null ? "--" : (m.unit === "ms" ? fmtMs(med) : fmtBytes(med))}</span>`;
  row.onclick = () => {
    if (state.hidden.has(s.key)) state.hidden.delete(s.key);
    else state.hidden.add(s.key);
    render();
  };
  row.onmouseenter = () => highlight(s.key);
  row.onmouseleave = () => highlight(null);
  return row;
}
function esc(s){ return String(s).replace(/[&<>"]/g, ch => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[ch])); }

function highlight(key){
  for (const old of svg.querySelectorAll(".hl")) old.remove();
  for (const p of svg.querySelectorAll("polyline,circle")){
    p.style.opacity = key == null ? "" : "0.12";
  }
  if (key == null) return;
  const s = seriesByKey(key);
  if (!s) return;
  const pts = [];
  for (const t of TASKS){
    const c = s.cells.get(t);
    const v = c ? valueOf(c) : null;
    const tv = v == null ? null : tf(v);
    if (tv == null) continue;
    pts.push({x: sx(taskIndex.get(t)), y: sy(tv)});
  }
  if (pts.length > 1){
    svg.querySelector("g").appendChild(el("polyline", {
      class: "hl", points: pts.map(p => p.x + "," + p.y).join(" "),
      fill: "none", stroke: s.color, "stroke-width": 3, "stroke-linejoin": "round"}));
  }
}

// ---- interaction -----------------------------------------------------------
function svgPoint(evt){
  const r = svg.getBoundingClientRect();
  const x = (evt.clientX - r.left) / r.width * W;
  const y = (evt.clientY - r.top) / r.height * H;
  return {x, y};
}
svg.addEventListener("wheel", evt => {
  evt.preventDefault();
  const p = svgPoint(evt);
  const f = Math.exp(evt.deltaY * 0.0016);
  const xOnly = evt.shiftKey;
  // keep the data point under the cursor fixed
  const dx = (p.x - PAD.l) / plotW();
  const dy = 1 - (p.y - PAD.t) / plotH();
  const xc = state.x0 + dx * (state.x1 - state.x0);
  const yc = state.y0 + dy * (state.y1 - state.y0);
  const clamp = (v, lo, hi) => Math.max(lo, Math.min(hi, v));
  const nx0 = clamp(xc - (xc - state.x0) * f, -3, TASKS.length + 2);
  const nx1 = clamp(xc + (state.x1 - xc) * f, -3, TASKS.length + 2);
  if (nx1 - nx0 > 0.05){ state.x0 = nx0; state.x1 = nx1; }
  if (!xOnly){
    let ny0 = yc - (yc - state.y0) * f;
    let ny1 = yc + (state.y1 - yc) * f;
    if (ny1 - ny0 > 1e-6){ state.y0 = ny0; state.y1 = ny1; }
  }
  render();
}, {passive: false});

let drag = null;
svg.addEventListener("mousedown", evt => {
  drag = {p: svgPoint(evt), x0: state.x0, x1: state.x1, y0: state.y0, y1: state.y1};
});
window.addEventListener("mousemove", evt => {
  if (drag){
    const p = svgPoint(evt);
    const kx = (state.x1 - state.x0) / plotW();
    const ky = (state.y1 - state.y0) / plotH();
    state.x0 = drag.x0 - (p.x - drag.p.x) * kx;
    state.x1 = drag.x1 - (p.x - drag.p.x) * kx;
    state.y0 = drag.y0 + (p.y - drag.p.y) * ky;
    state.y1 = drag.y1 + (p.y - drag.p.y) * ky;
    render();
    return;
  }
  const p = svgPoint(evt);
  if (p.x < 0 || p.x > W || p.y < 0 || p.y > H){ tip.style.display = "none"; return; }
  let best = null, bd = 1e9;
  for (const q of pointIndex){
    const d = (q.x - p.x) ** 2 + (q.y - p.y) ** 2;
    if (d < bd){ bd = d; best = q; }
  }
  if (!best || bd > 18 * 18){ tip.style.display = "none"; return; }
  const c = best.c, m = metric();
  const em = backendMeta(c.backend || best.s.backend);
  const rows = [
    ["status", c.status + (c.warnings ? " (!)" : "")],
    ["TIME_MS", c.median_ms == null ? "--" : fmtMs(c.median_ms) + " ms"],
    ["wall", c.median_wall_ms == null ? "--" : fmtMs(c.median_wall_ms) + " ms"],
    ["memory", fmtBytes(c.peak_bytes)],
    ["size", fmtBytes(c.artifact_bytes)],
    ["runs", c.runs == null ? "--" : c.runs],
  ];
  if (c._rollup) rows.push(["rows", c._members + " (" + fmtMs(c._min) + "-" + fmtMs(c._max) + " ms)"]);
  if (c.error) rows.push(["error", c.error.slice(0, 120)]);
  const head = c._rollup
    ? `<div class="t">${esc(c.row)} <span style="color:var(--muted)">rollup</span></div>`
    : `<div class="t">${esc(best.s.row)} <span style="color:var(--muted)">${esc(best.s.toolchain)}</span></div>`;
  tip.innerHTML = head +
    `<div style="color:var(--muted);margin-bottom:4px">backend ${esc(em.name || c.backend)}` +
    (em.kind ? " &middot; " + esc(em.kind) : "") + "</div>" +
    `<div style="color:var(--muted);margin-bottom:4px">${esc(best.t)} &middot; ${esc(TASK_TITLES[best.t] || "")}</div>` +
    (c._rollup ? `<div style="color:var(--muted);margin-bottom:4px">median of the rows' medians</div>` : "") +
    rows.map(([k,v]) => `<div class="r"><span>${esc(k)}</span><b>${esc(v)}</b></div>`).join("");
  tip.style.display = "block";
  const box = svg.parentElement.getBoundingClientRect();
  const px = evt.clientX - box.left, py = evt.clientY - box.top;
  tip.style.left = Math.min(px + 14, box.width - 300) + "px";
  tip.style.top = Math.max(4, py - 10) + "px";
});
window.addEventListener("mouseup", () => { drag = null; });
svg.addEventListener("dblclick", () => resetZoom());
svg.addEventListener("mouseleave", () => { tip.style.display = "none"; });

// ---- ranked bars for one task ---------------------------------------------
function renderBars(){
  const m = metric();
  const t = state.task;
  const isBackendView = state.view === "backend";
  document.getElementById("barhead").textContent =
    "Ranked -- " + t + " (" + (TASK_TITLES[t] || "") + "), " + m.label +
    (isBackendView ? " -- backends (median of rows' medians)" : " -- toolchains (backend in grey)");
  const rows = [];
  for (const s of activeSeries()){
    const c = s.cells.get(t);
    if (!c) { rows.push({s, v: null, c: null}); continue; }
    rows.push({s, v: valueOf(c), c});
  }
  const have = rows.filter(r => r.v != null).sort((a,b) => a.v - b.v);
  const missing = rows.filter(r => r.v == null);
  const max = have.length ? have[have.length-1].v : 1;
  const box = document.getElementById("bars");
  box.innerHTML = "";
  let rank = 0;
  for (const r of have){
    rank++;
    const d = document.createElement("div");
    d.className = "bar";
    const w = Math.max(1.5, (state.scale === "log"
      ? (Math.log10(r.v + 1) / Math.log10(max + 1))
      : (r.v / max)) * 100);
    // In toolchain view the label is "row toolchain" with the backend named in
    // grey beside it -- the backend is the fact the bar is really about.
    const nm = isBackendView
      ? `<span class="nm" title="${esc(r.s.name)}">${esc(r.s.name)} <span style="color:var(--muted)">${esc(r.s.kind || "?")}</span></span>`
      : `<span class="nm" title="${esc(r.s.row)}/${esc(r.s.toolchain)} (${esc(backendName(r.s.backend))})">` +
        `${esc(r.s.row)} <span style="color:var(--muted)">${esc(r.s.toolchain)}</span>` +
        `<span style="color:var(--muted)"> \u00b7 ${esc(backendName(r.s.backend))}</span></span>`;
    d.innerHTML = `<span class="rk">${rank}</span>` + nm +
      `<span class="tr"><span class="fl" style="width:${w}%;background:${r.s.color}"></span></span>` +
      `<span class="vl">${m.unit === "ms" ? fmtMs(r.v) + " ms" : fmtBytes(r.v)}</span>`;
    d.onmouseenter = () => highlight(r.s.key);
    d.onmouseleave = () => highlight(null);
    d.onclick = () => { state.isolated = state.isolated === r.s.key ? null : r.s.key; render(); };
    box.appendChild(d);
  }
  for (const r of missing){
    const d = document.createElement("div");
    d.className = "bar bad";
    const nm = isBackendView
      ? `<span class="nm">${esc(r.s.name)}</span>`
      : `<span class="nm">${esc(r.s.row)} <span style="color:var(--muted)">${esc(r.s.toolchain)}</span>` +
        `<span style="color:var(--muted)"> \u00b7 ${esc(backendName(r.s.backend))}</span></span>`;
    d.innerHTML = `<span class="rk"></span>` + nm +
      `<span class="tr"></span><span class="vl" style="color:var(--err)">${r.c ? esc(r.c.status) : "not run"}</span>`;
    box.appendChild(d);
  }
  document.getElementById("barnote").textContent = isBackendView
    ? have.length + " backends with a measurement, " + missing.length + " without."
    : have.length + " toolchains measured, " + missing.length + " not measured or not OK.";
}

// ---- controls --------------------------------------------------------------
function buildTaskPicker(){
  const sel = document.createElement("select");
  sel.id = "taskpick";
  for (const t of TASKS){
    const o = document.createElement("option");
    o.value = t;
    o.textContent = t + " -- " + (TASK_TITLES[t] || "");
    sel.appendChild(o);
  }
  sel.value = state.task;
  sel.onchange = () => { state.task = sel.value; renderBars(); };
  const label = document.createElement("label");
  label.append("Task ", sel);
  const wrap = document.createElement("div");
  wrap.className = "controls";
  wrap.style.marginTop = "8px";
  wrap.appendChild(label);
  const bars = document.getElementById("bars");
  bars.parentElement.insertBefore(wrap, bars);
}

document.getElementById("metric").onchange = e => {
  state.metric = e.target.value; state.yInit = false; fitY(); render(); renderBars();
};
document.getElementById("scale").onchange = e => {
  state.scale = e.target.value; state.yInit = false; fitY(); render(); renderBars();
};
document.getElementById("status").onchange = e => {
  state.status = e.target.value; state.yInit = false; fitY(); render(); renderBars();
};
document.getElementById("view").onchange = e => {
  state.view = e.target.value;
  // Keys are namespaced per view, so an isolation from the other view cannot
  // apply here; hidden flags are kept per view too, so start the new one clean.
  state.isolated = null;
  state.yInit = false; fitY(); render(); renderBars(); updateViewNote();
};
document.getElementById("search").oninput = e => {
  state.search = e.target.value; state.yInit = false; fitY(); render(); renderBars();
};
document.getElementById("reset").onclick = () => resetZoom();
document.getElementById("iso").onclick = () => {
  state.isolated = null; state.hidden.clear(); render();
};

// A one-line reminder of what the current view means, since "per backend" turns
// the rows into something that is not a measurement of any one toolchain.
function updateViewNote(){
  const n = document.getElementById("viewnote");
  if (state.view === "backend"){
    n.textContent = "Per backend: one line per backend, each point the median of " +
      "that backend's rows' medians for the task. Colour is the backend kind. " +
      "GCC and LLVM dominate because they are the same backend behind many front ends.";
  } else {
    n.textContent = "Per toolchain: one line per row/toolchain, coloured by its " +
      "backend's kind. The legend groups rows under their backend.";
  }
}

// ---- boot ------------------------------------------------------------------
function resize(){
  W = Math.max(560, svg.parentElement.clientWidth);
  render();
}
window.addEventListener("resize", resize);

const sub = document.getElementById("sub");
{
  const method = DOC.method || {};
  const counts = DOC.cells.reduce((a,c) => { a[c.status] = (a[c.status]||0)+1; return a; }, {});
  const total = __TOTAL__;
  const done = DOC.cells.length;
  const parts = [
    `<b>${done}</b> of <b>${total}</b> cells in this file`,
    `(${counts.OK || 0} measured, ${counts.SKIP || 0} skipped, ` +
      `${(counts.WRONG||0) + (counts.ERROR||0)} failed)`,
  ];
  if (method.runs) parts.push(method.runs + " timed runs each");
  if (method.pinning) parts.push(method.pinning);
  if (DOC.generated) parts.push("generated " + esc(DOC.generated));
  parts.push(`<b>${BACKEND_SERIES.length}</b> backends`);
  sub.innerHTML = parts.join(" &middot; ");
}
buildTaskPicker();
updateViewNote();
resize();
renderBars();
</script>
</body>
</html>
"""


def load(path):
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def build(doc, tasks, backends=None, backend_of=None):
    """The page, with the measurements and the task list embedded in it.

    `backends` is the registry's backend table and `backend_of` a
    ``"row/toolchain" -> backend id`` map.  The results doc carries both, but an
    older file may not, so the registry copy is embedded as a fallback: a cell
    whose backend is missing is grouped by the registry rather than shown as
    unknown.
    """
    cells = doc.get("cells") or []
    backends = backends or doc.get("backends") or {}
    backend_of = backend_of or {}
    # Only what the page draws: a full cell carries its per-run samples and the
    # resolved command, which would multiply the file size for nothing.
    keep = ("row", "language", "toolchain", "backend", "task", "status",
            "median_ms", "median_wall_ms", "min_ms", "max_ms", "stdev_ms",
            "peak_bytes", "artifact_bytes", "out_bytes", "runs", "check",
            "pinned_cpu", "measured", "self_timed", "warnings", "error")
    slim = [{k: c.get(k) for k in keep if k in c} for c in cells]
    # A cell with no backend at all is filled from the registry here, so the page
    # has one place to fall back and the JS fallback is only for the registry's
    # own gaps.
    for c in slim:
        if not c.get("backend"):
            e = backend_of.get(c.get("row", "") + "/" + c.get("toolchain", ""))
            if e:
                c["backend"] = e
    doc = dict(doc, cells=slim, tasks=tasks, backends=backends)
    reg = dict(backend_of)
    for eid, meta in backends.items():
        reg["#" + eid] = meta
    # The measurements go in last: they are the one part of the page whose text
    # is not ours, so they must not be able to collide with a placeholder that
    # has not been substituted yet.
    return (TEMPLATE
            .replace("__TITLES__", json.dumps(TASK_TITLES, separators=(",", ":")))
            .replace("__TASKS__", json.dumps(tasks))
            .replace("__BACKENDS__", json.dumps(reg, separators=(",", ":")))
            .replace("__COUNT__", str(len(cells)))
            .replace("__TOTAL__", str(len(doc.get("all_cells") or [])))
            .replace("__DATA__", json.dumps(doc, separators=(",", ":"))))


def main():
    ap = argparse.ArgumentParser(description="Chart exec/results.json as a standalone page.")
    ap.add_argument("--json", default=os.path.join(HERE, "results.json"))
    ap.add_argument("--html", default=os.path.join(HERE, "results.html"))
    ap.add_argument("--registry", default=os.path.join(HERE, "cells.json"),
                    help="used only to say how many cells the whole matrix has")
    ap.add_argument("--open", action="store_true", help="open the page when it is written")
    args = ap.parse_args()

    if not os.path.exists(args.json):
        print("no such results file: %s" % args.json, file=sys.stderr)
        print("run `python exec/harness.py` first", file=sys.stderr)
        return 1
    doc = load(args.json)
    tasks = doc.get("tasks") or TASKS
    total = len(doc.get("cells") or [])
    backends = doc.get("backends") or {}
    backend_of = {}
    try:
        # The harness is the authority on how many cells the matrix has: it is
        # the same `expand` that decided what to run, so asking it keeps the
        # "of N" in the page from drifting away from the sweep that filled it.
        sys.path.insert(0, HERE)
        import harness
        reg = load(args.registry)
        tasks = reg.get("tasks", tasks)
        total = len(harness.expand(reg["rows"], tasks))
        # The registry is also the authority on which backend a row/toolchain is:
        # it is where the ids were assigned.  It fills in any cell the results
        # file left without one (a file written before the backend column).
        backends = backends or reg.get("backends", {})
        for row, r in (reg.get("rows") or {}).items():
            for e in r.get("entries", []):
                if e.get("backend"):
                    backend_of[row + "/" + e.get("toolchain", "")] = e["backend"]
    except (OSError, ValueError, KeyError, ImportError, SystemExit):
        pass
    doc["all_cells"] = [None] * total
    html = build(doc, tasks, backends, backend_of)
    with open(args.html, "w", encoding="utf-8") as fh:
        fh.write(html)
    cells = doc.get("cells") or []
    ok = sum(1 for c in cells if c.get("status") == "OK")
    print("%d cells (%d measured) -> %s (%.0f KiB)"
          % (len(cells), ok, args.html, os.path.getsize(args.html) / 1024.0))
    if args.open:
        webbrowser.open("file:///" + os.path.abspath(args.html).replace("\\", "/"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
