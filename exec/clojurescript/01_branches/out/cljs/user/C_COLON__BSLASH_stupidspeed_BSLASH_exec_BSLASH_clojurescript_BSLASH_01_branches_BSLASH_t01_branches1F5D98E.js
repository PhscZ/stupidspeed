// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_01_branches_BSLASH_t01_branches1F5D98E');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var i = (0);
var a = (0);
var b = (0);
var c = (0);
var d = (0);
while(true){
if((i < (100000000))){
if((cljs.core.rem.call(null,i,(3)) === (0))){
var G__24 = (i + (1));
var G__25 = (a + (1));
var G__26 = b;
var G__27 = c;
var G__28 = d;
i = G__24;
a = G__25;
b = G__26;
c = G__27;
d = G__28;
continue;
} else {
if((cljs.core.rem.call(null,i,(5)) === (0))){
var G__29 = (i + (1));
var G__30 = a;
var G__31 = (b + (1));
var G__32 = c;
var G__33 = d;
i = G__29;
a = G__30;
b = G__31;
c = G__32;
d = G__33;
continue;
} else {
if((cljs.core.rem.call(null,i,(7)) === (0))){
var G__34 = (i + (1));
var G__35 = a;
var G__36 = b;
var G__37 = (c + (1));
var G__38 = d;
i = G__34;
a = G__35;
b = G__36;
c = G__37;
d = G__38;
continue;
} else {
var G__39 = (i + (1));
var G__40 = a;
var G__41 = b;
var G__42 = c;
var G__43 = (d + (1));
i = G__39;
a = G__40;
b = G__41;
c = G__42;
d = G__43;
continue;
}
}
}
} else {
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,a,b,c,d);
}
break;
}
});
cljs.user._main.call(null);
