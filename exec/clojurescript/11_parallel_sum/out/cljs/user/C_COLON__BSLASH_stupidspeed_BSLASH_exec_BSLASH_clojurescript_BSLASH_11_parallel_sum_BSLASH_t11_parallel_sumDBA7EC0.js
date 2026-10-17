// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_11_parallel_sum_BSLASH_t11_parallel_sumDBA7EC0');
goog.require('cljs.core');
cljs.user.SPAN = (27000000);
cljs.user.work = (function cljs$user$work(t){
var start = (t * cljs.user.SPAN);
var end = (start + cljs.user.SPAN);
var i = start;
var acc = (0);
while(true){
if((i < end)){
var G__25 = (i + (1));
var G__26 = (acc + (function (){var G__24 = cljs.core.rem.call(null,i,(4));
switch (G__24) {
case (0):
return (1);

break;
case (1):
return i;

break;
case (2):
return ((2) * i);

break;
case (3):
return ((3) * i);

break;
default:
throw (new Error(["No matching clause: ",cljs.core.str.cljs$core$IFn$_invoke$arity$1(G__24)].join('')));

}
})());
i = G__25;
acc = G__26;
continue;
} else {
return acc;
}
break;
}
});
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var results = (new Float64Array((4)));
var n__2060__auto___28 = (4);
var t_29 = (0);
while(true){
if((t_29 < n__2060__auto___28)){
(results[t_29] = cljs.user.work.call(null,t_29));

var G__30 = (t_29 + (1));
t_29 = G__30;
continue;
} else {
}
break;
}

var t = (0);
var total = (0);
while(true){
if((t < (4))){
var G__31 = (t + (1));
var G__32 = (total + (results[t]));
t = G__31;
total = G__32;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
}
break;
}
});
cljs.user._main.call(null);
