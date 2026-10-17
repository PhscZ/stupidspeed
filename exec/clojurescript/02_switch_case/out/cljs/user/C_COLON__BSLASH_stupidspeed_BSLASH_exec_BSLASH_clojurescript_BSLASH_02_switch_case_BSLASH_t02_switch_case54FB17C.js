// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_02_switch_case_BSLASH_t02_switch_case54FB17C');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var i = (0);
var acc = (0);
while(true){
if((i < (108000000))){
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
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,acc);
}
break;
}
});
cljs.user._main.call(null);
