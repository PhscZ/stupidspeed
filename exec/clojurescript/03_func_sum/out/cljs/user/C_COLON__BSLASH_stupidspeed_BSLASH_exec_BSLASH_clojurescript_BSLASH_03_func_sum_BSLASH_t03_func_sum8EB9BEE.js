// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_03_func_sum_BSLASH_t03_func_sum8EB9BEE');
goog.require('cljs.core');
cljs.user.add_one = (function cljs$user$add_one(n){
return (n + (1));
});
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var i = (0);
var value = (0);
while(true){
if((i < (400000000))){
var G__24 = (i + (1));
var G__25 = cljs.user.add_one.call(null,value);
i = G__24;
value = G__25;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,value);
}
break;
}
});
cljs.user._main.call(null);
