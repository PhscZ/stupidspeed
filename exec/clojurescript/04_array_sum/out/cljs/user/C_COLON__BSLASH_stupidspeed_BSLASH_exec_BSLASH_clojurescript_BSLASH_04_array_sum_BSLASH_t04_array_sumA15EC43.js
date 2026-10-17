// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_04_array_sum_BSLASH_t04_array_sumA15EC43');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var n = (10000000);
var arr = (new Float64Array(n));
var n__2060__auto___24 = n;
var i_25 = (0);
while(true){
if((i_25 < n__2060__auto___24)){
(arr[i_25] = i_25);

var G__26 = (i_25 + (1));
i_25 = G__26;
continue;
} else {
}
break;
}

var r = (0);
var total = (0);
while(true){
if((r < (12))){
var G__27 = (r + (1));
var G__28 = (function (){var i = (0);
var acc = total;
while(true){
if((i < n)){
var G__29 = (i + (1));
var G__30 = (acc + (arr[i]));
i = G__29;
acc = G__30;
continue;
} else {
return acc;
}
break;
}
})();
r = G__27;
total = G__28;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
}
break;
}
});
cljs.user._main.call(null);
