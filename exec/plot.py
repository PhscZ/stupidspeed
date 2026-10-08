#!/usr/bin/env python3
"""Turn `exec/results.json` into an interactive chart of the whole matrix.

`exec/harness.py` measures; this reads what it measured and writes one
self-contained HTML file -- the data is embedded in the page, so it opens from
the filesystem with no server and no network.

    python exec/plot.py                 # exec/results.json -> exec/results.html
    python exec/plot.py --open          # ...and open it in the browser
    python exec/plot.py --json other.json --html other.html

The page has two views onto the same numbers:

  * a zoomable multi-series chart -- one line per toolchain, one point per task,
    with wheel zoom, drag to pan, click a legend entry to isolate it, hover for
    the full cell record;
  * a ranked bar chart for a single task, every toolchain sorted, so "which
    language is fastest at task 13" is one glance.

Both read whichever metric is selected (the program's own `TIME_MS`, the
harness's end-to-end wall clock, peak working set, or artifact size), on a log
or linear axis.

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
.bar .nm{width:250px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
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
  <label>Search <input type="text" id="search" placeholder="row or toolchain"></label>
  <button id="reset">Reset zoom</button>
  <button id="iso">Clear isolation</button>
  <span class="spacer"></span>
  <span class="hint">wheel = zoom &middot; shift+wheel = time axis &middot; drag = pan &middot; dbl-click = reset</span>
</div>

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

// ---- series model ----------------------------------------------------------
// One series per (row, toolchain).  Colour is by language so a row's toolchains
// read as a family: same hue, different lightness.
const SERIES = [];
const BY_KEY = new Map();
for (const c of DOC.cells){
  const key = c.row + "/" + c.toolchain;
  let s = BY_KEY.get(key);
  if (!s){
    s = {key, row: c.row, toolchain: c.toolchain, language: c.language || c.row,
         cells: new Map(), toolchainIndex: 0};
    BY_KEY.set(key, s);
    SERIES.push(s);
  }
  s.cells.set(c.task, c);
}
// toolchain order within a row, for the lightness ramp
{
  const seen = new Map();
  for (const s of SERIES){
    const n = seen.get(s.row) || 0;
    s.toolchainIndex = n;
    seen.set(s.row, n + 1);
  }
}
function hue(str){
  let h = 0;
  for (let i = 0; i < str.length; i++) h = (h * 31 + str.charCodeAt(i)) % 360;
  return h;
}
for (const s of SERIES){
  const h = hue(s.row);
  const l = Math.min(72, 44 + s.toolchainIndex * 13);
  s.color = `hsl(${h} 68% ${l}%)`;
}
SERIES.sort((a,b) => a.row.localeCompare(b.row) || a.toolchain.localeCompare(b.toolchain));

const TASKS = DOC.tasks && DOC.tasks.length ? DOC.tasks : __TASKS__;
const taskIndex = new Map(TASKS.map((t,i) => [t,i]));

// ---- state -----------------------------------------------------------------
const state = {
  metric: "speed", scale: "log", status: "ok",
  search: "", hidden: new Set(), isolated: null,
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

function visibleSeries(){
  const q = state.search.trim().toLowerCase();
  return SERIES.filter(s => {
    if (state.isolated && s.key !== state.isolated) return false;
    if (state.hidden.has(s.key)) return false;
    if (q && !(s.row + "/" + s.toolchain).toLowerCase().includes(q)) return false;
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
    if (state.isolated && (c.row + "/" + c.toolchain) !== state.isolated) return false;
    const q = state.search.trim().toLowerCase();
    if (q && !(c.row + "/" + c.toolchain).toLowerCase().includes(q)) return false;
    if (state.hidden.has(c.row + "/" + c.toolchain)) return false;
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
  const visible = SERIES.filter(s => !q || (s.row + "/" + s.toolchain).toLowerCase().includes(q));
  const parts = [];
  // Sort the legend by the median of the series' visible tasks: fastest first,
  // which is the order the reader wants when comparing languages.
  const scored = visible.map(s => {
    const vals = TASKS.map(t => valueOf(s.cells.get(t))).filter(v => v != null);
    vals.sort((a,b) => a-b);
    return {s, med: vals.length ? vals[Math.floor(vals.length/2)] : null};
  });
  scored.sort((a,b) => {
    if (a.med == null && b.med == null) return a.s.row.localeCompare(b.s.row);
    if (a.med == null) return 1;
    if (b.med == null) return -1;
    return a.med - b.med;
  });
  for (const {s, med} of scored){
    const off = state.hidden.has(s.key);
    const row = document.createElement("div");
    row.className = "lg" + (off ? " off" : "");
    row.dataset.key = s.key;
    row.innerHTML = `<span class="sw" style="background:${s.color}"></span>` +
      `<span class="nm">${esc(s.row)} <span style="color:var(--muted)">${esc(s.toolchain)}</span></span>` +
      `<span class="vl">${med == null ? "--" : (m.unit === "ms" ? fmtMs(med) : fmtBytes(med))}</span>`;
    row.onclick = () => {
      if (state.hidden.has(s.key)) state.hidden.delete(s.key);
      else state.hidden.add(s.key);
      render();
    };
    row.onmouseenter = () => highlight(s.key);
    row.onmouseleave = () => highlight(null);
    box.appendChild(row);
  }
  if (!scored.length) box.innerHTML = `<div class="note" style="padding:6px">no match</div>`;
}
function esc(s){ return String(s).replace(/[&<>"]/g, ch => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"}[ch])); }

function highlight(key){
  for (const old of svg.querySelectorAll(".hl")) old.remove();
  for (const p of svg.querySelectorAll("polyline,circle")){
    p.style.opacity = key == null ? "" : "0.12";
  }
  if (key == null) return;
  const s = BY_KEY.get(key);
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
  const rows = [
    ["status", c.status + (c.warnings ? " (!)" : "")],
    ["TIME_MS", c.median_ms == null ? "--" : fmtMs(c.median_ms) + " ms"],
    ["wall", c.median_wall_ms == null ? "--" : fmtMs(c.median_wall_ms) + " ms"],
    ["memory", fmtBytes(c.peak_bytes)],
    ["size", fmtBytes(c.artifact_bytes)],
    ["runs", c.runs == null ? "--" : c.runs],
  ];
  if (c.error) rows.push(["error", c.error.slice(0, 120)]);
  tip.innerHTML = `<div class="t">${esc(best.s.row)} <span style="color:var(--muted)">${esc(best.s.toolchain)}</span></div>` +
    `<div style="color:var(--muted);margin-bottom:4px">${esc(best.t)} &middot; ${esc(TASK_TITLES[best.t] || "")}</div>` +
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
  document.getElementById("barhead").textContent =
    "Ranked -- " + t + " (" + (TASK_TITLES[t] || "") + "), " + m.label;
  const rows = [];
  for (const s of SERIES){
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
    d.innerHTML = `<span class="rk">${rank}</span>` +
      `<span class="nm" title="${esc(r.s.row)}/${esc(r.s.toolchain)}">${esc(r.s.row)} <span style="color:var(--muted)">${esc(r.s.toolchain)}</span></span>` +
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
    d.innerHTML = `<span class="rk"></span>` +
      `<span class="nm">${esc(r.s.row)} <span style="color:var(--muted)">${esc(r.s.toolchain)}</span></span>` +
      `<span class="tr"></span><span class="vl" style="color:var(--err)">${r.c ? esc(r.c.status) : "not run"}</span>`;
    box.appendChild(d);
  }
  document.getElementById("barnote").textContent =
    have.length + " toolchains measured, " + missing.length + " not measured or not OK.";
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
document.getElementById("search").oninput = e => {
  state.search = e.target.value; state.yInit = false; fitY(); render();
};
document.getElementById("reset").onclick = () => resetZoom();
document.getElementById("iso").onclick = () => {
  state.isolated = null; state.hidden.clear(); render();
};

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
  sub.innerHTML = parts.join(" &middot; ");
}
buildTaskPicker();
resize();
renderBars();
</script>
</body>
</html>
"""


def load(path):
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def build(doc, tasks):
    """The page, with the measurements and the task list embedded in it."""
    cells = doc.get("cells") or []
    # Only what the page draws: a full cell carries its per-run samples and the
    # resolved command, which would multiply the file size for nothing.
    keep = ("row", "language", "toolchain", "task", "status", "median_ms",
            "median_wall_ms", "min_ms", "max_ms", "stdev_ms", "peak_bytes",
            "artifact_bytes", "out_bytes", "runs", "check",
            "pinned_cpu", "measured", "self_timed", "warnings", "error")
    slim = [{k: c.get(k) for k in keep if k in c} for c in cells]
    doc = dict(doc, cells=slim, tasks=tasks)
    # The measurements go in last: they are the one part of the page whose text
    # is not ours, so they must not be able to collide with a placeholder that
    # has not been substituted yet.
    return (TEMPLATE
            .replace("__TITLES__", json.dumps(TASK_TITLES, separators=(",", ":")))
            .replace("__TASKS__", json.dumps(tasks))
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
    try:
        # The harness is the authority on how many cells the matrix has: it is
        # the same `expand` that decided what to run, so asking it keeps the
        # "of N" in the page from drifting away from the sweep that filled it.
        sys.path.insert(0, HERE)
        import harness
        reg = load(args.registry)
        tasks = reg.get("tasks", tasks)
        total = len(harness.expand(reg["rows"], tasks))
    except (OSError, ValueError, KeyError, ImportError, SystemExit):
        pass
    doc["all_cells"] = [None] * total
    html = build(doc, tasks)
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
