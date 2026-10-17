// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_09_fib_recursive_BSLASH_t09_fib_recursive7F56DEF');
goog.require('cljs.core');
cljs.user.fib = (function cljs$user$fib(n){
if((n < (2))){
return n;
} else {
return (cljs.user.fib.call(null,(n - (1))) + cljs.user.fib.call(null,(n - (2))));
}
});
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var result = cljs.user.fib.call(null,(40));
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,result);
});
cljs.user._main.call(null);
