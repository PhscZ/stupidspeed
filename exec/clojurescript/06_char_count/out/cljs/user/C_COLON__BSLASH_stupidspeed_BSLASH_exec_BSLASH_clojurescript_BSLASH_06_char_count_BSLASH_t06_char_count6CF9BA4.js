// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_06_char_count_BSLASH_t06_char_count6CF9BA4');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var text = "abcdefghij".repeat((25000000));
var len = text.length;
var i = (0);
var count = (0);
while(true){
if((i < len)){
var G__24 = (i + (1));
var G__25 = ((cljs.core._EQ_.call(null,text.charAt(i),"h"))?(count + (1)):count);
i = G__24;
count = G__25;
continue;
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,count);
}
break;
}
});
cljs.user._main.call(null);
