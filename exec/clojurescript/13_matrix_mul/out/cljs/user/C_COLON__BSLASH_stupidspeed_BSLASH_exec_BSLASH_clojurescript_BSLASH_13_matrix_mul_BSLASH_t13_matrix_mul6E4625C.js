// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_13_matrix_mul_BSLASH_t13_matrix_mul6E4625C');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var n = (500);
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
(a[idx_28] = cljs.core.rem.call(null,(i_25 + j_27),(7)));

(b[idx_28] = cljs.core.rem.call(null,(i_25 * j_27),(5)));

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
var r_32 = (0);
while(true){
if((r_32 < n__2060__auto___31)){
var n__2060__auto___33__$1 = n;
var col_34 = (0);
while(true){
if((col_34 < n__2060__auto___33__$1)){
var k_35 = (0);
var acc_36 = (0);
while(true){
if((k_35 < n)){
var G__37 = (k_35 + (1));
var G__38 = (acc_36 + ((a[((r_32 * n) + k_35)]) * (b[((k_35 * n) + col_34)])));
k_35 = G__37;
acc_36 = G__38;
continue;
} else {
(c[((r_32 * n) + col_34)] = acc_36);
}
break;
}

var G__39 = (col_34 + (1));
col_34 = G__39;
continue;
} else {
}
break;
}

var G__40 = (r_32 + (1));
r_32 = G__40;
continue;
} else {
}
break;
}

var e = (0);
var total = (0);
while(true){
if((e < elems)){
var G__41 = (e + (1));
var G__42 = (total + (c[e]));
e = G__41;
total = G__42;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
}
break;
}
});
cljs.user._main.call(null);
