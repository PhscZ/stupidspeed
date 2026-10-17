// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_05_alloc_churn_BSLASH_t05_alloc_churnE41AAD0');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var slots = (new Array((256)));
var i = (0);
var total = (0);
while(true){
if((i < (50000000))){
var v = cljs.core.rem.call(null,i,(256));
var buf = (new Uint8Array((64)));
(buf[(0)] = v);

(slots[v] = buf);

var G__24 = (i + (1));
var G__25 = (total + v);
i = G__24;
total = G__25;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
}
break;
}
});
cljs.user._main.call(null);
