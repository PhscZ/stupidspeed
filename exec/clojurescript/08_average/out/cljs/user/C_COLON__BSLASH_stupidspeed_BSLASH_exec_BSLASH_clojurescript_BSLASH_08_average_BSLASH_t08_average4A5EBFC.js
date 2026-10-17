// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_08_average_BSLASH_t08_average4A5EBFC');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var i = (0);
var total = 0.0;
while(true){
if((i < (200000000))){
var G__24 = (i + (1));
var G__25 = (total + (cljs.core.rem.call(null,i,(256)) / 256.0));
i = G__24;
total = G__25;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,(total / 2.0E8));
}
break;
}
});
cljs.user._main.call(null);
