// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_12_matrix_add_BSLASH_t12_matrix_addC31B7C1');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var n = (4000);
var elems = (n * n);
var a = (new Float64Array(elems));
var b = (new Float64Array(elems));
var c = (new Float64Array(elems));
var n__2060__auto___24 = n;
var i_25 = (0);
while(true){
if((i_25 < n__2060__auto___24)){
var n__2060__auto___26__$1 = n;
var j_27 = (0);
while(true){
if((j_27 < n__2060__auto___26__$1)){
var idx_28 = ((i_25 * n) + j_27);
(a[idx_28] = (i_25 + j_27));

(b[idx_28] = (i_25 - j_27));

var G__29 = (j_27 + (1));
j_27 = G__29;
continue;
} else {
}
break;
}

var G__30 = (i_25 + (1));
i_25 = G__30;
continue;
} else {
}
break;
}

var n__2060__auto___31 = n;
var p_32 = (0);
while(true){
if((p_32 < n__2060__auto___31)){
var n__2060__auto___33__$1 = n;
var q_34 = (0);
while(true){
if((q_34 < n__2060__auto___33__$1)){
var idx_35 = ((p_32 * n) + q_34);
(c[idx_35] = ((a[idx_35]) + (b[idx_35])));

var G__36 = (q_34 + (1));
q_34 = G__36;
continue;
} else {
}
break;
}

var G__37 = (p_32 + (1));
p_32 = G__37;
continue;
} else {
}
break;
}

var k = (0);
var total = (0);
while(true){
if((k < elems)){
var G__38 = (k + (1));
var G__39 = (total + (c[k]));
k = G__38;
total = G__39;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
}
break;
}
});
cljs.user._main.call(null);
