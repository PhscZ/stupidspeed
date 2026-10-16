#!/usr/bin/env python3
"""Build a self-contained, offline benchmark explorer from results.json.

    python exec/plot.py                 # exec/results.json -> exec/results.html
    python exec/plot.py --open          # also open it in a browser
    python exec/plot.py --json other.json --html other.html

Every toolchain stays individual, with its execution kind shown explicitly. The
overall ranking also aggregates each language's toolchains and can order by rank
sum, mean rank or total suite time. Measured-value bars use the actual value
directly, without an inverse speed transformation; linear and labelled
logarithmic cost views are also available. The registry supplies unmeasured
cells; full records, including samples, remain available in the detail dialog.
No server, external assets or dependencies.
"""
import argparse
import json
import os
import sys
import webbrowser

HERE = os.path.dirname(os.path.abspath(__file__))

TASKS = [
    "01_branches", "02_switch_case", "03_func_sum", "04_array_sum", "05_alloc_churn",
    "06_char_count", "07_string_append", "08_average", "09_fib_recursive", "10_pi",
    "11_parallel_sum", "12_matrix_add", "13_matrix_mul", "14_file_read", "15_file_write",
]
TASK_TITLES = {
    "01_branches": "branch chain", "02_switch_case": "switch/case",
    "03_func_sum": "function calls", "04_array_sum": "array sum",
    "05_alloc_churn": "allocation churn", "06_char_count": "char count",
    "07_string_append": "string append", "08_average": "float average",
    "09_fib_recursive": "recursive fib", "10_pi": "pi spigot",
    "11_parallel_sum": "4 threads", "12_matrix_add": "matrix add",
    "13_matrix_mul": "matrix multiply", "14_file_read": "read 50 MiB",
    "15_file_write": "write 50 MiB",
}

TEMPLATE = r"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>StUpIdSpEeD · Benchmark explorer</title>
<style>
:root{color-scheme:light;--bg:#f2f5fa;--fg:#172438;--muted:#57677d;--border:#d5dfea;
  --surface:#fff;--soft:#eaf0f7;--accent:#215cce;--ok:#18754b;--warn:#925d08;--err:#b62f42;
  --grid:#e6ecf4;--shadow:0 8px 28px #182d4810}
@media(prefers-color-scheme:dark){:root{color-scheme:dark;--bg:#101722;--fg:#e5edf8;--muted:#a1b1c7;
  --border:#2b3a50;--surface:#182232;--soft:#202e42;--accent:#89b4ff;--ok:#76d6ac;--warn:#f5c775;
  --err:#ff9dab;--grid:#27364c;--shadow:0 8px 28px #0002}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:14px/1.5 system-ui,-apple-system,"Segoe UI",sans-serif}
main{max-width:1640px;margin:auto;padding:32px clamp(14px,3vw,48px) 48px}
h1,h2,h3,p{margin:0}h1{font-size:clamp(26px,4vw,40px);letter-spacing:-.045em;line-height:1.2}
h2{font-size:20px;letter-spacing:-.025em}h3{font-size:16px}.eyebrow{text-transform:uppercase;letter-spacing:.16em;font-size:11px;font-weight:750;color:var(--accent);margin-bottom:9px}
.muted,.hint{color:var(--muted)}.hint{font-size:12px}.hero{display:flex;gap:20px;justify-content:space-between;align-items:center;margin-bottom:24px}
.hero p{margin-top:10px;max-width:700px}.offline{border:1px solid var(--border);border-radius:30px;padding:8px 14px;white-space:nowrap;color:var(--muted);font-size:12px}
.stats{display:grid;grid-template-columns:repeat(4,1fr);gap:12px;margin-bottom:22px}.stat{background:var(--surface);border:1px solid var(--border);border-radius:12px;padding:16px 20px}
.stat strong{display:block;font-size:27px;letter-spacing:-.04em;font-variant-numeric:tabular-nums}.stat span{color:var(--muted);font-size:12px}.stat .progress{height:3px;background:var(--soft);margin-top:12px;border-radius:3px;overflow:hidden}.progress i{display:block;height:100%;background:var(--accent)}
.panel{background:var(--surface);border:1px solid var(--border);border-radius:14px;box-shadow:var(--shadow);margin-top:18px;overflow:hidden}
.filters{padding:18px;display:flex;flex-wrap:wrap;gap:14px;align-items:end}.field{display:flex;flex-direction:column;gap:6px;min-width:130px;font-size:12px;font-weight:650;color:var(--muted)}
input,select,button{font:inherit;color:var(--fg)}input,select{width:100%;min-width:0;background:var(--bg);border:1px solid var(--border);border-radius:7px;padding:9px 11px;font-size:13px;font-weight:450}
button{background:var(--surface);border:1px solid var(--border);border-radius:7px;padding:8px 12px;cursor:pointer}button:hover:not(:disabled){border-color:var(--accent);color:var(--accent)}button:disabled{opacity:.45;cursor:default}
:focus-visible{outline:3px solid var(--accent);outline-offset:3px}button.primary{background:var(--accent);color:var(--bg);border-color:var(--accent);font-weight:650}
.toolbar,.section-head,.pager{display:flex;flex-wrap:wrap;gap:12px;align-items:center;justify-content:space-between;padding:16px 20px}.toolbar{border-top:1px solid var(--border);background:var(--soft)}
.actions{display:flex;gap:8px;align-items:center;flex-wrap:wrap}.actions .field{min-width:0}.section-head p{margin-top:3px}.tabs{display:flex;gap:4px;border-bottom:1px solid var(--border);padding:0 20px}
.tabs button{border:0;border-radius:0;background:transparent;padding:15px 16px;color:var(--muted);border-bottom:3px solid transparent;font-weight:650}.tabs button[aria-pressed=true]{color:var(--accent);border-bottom-color:var(--accent)}
.key{display:flex;flex-wrap:wrap;gap:8px 18px;padding:0 20px 15px;font-size:11px;color:var(--muted)}.dot{display:inline-block;width:8px;height:8px;border-radius:50%;margin-right:6px;background:var(--series)}
.caption{padding:0 20px 16px;color:var(--muted);font-size:12px}.table-scroll{overflow:auto;max-height:72vh;overscroll-behavior:contain;scrollbar-gutter:stable;border-top:1px solid var(--border)}
table{border-collapse:separate;border-spacing:0;width:100%;font-variant-numeric:tabular-nums}th{position:sticky;top:0;z-index:2;background:var(--soft);text-align:left;font-size:11px;color:var(--muted);font-weight:650;text-transform:uppercase;letter-spacing:.04em;padding:11px 12px;border-bottom:1px solid var(--border);white-space:nowrap}
td{padding:12px;border-bottom:1px solid var(--border);vertical-align:middle;font-size:13px}tbody tr:last-child td{border-bottom:0}tbody tr:hover{background:var(--soft)}
.rank{width:48px;text-align:right;color:var(--muted)}.identity{width:29%;min-width:240px;max-width:400px}.identity-inner{display:flex;align-items:center;gap:10px;min-width:0}.identity-text{min-width:0;overflow-wrap:anywhere}.identity-text strong{font-size:13px;font-weight:650}.subline{display:block;color:var(--muted);font-size:11px;line-height:1.45;margin-top:3px;overflow-wrap:anywhere}
.leaf{width:27px;flex:none;text-align:center}
.measure{width:220px;min-width:160px}.track{max-width:220px;height:12px;border-radius:4px;background:var(--soft);overflow:hidden;position:relative}.fill{display:block;height:100%;background:var(--series);border-radius:0 4px 4px 0}.bar-meta{margin-top:5px;color:var(--muted);font-size:11px}
.number{text-align:right;white-space:nowrap}.value{font-weight:650}.badge{display:inline-block;border-radius:4px;padding:2px 6px;background:var(--soft);font-size:10px;font-weight:550;color:var(--muted);margin-left:4px}.bad{color:var(--err)}.warning{color:var(--warn)}.good{color:var(--ok)}
.details-button{font-size:12px;padding:6px 9px}.strip{white-space:nowrap}.prank{display:inline-block;min-width:20px;margin-right:2px;padding:1px 3px;border-radius:3px;background:var(--soft);color:var(--muted);font-size:10px;text-align:center;font-variant-numeric:tabular-nums}.prank-none{opacity:.3}.empty{text-align:center;padding:50px 20px;color:var(--muted)}.pager{border-top:1px solid var(--border);font-size:12px;color:var(--muted)}.pager select{width:auto;padding:6px 9px}.pager label{display:flex;gap:7px;align-items:center}
.matrix{min-width:1500px}.matrix .identity{position:sticky;left:0;z-index:1;background:var(--surface);min-width:280px;max-width:340px}.matrix th:first-child{left:0;z-index:3}.matrix th{text-align:right}.matrix th:first-child{text-align:left}.matrix td:not(:first-child){text-align:right;padding:5px}.cell-button{border:0;background:transparent;width:100%;padding:10px 7px;text-align:right;border-radius:5px;font-size:12px}.cell-button small{display:block;color:var(--muted);font-size:10px}.task-heading{border:0;background:transparent;padding:0;color:inherit;text-align:right}.task-heading small{display:block;font-size:10px;font-weight:400;text-transform:none;letter-spacing:0;margin-top:3px}
th .th-sort{border:0;background:transparent;padding:0;font:inherit;color:inherit;text-transform:inherit;letter-spacing:inherit;cursor:pointer;display:inline-flex;align-items:center;gap:3px}th .th-sort:hover{color:var(--accent)}th.active .th-sort{color:var(--accent)}th .arrow{font-style:normal;font-size:9px;line-height:1}
.chart-wrap{padding:8px 16px 16px;overflow:auto}.chart-wrap svg{display:block;width:100%;min-width:650px;touch-action:none;cursor:crosshair}.chart-legend{display:flex;flex-wrap:wrap;gap:8px;padding:0 20px 16px}.chart-legend button{font-size:12px}.chart-legend button[aria-pressed=false]{opacity:.5}
[hidden]{display:none!important}details.method{margin-top:20px;border-top:1px solid var(--border);padding-top:16px;color:var(--muted);font-size:12px}summary{cursor:pointer;font-weight:650}details.method p{margin-top:10px;max-width:1000px}pre{white-space:pre-wrap;overflow-wrap:anywhere;font:12px/1.6 ui-monospace,Consolas,monospace;margin:12px 0 0}
dialog{background:var(--surface);color:var(--fg);border:1px solid var(--border);border-radius:14px;padding:0;width:min(940px,calc(100% - 24px));max-height:90vh;box-shadow:var(--shadow)}dialog::backdrop{background:#070e1db3}dialog .section-head{position:sticky;top:0;background:var(--surface);z-index:4;border-bottom:1px solid var(--border)}.dialog-body{padding:20px}.detail-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin:16px 0}.detail-card{border:1px solid var(--border);border-radius:8px;padding:12px}.detail-card small{display:block;color:var(--muted);margin-bottom:4px}.detail-card strong{overflow-wrap:anywhere}.dialog-body details{margin-top:16px;border-top:1px solid var(--border);padding-top:14px}.dialog-body .table-scroll{max-height:45vh;margin-top:14px}.dialog-body p{margin:8px 0}.notice{border-left:3px solid var(--accent);padding:10px 14px;background:var(--soft);font-size:12px}
@media(min-width:1000px){.filters{position:relative}.rank-table .identity{width:31%}}
@media(max-width:700px){main{padding-top:20px}.hero{display:block}.offline{display:inline-block;margin-top:14px}.stats{grid-template-columns:repeat(2,1fr);gap:8px}.stat{padding:12px}.stat strong{font-size:23px}.filters{padding:14px;gap:12px}.field{flex:1;min-width:135px}.section-head,.toolbar,.pager{padding:14px}.tabs{padding:0 6px}.tabs button{padding:13px 11px}.rank-table{min-width:850px}.table-scroll{max-height:65vh}.detail-grid{grid-template-columns:repeat(2,1fr)}.caption,.key{padding-left:14px;padding-right:14px}}
@media(prefers-reduced-motion:no-preference){button{transition:background .12s,border-color .12s}}
</style>
</head>
<body>
<main>
<header class="hero"><div><div class="eyebrow">The programming language benchmark</div><h1>StUpIdSpEeD<span style="color:var(--accent)">.</span></h1><p class="muted">Different languages. Shared engines. Measured performance.<br>Explore the results without losing the details.</p></div><span class="offline">Self-contained · works offline</span></header>
<section class="stats" id="stats" aria-label="Benchmark coverage"></section>
<section class="panel" aria-label="Report filters">
<div class="filters">
<label class="field">Metric<select id="metric"><option value="speed">Execution time · TIME_MS</option><option value="wall">Wall clock · end to end</option><option value="mem">Peak memory</option><option value="size">Program size</option></select></label>
<label class="field">Include<select id="status"><option value="all">All results</option><option value="ok">Measured</option><option value="bad">Failed / skipped</option><option value="pending">Not run yet</option></select></label>
<label class="field">Engine kind<select id="kind"><option value="all">All kinds</option></select></label>
<button id="clear">Reset filters</button>
</div>
<div class="toolbar"><span class="hint" id="viewnote"></span></div>
</section>
<section class="panel" aria-label="Benchmark results">
<nav class="tabs" aria-label="Result views"><button id="tab-ranking" aria-pressed="true">Task ranking</button><button id="tab-overall" aria-pressed="false">Overall ranking</button><button id="tab-matrix" aria-pressed="false">All-task matrix</button><button id="tab-trends" aria-pressed="false">Compare trends</button></nav>
<div class="section-head"><div><div class="eyebrow" id="section-kicker">Task explorer</div><h2 id="heading"></h2><p class="hint" id="result-count" aria-live="polite"></p></div><div class="actions">
<label class="field" id="task-control">Benchmark task<select id="taskpick"></select></label>
<label class="field" id="bar-control">Bar encoding<select id="encoding"><option value="linear">Measured value · linear</option><option value="log">Measured value · logarithmic</option></select></label>
<label class="field" id="sort-control">Sort by<select id="sort"><option value="value">Best value first</option><option value="name">Name A–Z</option><option value="worst">Worst value first</option></select></label>
<label class="field" id="overall-sort-control" hidden>Order by<select id="overall-sort"><option value="mean">Mean rank · per task</option><option value="sum">Rank sum</option><option value="time">Total suite time</option></select></label>
<label class="field" id="scale-control" hidden>Chart scale<select id="scale"><option value="log">Logarithmic</option><option value="linear">Linear</option></select></label>
<button id="reset-zoom" hidden>Reset zoom</button>
</div></div>
<div class="key" id="kind-key"></div><p class="caption" id="encoding-note"></p>
<div id="ranking-panel"><div class="table-scroll" tabindex="0" role="region" aria-label="Ranked results, scroll for more"><table class="rank-table"><thead><tr><th class="rank">#</th><th>Language / engine</th><th id="bar-axis">Time · shorter is faster</th><th class="number" id="value-heading">Median time</th><th class="number">vs. best</th><th>Record</th></tr></thead><tbody id="bars"></tbody></table></div></div>
<div id="overall-panel" hidden><div class="table-scroll" tabindex="0" role="region" aria-label="Overall ranking of every toolchain, scroll for more"><table class="rank-table"><thead><tr><th class="rank">#</th><th>Language / engine</th><th class="number" id="th-sum" aria-sort="none"><button class="th-sort" data-overall-sort="sum" title="Order by the item's positions added up; lower is better">Rank sum<i class="arrow"></i></button></th><th class="number" id="th-mean" aria-sort="none"><button class="th-sort" data-overall-sort="mean" title="Order by the rank sum divided by the tasks the item covers; lower is better">Mean rank<i class="arrow"></i></button></th><th class="number" id="th-time" aria-sort="none"><button class="th-sort" data-overall-sort="time" title="Order by the item's execution medians added up; lower is better">Suite time<i class="arrow"></i></button></th><th class="number">Typical × best</th><th>Position in each task</th><th>Record</th></tr></thead><tbody id="overall-body"></tbody></table></div></div>
<div id="matrix-panel" hidden><div class="table-scroll" tabindex="0" role="region" aria-label="All tasks, scroll horizontally for more"><table class="matrix"><thead id="matrix-head"></thead><tbody id="matrix-body"></tbody></table></div></div>
<div id="trends-panel" hidden><p class="caption" id="trend-note"></p><div class="chart-wrap"><svg id="chart" role="img" aria-label="Benchmark metrics across tasks. Exact values are available in the all-task matrix."></svg></div><div class="chart-legend" id="legend"></div></div>
<footer class="pager"><span id="page-info" aria-live="polite"></span><div class="actions"><label>Rows per page<select id="page-size"><option value="25">25</option><option value="50">50</option><option value="100">100</option><option value="all" selected>All</option></select></label><button id="prev">Previous</button><button id="next">Next</button></div></footer>
</section>
<details class="method"><summary>How to read these results & measurement context</summary><p>Every value is specific to one benchmark task. Lower time, memory and size are better; these are not an overall language score. The overall ranking tab adds positions across tasks, which is a different question from any single task's numbers. A language's entry there aggregates its toolchains, so it summarises several programs rather than measuring one; open its details to see which toolchains contributed.</p><p>Bars show the measured value directly: a longer bar means a larger time, memory use or artifact size. Linear bars start at zero: 20 ms has twice the length of 10 ms. No minimum bar width is imposed. Logarithmic bars compress differences and must not be read as proportional cost. The “vs. best” column is a separate ratio to the smallest positive matching value; larger ratios mean more time, memory or bytes.</p><p>“Wall fallback” means the program did not supply a self-timed measurement; process startup may be included. Mixed-source group summaries are flagged. Failed, skipped, not-run and unsupported cells are distinct and never counted as zero. “OK” is the recorded harness status, not a claim that correctness was checked; see each record for its check flag.</p><p id="method-summary"></p><details><summary>Full file metadata</summary><pre id="metadata"></pre></details></details>
</main>
<dialog id="detail" aria-labelledby="detail-title"><header class="section-head"><div><div class="eyebrow">Measurement inspector</div><h2 id="detail-title"></h2></div><button id="close-detail" aria-label="Close measurement details">Close</button></header><div class="dialog-body" id="detail-body"></div></dialog>
<script>
"use strict";
const DOC = __DATA__;
const TASK_TITLES = __TITLES__;
const TASKS = DOC.tasks;
const $ = id => document.getElementById(id);
function esc(s){return String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
function group(n){return n.toLocaleString('en-US');}
function fmtMs(v){
  if(v==null)return '—';
  if(v===0)return '0';
  return v>=10000?v.toLocaleString('en-US',{maximumFractionDigits:1}):Number(v.toPrecision(5)).toLocaleString('en-US',{maximumSignificantDigits:5});
}
function fmtBytes(v){if(v==null)return '—';const units=['B','KiB','MiB','GiB','TiB'];let i=0;while(v>=1024&&i<units.length-1){v/=1024;i++;}return fmtMs(v)+' '+units[i];}
const METRICS={speed:{field:'median_ms',label:'Execution time',fmt:v=>fmtMs(v)+' ms'},wall:{field:'median_wall_ms',label:'Wall clock',fmt:v=>fmtMs(v)+' ms'},mem:{field:'peak_bytes',label:'Peak memory',fmt:fmtBytes},size:{field:'artifact_bytes',label:'Program size',fmt:fmtBytes}};
const KIND_COLORS={'native-aot':'#438ee8','native-jit':'#dc8a35','bytecode-vm':'#a77ade','interpreter':'#36ad8c','wasm-runtime':'#d975ab','assembler':'#beac46'};
const KIND_NAMES={'native-aot':'Native · AOT','native-jit':'Native · JIT','bytecode-vm':'Bytecode VM','interpreter':'Interpreter','wasm-runtime':'WebAssembly','assembler':'Assembly'};
const BACKENDS=DOC.backends||{};
const meta=id=>BACKENDS[id]||{name:id==='?'?'Unknown engine':id,kind:'unknown'};
const color=s=>KIND_COLORS[meta(s.backend).kind]||'#8b98aa';
const kindName=s=>KIND_NAMES[meta(s.backend).kind]||meta(s.backend).kind||'Unknown kind';
const keyOf=c=>c.row+'/'+c.toolchain;
const SERIES=new Map();
for(const c of [...(DOC.expected||[]),...DOC.cells]){
  const key=keyOf(c);let s=SERIES.get(key);
  if(!s){s={key,row:c.row,language:c.language||c.row,toolchain:c.toolchain,backend:c.backend||'?',cells:new Map(),engines:new Map()};SERIES.set(key,s);}
  if(c.language)s.language=c.language;
  s.cells.set(c.task,c);
}
// A front end usually runs on one engine, but not always: luau hands twelve tasks
// to its own VM and three to Lute. The engine counts come from the merged cells --
// not from the records as they stream in, or a registry placeholder and its
// measurement would both count -- and the dominant engine gives the front end its
// kind and colour. The others stay visible in its own listing.
for(const s of SERIES.values()){
  for(const c of s.cells.values())if(c.backend)s.engines.set(c.backend,(s.engines.get(c.backend)||0)+1);
  const ranked=[...s.engines].sort((a,b)=>b[1]-a[1]||meta(a[0]).name.localeCompare(meta(b[0]).name));
  if(ranked.length)s.backend=ranked[0][0];
  s.span=ranked.length>1;
}
const engineList=s=>[...s.engines].sort((a,b)=>b[1]-a[1]||meta(a[0]).name.localeCompare(meta(b[0]).name))
  .map(([id,count])=>meta(id).name+(s.engines.size>1?' ('+count+')':'')).join(' + ');
const ALL=[...SERIES.values()];
const state={metric:'speed',status:'all',kind:'all',task:TASKS[0],encoding:'linear',sort:'value',overallSort:'mean',tab:'ranking',page:0,pageSize:Infinity,scale:'log'};
let pageEntries=[],detailTask=null;
function numeric(v){return typeof v==='number'&&Number.isFinite(v)&&v>=0;}
function rawValue(c){if(!c||c.status!=='OK')return null;const f=METRICS[state.metric].field;const v=f==='median_ms'?(c.median_ms??c.median_wall_ms):c[f];return numeric(v)?v:null;}
function fallback(c){return c&&c.status==='OK'&&(c.self_timed===false||c.median_ms==null&&numeric(c.median_wall_ms));}
function statusOf(c){return c?c.status:'N/A';}
function statusMatch(c){if(state.status==='all')return true;if(state.status==='ok')return c?.status==='OK';if(state.status==='pending')return c?.status==='NOT RUN';return !!c&&!['OK','NOT RUN'].includes(c.status);}
function matches(s){return state.kind==='all'||meta(s.backend).kind===state.kind;}
function median(vals){if(!vals.length)return null;const a=[...vals].sort((a,b)=>a-b),i=Math.floor(a.length/2);return a.length%2?a[i]:(a[i-1]+a[i])/2;}
function summarize(s,t){
  const c=s.cells.get(t),v=rawValue(c);
  return {v,c,status:statusOf(c),count:v==null?0:1,fallbacks:fallback(c)?1:0};
}
function entriesFor(t){
  // A task absent from `s.cells` is one the registry does not give this
  // toolchain at all -- removed, or never supported -- as distinct from one that
  // is registered and merely unmeasured (which carries a NOT RUN placeholder).
  // Those are not results, so they are never listed against that task.
  return ALL.filter(s=>matches(s)&&(t
    ? s.cells.has(t)&&statusMatch(s.cells.get(t))
    : [...s.cells.keys()].some(task=>statusMatch(s.cells.get(task)))));
}
const nameOf=e=>e.language;
function compare(a,b){
  const av=summarize(a,state.task).v,bv=summarize(b,state.task).v;
  if(state.sort!=='name'){
    if(av==null&&bv!=null)return 1;if(bv==null&&av!=null)return -1;
    if(av!=null&&bv!=null&&av!==bv)return (av-bv)*(state.sort==='worst'?-1:1);
  }
  return nameOf(a).localeCompare(nameOf(b))||a.key.localeCompare(b.key);
}
function labelHTML(e){
  const description=e.toolchain+' · '+(e.span?engineList(e):meta(e.backend).name)+(e.row!==e.language.toLowerCase()?' · '+e.row:'');
  const badge=e.span?engineList(e):kindName(e);
  return `<div class="identity-inner"><span class="leaf"><i class="dot" style="--series:${color(e)}"></i></span><div class="identity-text"><strong>${esc(nameOf(e))}</strong>
    <span class="badge"${e.span?' title="this toolchain\'s tasks are split across these engines; each cell names the one that ran it"':''}>${esc(badge)}</span><span class="subline">${esc(description)}</span></div></div>`;
}
function sourceLabel(info){
  if(state.metric!=='speed'||!info.fallbacks)return '';
  return info.fallbacks===info.count?'wall fallback':'mixed timing sources';
}
function statusLabel(info){if(info.v!=null)return '';return info.status==='OK'?'No metric':info.status==='NOT RUN'?'Not run':info.status==='N/A'?'—':info.status;}
function valueHTML(info){
  if(info.v==null)return `<span class="${['NOT RUN','N/A','OK'].includes(info.status)?'muted':'bad'}"${info.status==='N/A'?' title="this toolchain does not cover this task"':''}>${esc(statusLabel(info))}</span>`;
  const note=sourceLabel(info);
  return `<span class="value">${esc(METRICS[state.metric].fmt(info.v))}</span>${note?`<small class="subline warning">${note}</small>`:''}${info.c?.warnings?'<small class="subline warning">Warnings</small>':''}`;
}
function basis(t){
  const vals=ALL.filter(s=>matches(s)&&statusMatch(s.cells.get(t))).map(s=>rawValue(s.cells.get(t))).filter(v=>v!=null);
  const positive=vals.filter(v=>v>0);
  return {best:positive.length?Math.min(...positive):null,max:vals.length?Math.max(...vals):0};
}
function barWidth(v,b){
  if(v==null||!b.max)return 0;
  return 100*(state.encoding==='log'?Math.log1p(v)/Math.log1p(b.max):v/b.max);
}
function rankingRow(e,index,b){
  const info=summarize(e,state.task),v=info.v;
  const ratio=v>0&&b.best!=null?v/b.best:null;
  const fmtRatio=n=>n.toLocaleString('en-US',{maximumSignificantDigits:3});
  const amount=state.encoding==='log'?'Logarithmic value':'Measured value';
  const zeroNote=['speed','wall'].includes(state.metric)
    ?'Recorded zero · below timer resolution; speed ratio unavailable':'Recorded zero';
  const metaText=v===0?zeroNote:amount;
  return `<tr data-key="${esc(e.key)}">
    <td class="rank">${v==null?'—':index}</td>
    <td class="identity">${labelHTML(e)}</td>
    <td class="measure"><div class="track" aria-label="${esc(v==null?statusLabel(info):amount)}">
      <i class="fill" style="width:${barWidth(v,b)}%;--series:${color(e)}"></i></div>
      <div class="bar-meta">${esc(v==null?statusLabel(info):metaText)}</div></td>
    <td class="number">${valueHTML(info)}</td>
    <td class="number muted">${ratio==null?'—':fmtRatio(ratio)+'×'}
      ${ratio!=null?'<small class="subline">'+(['speed','wall'].includes(state.metric)?'time':'value')+'</small>':''}</td>
    <td><button class="details-button" data-detail="${esc(e.key)}" data-task="${esc(state.task)}">Details</button></td></tr>`;
}
function renderRanking(entries,offset){
  const b=basis(state.task);
  let rank=offset;
  $('bars').innerHTML=entries.length?entries.map(e=>rankingRow(e,state.sort==='value'?++rank:'—',b)).join('')
    :'<tr><td colspan="6" class="empty">No results match these filters. Try another task or reset the filters.</td></tr>';
  $('bar-axis').textContent=state.encoding==='log'?'Value · logarithmic':['speed','wall'].includes(state.metric)?'Time · shorter is faster':'Value · shorter is better';
  $('value-heading').textContent=METRICS[state.metric].label;
}
function renderMatrix(entries){
  $('matrix-head').innerHTML='<tr><th>Language / engine</th>'+TASKS.map(t=>`<th><button class="task-heading" data-task-switch="${esc(t)}" title="Rank ${esc(t)}">${esc(t.split('_')[0])}<small>${esc(TASK_TITLES[t]||t)}</small></button></th>`).join('')+'</tr>';
  $('matrix-body').innerHTML=entries.length?entries.map(e=>`<tr><td class="identity">${labelHTML(e)}</td>${TASKS.map(t=>{const info=summarize(e,t);return `<td><button class="cell-button" data-detail="${esc(e.key)}" data-task="${esc(t)}" aria-label="${esc(nameOf(e)+' · '+t)}">${valueHTML(info)}</button></td>`;}).join('')}</tr>`).join(''):'<tr><td colspan="'+(TASKS.length+1)+'" class="empty">No matching toolchains.</td></tr>';
}

// ---- overall ranking -------------------------------------------------------
// One item per front end -- a language plus the toolchain that builds or runs it,
// which is what the matrix measures -- over whatever the filters above leave.
// Nothing is rolled up: `C`/`gcc`, `C`/`clang` and `C`/`msvc` are three items, and
// no entry stands for all of C.
//
// Positions are per task, taken among the filtered front ends: position 1 is the
// fastest of them in that task, ties share the better position. The rank sum adds
// an item's positions, the mean rank divides by the tasks it actually covers and
// the suite time adds its execution medians. The three column headings are the
// ordering control; mean rank is the default. For an item measured on all fifteen
// tasks the sum and the mean order identically -- the mean is the sum over a
// constant 15 -- but the two part company in the incomplete tail, where an item
// covering twelve tasks has twelve positions to add and divide.
//
// Only complete items are ranked -- all fifteen tasks measured. A sum of positions
// rewards missing work: an entry that never ran the slow tasks would place above
// one that ran them all. Incomplete items are listed after the ranked ones with
// their coverage, and the matrix puts them last for the same reason.
let OVERALL=null;
function speedValue(c){
  if(!c||c.status!=='OK')return null;
  const v=numeric(c.median_ms)?c.median_ms:numeric(c.median_wall_ms)?c.median_wall_ms:null;
  return v;
}
// The whole suite on one front end: its fifteen execution medians added up. This
// is the metric selector's "speed" column whatever the rest of the page shows,
// because a total suite *time* is what the ordering option means.
function suiteTime(series){
  let sum=0,any=false;
  for(const s of series)for(const c of s.cells.values()){
    const v=speedValue(c);
    if(v==null)continue;
    sum+=v;any=true;
  }
  return any?sum:null;
}
function computeOverall(){
  const base=ALL.filter(s=>matches(s)&&[...s.cells.values()].some(statusMatch));
  const value=(s,t)=>{const c=s.cells.get(t);return c&&statusMatch(c)?rawValue(c):null;};
  const ranks=new Map(),best={};
  for(const t of TASKS){
    const vals=base.map(s=>({s,v:value(s,t)})).filter(x=>x.v!=null).sort((a,b)=>a.v-b.v);
    let i=0;
    while(i<vals.length){
      let j=i;
      while(j+1<vals.length&&vals[j+1].v===vals[i].v)j++;
      for(let k=i;k<=j;k++)ranks.set(vals[k].s.key+'|'+t,i+1);
      i=j+1;
    }
    const pos=vals.map(x=>x.v).filter(v=>v>0);
    best[t]=pos.length?Math.min(...pos):null;
  }
  // `measured`/`total` is what completeness is judged on -- never the series' own
  // `cells` map -- and `terms` is how many positions the rank sum added.
  const items=base.map(s=>{
    const per=TASKS.map(t=>ranks.has(s.key+'|'+t)?ranks.get(s.key+'|'+t):null);
    const ratios=TASKS.map(t=>{const v=value(s,t);return v!=null&&v>0&&best[t]?v/best[t]:null;}).filter(x=>x!=null);
    const covered=per.filter(r=>r!=null).length;
    return {key:s.key,name:nameOf(s),s,per,terms:covered,measured:covered,total:TASKS.length,
            sum:per.reduce((a,r)=>a+(r??0),0),suite:suiteTime([s]),factor:median(ratios)};
  });
  for(const r of items){
    r.complete=r.measured===r.total;
    r.mean=r.terms?r.sum/r.terms:null;
  }
  const field=state.overallSort==='sum'?'sum':state.overallSort==='time'?'suite':'mean';
  items.sort((a,b)=>{
    if(a.complete!==b.complete)return a.complete?-1:1;
    if(a.complete&&b.complete&&a[field]!==b[field])return a[field]-b[field];
    if(a.measured!==b.measured)return b.measured-a.measured;
    const af=a.factor??Infinity,bf=b.factor??Infinity;
    if(af!==bf)return af-bf;
    return a.name.localeCompare(b.name)||a.key.localeCompare(b.key);
  });
  let n=0;
  for(const r of items)r.position=r.complete?++n:null;
  return (OVERALL={items,order:items,byKey:new Map(items.map(r=>[r.key,r]))});
}
// The matrix follows the overall ranking row for row, including the incomplete
// entries at the end, so the two tabs never disagree about order.
function matrixOrder(entries,overall){
  const place=new Map(overall.order.map((r,i)=>[r.key,i]));
  return [...entries].sort((a,b)=>{
    const pa=place.has(a.key)?place.get(a.key):Infinity,pb=place.has(b.key)?place.get(b.key):Infinity;
    if(pa!==pb)return pa-pb;
    return nameOf(a).localeCompare(nameOf(b))||a.key.localeCompare(b.key);
  });
}
function renderOverall(entries){
  $('overall-body').innerHTML=entries.length?entries.map(it=>{
    const first=TASKS[it.per.findIndex(p=>p!=null)]||TASKS[0];
    const strip=TASKS.map((t,i)=>{
      const p=it.per[i];
      if(p==null)return `<span class="prank prank-none" title="${esc(t+' \u00b7 no measurement')}">\u00b7</span>`;
      const v=rawValue(it.s.cells.get(t));
      const title=t+' \u00b7 position '+p+(v!=null?' \u00b7 '+METRICS[state.metric].fmt(v):'');
      return `<span class="prank" title="${esc(title)}">${p}</span>`;
    }).join('');
    const identity=`<strong>${esc(it.name)}</strong>
         <span class="badge"${it.s.span?' title="this toolchain\'s tasks are split across these engines; each cell names the one that ran it"':''}>${esc(it.s.span?engineList(it.s):kindName(it.s))}</span>
         <span class="subline">${esc(it.s.toolchain+' \u00b7 '+(it.s.span?engineList(it.s):meta(it.s.backend).name))}</span>`;
    return `<tr data-key="${esc(it.key)}">
      <td class="rank">${it.position??'\u2014'}</td>
      <td class="identity"><div class="identity-inner"><span class="leaf"><i class="dot" style="--series:${color(it.s)}"></i></span><div class="identity-text">${identity}</div></div></td>
      <td class="number">${it.complete?it.sum:'\u2014'}</td>
      <td class="number">${it.mean==null?'\u2014':it.mean.toLocaleString('en-US',{maximumFractionDigits:2})}</td>
      <td class="number">${it.suite==null?'\u2014':fmtMs(it.suite)+' ms'}</td>
      <td class="number">${it.factor==null?'\u2014':it.factor.toLocaleString('en-US',{maximumSignificantDigits:3})+'\u00d7'}</td>
      <td class="strip">${strip}</td>
      <td><button class="details-button" data-detail="${esc(it.key)}" data-task="${esc(first)}">Details</button></td></tr>`;
  }).join(''):'<tr><td colspan="8" class="empty">No results match these filters.</td></tr>';
}
// The three orderings are the three columns; the headings are the control.
function syncOverallSort(){
  for(const [key,id]of [['sum','th-sum'],['mean','th-mean'],['time','th-time']]){
    const th=$(id),active=state.overallSort===key;
    th.classList.toggle('active',active);
    th.setAttribute('aria-sort',active?'ascending':'none');
    th.querySelector('.arrow').textContent=active?'\u25b2':'';
  }
  $('overall-sort').value=state.overallSort;
}
let chartHidden=new Set(),chartDomain=null,chartBase=null,chartGeometry=null;
const NS='http://www.w3.org/2000/svg';
function svgEl(tag,attrs,text){const e=document.createElementNS(NS,tag);for(const [k,v]of Object.entries(attrs))e.setAttribute(k,v);if(text!=null)e.textContent=text;return e;}
function drawTrends(entries){
  const svg=$('chart');svg.replaceChildren();
  const visible=entries.filter(e=>!chartHidden.has(e.key));
  const transform=v=>v==null||state.scale==='log'&&v<=0?null:state.scale==='log'?Math.log10(v):v;
  const points=visible.map(e=>({e,pts:TASKS.map((t,i)=>({t,i,v:summarize(e,t).v})).map(p=>({...p,y:transform(p.v)}))}));
  const values=points.flatMap(s=>s.pts.map(p=>p.y)).filter(v=>v!=null);
  let lo=values.length?Math.min(...values):0,hi=values.length?Math.max(...values):1;
  if(state.scale==='linear')lo=0;if(hi===lo)hi=lo+1;
  chartBase={x0:-.25,x1:Math.max(.75,TASKS.length-.75),y0:lo-(hi-lo)*.06,y1:hi+(hi-lo)*.06};
  const d=chartDomain||chartBase,W=Math.max(680,svg.parentElement.clientWidth-32),H=400,P={l:100,r:20,t:15,b:48},pw=W-P.l-P.r,ph=H-P.t-P.b;
  chartGeometry={W,H,P,pw,ph};svg.setAttribute('viewBox',`0 0 ${W} ${H}`);svg.setAttribute('height',H);
  const x=i=>P.l+(i-d.x0)/(d.x1-d.x0)*pw,y=v=>P.t+ph-(v-d.y0)/(d.y1-d.y0)*ph;
  const defs=svgEl('defs',{}),clip=svgEl('clipPath',{id:'plot-clip'});clip.append(svgEl('rect',{x:P.l,y:P.t,width:pw,height:ph}));defs.append(clip);svg.append(defs);
  for(let i=0;i<=6;i++){const v=d.y0+(d.y1-d.y0)*i/6,py=y(v),actual=state.scale==='log'?10**v:v;svg.append(svgEl('line',{x1:P.l,x2:W-P.r,y1:py,y2:py,stroke:'var(--grid)'}));svg.append(svgEl('text',{x:P.l-10,y:py+4,fill:'var(--muted)','font-size':11,'text-anchor':'end'},METRICS[state.metric].fmt(actual)));}
  TASKS.forEach((t,i)=>{if(x(i)<P.l||x(i)>W-P.r)return;svg.append(svgEl('text',{x:x(i),y:H-20,fill:'var(--muted)','font-size':11,'text-anchor':'middle'},t.split('_')[0]));});
  const g=svgEl('g',{'clip-path':'url(#plot-clip)'});svg.append(g);
  for(const {e,pts}of points){let path='';let gap=true;for(const p of pts){if(p.y==null){gap=true;continue;}path+=(gap?'M':'L')+x(p.i)+' '+y(p.y)+' ';gap=false;}g.append(svgEl('path',{d:path,fill:'none',stroke:color(e),'stroke-width':1.8,'stroke-opacity':.75}));for(const p of pts){if(p.y==null)continue;const dot=svgEl('circle',{cx:x(p.i),cy:y(p.y),r:3,fill:color(e)});dot.append(svgEl('title',{},nameOf(e)+' · '+p.t+' · '+METRICS[state.metric].fmt(p.v)));dot.addEventListener('click',()=>openDetail(e,p.t));g.append(dot);}}
  if(!values.length)svg.append(svgEl('text',{x:W/2,y:H/2,fill:'var(--muted)','text-anchor':'middle','font-size':14},'No plottable values. See the matrix for statuses and zero timings.'));
  $('legend').innerHTML=visible.map(e=>`<button data-chart-key="${esc(e.key)}" aria-pressed="${!chartHidden.has(e.key)}"><i class="dot" style="--series:${color(e)}"></i>${esc(nameOf(e))} · ${esc(e.toolchain)} · ${esc(kindName(e))}</button>`).join('');
  $('trend-note').textContent=`${visible.length} series on this page. Use a smaller page size to compare fewer lines; click a legend item to hide it. Wheel to zoom, drag to pan, double-click to reset. Missing values break lines; zero values are omitted on a log axis. Click a point for its record.`;
}
function render(){
  const forTask=state.tab==='ranking'?state.task:null;
  const overall=computeOverall();
  let entries;
  if(state.tab==='overall')entries=overall.items;
  else if(state.tab==='matrix')entries=matrixOrder(entriesFor(null),overall);
  else entries=[...entriesFor(forTask)].sort(compare);
  const size=state.pageSize===Infinity?Math.max(1,entries.length):state.pageSize;
  state.page=Math.max(0,Math.min(state.page,Math.ceil(entries.length/size)-1));
  const offset=state.page*size;pageEntries=entries.slice(offset,offset+size);
  $('viewnote').textContent=state.tab==='overall'
    ?'Languages and front ends share one ranking, over the entries the filters above leave.'
    :'Every language / toolchain is shown separately, including its execution kind.';
  $('heading').textContent=state.tab==='ranking'?(TASK_TITLES[state.task]||state.task||'No tasks'):state.tab==='overall'?'Overall ranking':state.tab==='matrix'?'Every task, every result':'Performance across tasks';
  $('section-kicker').textContent=state.tab==='ranking'?'Task '+(state.task||'').split('_')[0]:state.tab==='overall'?'Whole suite':state.tab==='matrix'?'Complete matrix':'Cross-task comparison';
  const matched=ALL.filter(matches),ok=matched.filter(s=>rawValue(s.cells.get(state.task))!=null).length;
  const rankedCount=overall.items.filter(r=>r.complete).length;
  $('result-count').textContent=state.tab==='overall'
    ?`${rankedCount} toolchains ranked on all ${TASKS.length} tasks · `+
     `${entries.length-rankedCount} incomplete · ${METRICS[state.metric].label.toLowerCase()}`
    :`${entries.length} toolchains · ${ok} with ${METRICS[state.metric].label.toLowerCase()} for the selected task`;
  for(const mode of ['ranking','overall','matrix','trends']){$(mode+'-panel').hidden=mode!==state.tab;$('tab-'+mode).setAttribute('aria-pressed',mode===state.tab);}
  $('bar-control').hidden=state.tab!=='ranking';
  $('task-control').hidden=$('sort-control').hidden=state.tab==='overall';
  $('overall-sort-control').hidden=state.tab!=='overall';
  $('scale-control').hidden=$('reset-zoom').hidden=state.tab!=='trends';
  const baseline=state.encoding==='linear'
    ?'Bars use the measured value directly, scaled from zero to the largest matching value. Longer means a larger value; for time, longer means slower.'
    :'Logarithmic bars = log(1 + value) ÷ log(1 + largest value). Longer still means a larger value, but the visual is compressed and not proportional.';
  const note=state.tab==='overall'?''
    :state.tab==='ranking'
    ?baseline+' The scale is shared across pages. Exact values and ratios to the smallest positive matching value remain visible.'
    :state.tab==='matrix'
      ?'Click a value for its full record or a task heading to rank it. Sorting uses the selected task. Status filters select rows with a matching cell; other task statuses remain visible.'
      :'Tasks are separate workloads, not a cumulative score. Each metric has its own units.';
  $('encoding-note').textContent=note;
  $('encoding-note').hidden=!note;
  $('page-info').textContent=entries.length?`${offset+1}–${Math.min(offset+size,entries.length)} of ${entries.length} rows`:'0 matching results';
  $('prev').disabled=state.page===0;$('next').disabled=offset+size>=entries.length;
  if(state.tab==='ranking')renderRanking(pageEntries,offset);else if(state.tab==='overall'){renderOverall(pageEntries);syncOverallSort();}else if(state.tab==='matrix')renderMatrix(pageEntries);else drawTrends(pageEntries);
}
function findEntry(key){
  // Every overall-ranking key is a series key, so the series lookup answers for
  // both tabs; the ranking fallback only covers a row hidden by the filters.
  return SERIES.get(key)||entriesFor(state.tab==='ranking'?state.task:null).find(e=>e.key===key);
}
function card(label,value){return `<div class="detail-card"><small>${esc(label)}</small><strong>${esc(value)}</strong></div>`;}
function openDetail(entry,t){
  if(!entry)return;
  detailTask=t;
  // Which engine ran *this* task, which is not always the front end's dominant
  // one: luau's three file/process tasks go to Lute.
  const cell=entry.cells&&entry.cells.get(t);
  const engineId=(cell&&cell.backend)||entry.backend;
  const engine=`${meta(engineId).name} · ${meta(engineId).what||''}`;
  $('detail-title').textContent=nameOf(entry)+' · '+(TASK_TITLES[t]||t);
  const head=`<p class="muted">${esc(t)} · ${esc(engine)}</p>`;
  const c=entry.cells.get(t);
  if(!c||c.status==='NOT RUN'){
    $('detail-body').innerHTML=head+'<p class="notice">'+(c
      ?'This cell is registered, but there is no measurement in this results file.'
      :'This toolchain does not cover this task in the available results or registry.')+'</p>';
  }else{
    const timing=!numeric(c.median_ms)&&!numeric(c.median_wall_ms)?'No timing recorded'
      :fallback(c)?'Wall-clock fallback (includes startup)'
      :c.self_timed===true?'Program self timing':'Timing source not recorded';
    const samples=c.samples||[];
    const sampleRows=samples.map((s,i)=>`<tr><td>${i+1}</td>
      <td class="number">${numeric(s.time_ms)?fmtMs(s.time_ms)+' ms':'—'}</td>
      <td class="number">${numeric(s.wall_ms)?fmtMs(s.wall_ms)+' ms':'—'}</td>
      <td class="number">${fmtBytes(s.peak_bytes)}</td>
      <td>${esc(s.exit??'—')}${s.timeout?' · timeout':''}</td></tr>`).join('');
    $('detail-body').innerHTML=head+
      '<p>'+esc(entry.row+' / '+entry.toolchain)+' · <b>'+esc(c.status)+'</b></p><div class="detail-grid">'+
      card('Recorded execution median',numeric(c.median_ms)?fmtMs(c.median_ms)+' ms':'—')+
      card('Wall-clock median',numeric(c.median_wall_ms)?fmtMs(c.median_wall_ms)+' ms':'—')+
      card('Timing source',c.status==='OK'?timing:'No successful timing')+
      card('Peak memory',fmtBytes(c.peak_bytes))+card('Artifact size',fmtBytes(c.artifact_bytes))+
      card('Runs',c.runs??'—')+card('Min / max execution',fmtMs(c.min_ms)+' / '+fmtMs(c.max_ms)+' ms')+
      card('Standard deviation',fmtMs(c.stdev_ms)+' ms')+
      card('Correctness checked',c.check===true?'Yes':c.check===false?'No':'Not recorded')+'</div>'+
      '<p class="hint">Measured '+esc(c.measured||'date not recorded')+' · pinned CPU '+esc(c.pinned_cpu??'not recorded')+'</p>'+
      (c.warnings?'<p class="warning">Warnings: '+esc(typeof c.warnings==='string'?c.warnings:JSON.stringify(c.warnings))+'</p>':'')+
      (c.error?'<p class="bad">'+esc(c.error)+'</p>':'')+
      '<details open><summary>Per-run samples ('+samples.length+')</summary>'+
      '<div class="table-scroll"><table><thead><tr><th>Run</th><th class="number">TIME_MS</th>'+
      '<th class="number">Wall clock</th><th class="number">Peak memory</th><th>Exit / timeout</th></tr></thead>'+
      '<tbody>'+sampleRows+'</tbody></table></div></details>'+
      '<details><summary>Full record · commands, output and all sample fields</summary><pre>'+esc(JSON.stringify(c,null,2))+'</pre></details>';
  }
  if(!$('detail').open)$('detail').showModal();
  $('detail').scrollTop=0;
}
$('close-detail').onclick=()=>$('detail').close();
document.addEventListener('click',e=>{
  const detail=e.target.closest('[data-detail]');if(detail){openDetail(findEntry(detail.dataset.detail),detail.dataset.task);return;}
  const sort=e.target.closest('[data-overall-sort]');
  if(sort){
    const next=sort.dataset.overallSort;
    // Clicking the active column is a no-op rather than a direction toggle:
    // all three metrics are "lower is better", so there is no second order.
    if(next!==state.overallSort){state.overallSort=next;refresh();}
    return;
  }
  const task=e.target.closest('[data-task-switch]');if(task){state.task=task.dataset.taskSwitch;$('taskpick').value=state.task;state.tab='ranking';state.page=0;render();return;}
  const legend=e.target.closest('[data-chart-key]');if(legend){const key=legend.dataset.chartKey;if(chartHidden.has(key))chartHidden.delete(key);else chartHidden.add(key);drawTrends(pageEntries);}
});
function refresh(){state.page=0;chartDomain=null;chartHidden.clear();render();}
for(const id of ['status','kind','sort'])$(id).onchange=e=>{state[id]=e.target.value;refresh();};
$('metric').onchange=e=>{state.metric=e.target.value;refresh();};
$('encoding').onchange=e=>{state.encoding=e.target.value;render();};
$('overall-sort').onchange=e=>{state.overallSort=e.target.value;refresh();};
$('taskpick').onchange=e=>{state.task=e.target.value;refresh();};
$('scale').onchange=e=>{state.scale=e.target.value;chartDomain=null;drawTrends(pageEntries);};
for(const mode of ['ranking','overall','matrix','trends'])$('tab-'+mode).onclick=()=>{state.tab=mode;refresh();};
$('clear').onclick=()=>{state.kind='all';state.status='all';state.sort='value';state.overallSort='mean';for(const id of ['kind','status','sort'])$(id).value=state[id];refresh();};
$('page-size').onchange=e=>{state.pageSize=e.target.value==='all'?Infinity:Number(e.target.value);refresh();};
for(const [id,delta]of [['prev',-1],['next',1]])$(id).onclick=()=>{state.page+=delta;chartDomain=null;chartHidden.clear();render();for(const box of document.querySelectorAll('.table-scroll'))box.scrollTop=0;};
function resetZoom(){chartDomain=null;drawTrends(pageEntries);}
$('reset-zoom').onclick=resetZoom;$('chart').ondblclick=resetZoom;
$('chart').addEventListener('wheel',e=>{e.preventDefault();if(!chartGeometry)return;const d=chartDomain||chartBase,{W,H,P,pw,ph}=chartGeometry,r=$('chart').getBoundingClientRect(),fx=Math.max(0,Math.min(1,((e.clientX-r.left)/r.width*W-P.l)/pw)),fy=Math.max(0,Math.min(1,1-((e.clientY-r.top)/r.height*H-P.t)/ph)),f=Math.exp(Math.max(-.5,Math.min(.5,e.deltaY*.0015))),x=d.x0+fx*(d.x1-d.x0),y=d.y0+fy*(d.y1-d.y0);const next={x0:x+(d.x0-x)*f,x1:x+(d.x1-x)*f,y0:y+(d.y0-y)*f,y1:y+(d.y1-y)*f};if(next.x1-next.x0<.05||next.x1-next.x0>TASKS.length*5||next.y1-next.y0<1e-8||next.y1-next.y0>(chartBase.y1-chartBase.y0)*100)return;chartDomain=next;drawTrends(pageEntries);},{passive:false});
let drag=null;
$('chart').onpointerdown=e=>{if(e.button!==0||!chartGeometry)return;drag={x:e.clientX,y:e.clientY,d:{...(chartDomain||chartBase)}};};
window.addEventListener('pointermove',e=>{if(!drag)return;const {W,H,pw,ph}=chartGeometry,r=$('chart').getBoundingClientRect(),dx=(e.clientX-drag.x)/r.width*W/pw*(drag.d.x1-drag.d.x0),dy=(e.clientY-drag.y)/r.height*H/ph*(drag.d.y1-drag.d.y0);chartDomain={x0:drag.d.x0-dx,x1:drag.d.x1-dx,y0:drag.d.y0+dy,y1:drag.d.y1+dy};drawTrends(pageEntries);});
window.addEventListener('pointerup',()=>{drag=null;});window.addEventListener('pointercancel',()=>{drag=null;});
window.addEventListener('resize',()=>{if(state.tab==='trends')drawTrends(pageEntries);});
for(const t of TASKS){const o=document.createElement('option');o.value=t;o.textContent=t.split('_')[0]+' · '+(TASK_TITLES[t]||t);$('taskpick').append(o);}
const kinds=[...new Set(ALL.map(s=>meta(s.backend).kind||'unknown'))].sort();
for(const kind of kinds){const o=document.createElement('option');o.value=kind;o.textContent=KIND_NAMES[kind]||kind;$('kind').append(o);}
$('kind-key').innerHTML=kinds.map(k=>'<span><i class="dot" style="--series:'+(KIND_COLORS[k]||'#8b98aa')+'"></i>'+esc(KIND_NAMES[k]||k)+'</span>').join('');
const total=ALL.reduce((n,s)=>n+s.cells.size,0),ok=DOC.cells.filter(c=>c.status==='OK').length,pending=ALL.reduce((n,s)=>n+[...s.cells.values()].filter(c=>c.status==='NOT RUN').length,0),issues=DOC.cells.length-ok;
$('stats').innerHTML=`<div class="stat"><strong>${group(DOC.cells.length)} <span>/ ${group(total)}</span></strong><span>Recorded cells · ${group(pending)} still to run</span><div class="progress"><i style="width:${total?DOC.cells.length/total*100:0}%"></i></div></div><div class="stat"><strong>${new Set(ALL.map(s=>s.language)).size} <span>languages</span></strong><span>${ALL.length} language / toolchain combinations</span></div><div class="stat"><strong>${new Set(ALL.map(s=>s.backend)).size} <span>engines</span></strong><span>Shared compilers & runtimes</span></div><div class="stat"><strong>${TASKS.length} <span>tasks</span></strong><span>${group(ok)} OK · ${group(issues)} failed / skipped</span></div>`;
$('method-summary').textContent='Generated '+(DOC.generated||'date unknown')+' · '+(DOC.method?.runs||DOC.runs||'unspecified')+' runs (latest batch; see individual records) · '+(DOC.method?.pinning||'pinning not recorded')+'. Results may combine multiple runs and dates.';
const {cells,expected,backends,tasks,...metadata}=DOC;$('metadata').textContent=JSON.stringify(metadata,null,2);
render();
</script>
</body>
</html>
"""


def load(path):
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)


def build(doc, tasks, backends=None, backend_of=None):
    """Embed full measurements and registry coverage without external resources.

    Keep the build API usable without a registry. ``all_cells``, when supplied,
    contains registry cell identities; older count-only placeholders are ignored.
    ``backend_of`` maps a cell's identity to the engine that ran it -- per task,
    because one toolchain can hand different tasks to different engines (Luau runs
    twelve cells on its own VM and three on Lute).
    """
    backend_of = backend_of or {}
    cells = []
    for original in doc.get("cells") or []:
        cell = dict(original)
        if not cell.get("backend"):
            key = (cell.get("row", ""), cell.get("toolchain", ""), cell.get("task", ""))
            cell["backend"] = backend_of.get(key, backend_of.get(key[:2], "?"))
        cells.append(cell)
    expected = [dict(c, status="NOT RUN") for c in doc.get("all_cells", []) if isinstance(c, dict)]
    all_tasks = list(dict.fromkeys([*tasks, *(c["task"] for c in cells), *(c["task"] for c in expected)]))
    data = {k: v for k, v in doc.items() if k != "all_cells"}
    data.update(cells=cells, expected=expected, tasks=all_tasks,
                backends={**(backends or {}), **(doc.get("backends") or {})})
    # A recorded command, warning or stdout may contain </script>. JSON escaping
    # alone does not protect an HTML script element from its closing delimiter.
    def embedded(value):
        return json.dumps(value, separators=(",", ":")).replace("&", "\\u0026").replace("<", "\\u003c").replace(">", "\\u003e")
    return TEMPLATE.replace("__TITLES__", embedded(TASK_TITLES)).replace("__DATA__", embedded(data))


def main():
    ap = argparse.ArgumentParser(description="Explore exec/results.json as a standalone HTML report.")
    ap.add_argument("--json", default=os.path.join(HERE, "results.json"))
    ap.add_argument("--html", default=os.path.join(HERE, "results.html"))
    ap.add_argument("--registry", default=os.path.join(HERE, "cells.json"),
                    help="registry supplying compiler families and cells not yet measured")
    ap.add_argument("--open", action="store_true", help="open the page when it is written")
    args = ap.parse_args()
    if not os.path.exists(args.json):
        print("no such results file: %s" % args.json, file=sys.stderr)
        print("run `python exec/harness.py` first", file=sys.stderr)
        return 1
    doc = load(args.json)
    tasks = doc.get("tasks") or TASKS
    backends = {}
    backend_of = {}
    expected = []
    try:
        sys.path.insert(0, HERE)
        import harness
        reg = load(args.registry)
        tasks = list(dict.fromkeys([*reg.get("tasks", []), *tasks]))
        backends = reg.get("backends", {})
        # Use the harness's coverage rules, including per-toolchain exceptions.
        # A toolchain with one engine indexes under (row, toolchain); one that
        # splits its tasks across engines (Luau) only under (row, toolchain, task),
        # so a stale cell of it cannot inherit the wrong engine's name.
        engines = {}
        for row, tc, task, entry, language in harness.expand(reg["rows"], reg.get("tasks") or tasks):
            backend = entry.get("backend", "?")
            expected.append(dict(row=row, toolchain=tc, task=task, language=language, backend=backend))
            if backend == "?":
                continue
            backend_of[(row, tc, task)] = backend
            key = (row, tc)
            if key in engines and engines[key] != backend:
                engines[key] = None
            elif key not in engines:
                engines[key] = backend
        for key, backend in engines.items():
            if backend:
                backend_of[key] = backend
    except (OSError, ValueError, KeyError, ImportError, SystemExit) as exc:
        print("registry unavailable; showing recorded cells only: %s" % exc, file=sys.stderr)
    doc["all_cells"] = expected
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
