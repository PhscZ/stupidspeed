// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_10_pi_BSLASH_t10_pi45EA79C');
goog.require('cljs.core');
cljs.user.DIGITS = (2000);
cljs.user.big = (function cljs$user$big(x){
return BigInt(x);
});
cljs.user.b_PLUS_ = (function cljs$user$b_PLUS_(a,b){
return (a + b);
});
cljs.user.b_ = (function cljs$user$b_(a,b){
return (a - b);
});
cljs.user.b_STAR_ = (function cljs$user$b_STAR_(a,b){
return (a * b);
});
cljs.user.bdiv = (function cljs$user$bdiv(a,b){
return (a / b);
});
cljs.user.brem = (function cljs$user$brem(a,b){
return (a % b);
});
cljs.user.blt = (function cljs$user$blt(a,b){
return (a < b);
});
cljs.user.bnum = (function cljs$user$bnum(a){
return Number(a);
});
cljs.user.floor_div = (function cljs$user$floor_div(a,b){
var q = cljs.user.bdiv.call(null,a,b);
var rem = cljs.user.brem.call(null,a,b);
if(cljs.core.truth_((function (){var and__1467__auto__ = (!((cljs.user.bnum.call(null,rem) === (0))));
if(and__1467__auto__){
return cljs.user.blt.call(null,rem,cljs.user.big.call(null,(0)));
} else {
return and__1467__auto__;
}
})())){
return cljs.user.b_.call(null,q,cljs.user.big.call(null,(1)));
} else {
return q;
}
});
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var sum = (function (){var q = cljs.user.big.call(null,(1));
var r = cljs.user.big.call(null,(0));
var t = cljs.user.big.call(null,(1));
var k = cljs.user.big.call(null,(1));
var n = cljs.user.big.call(null,(3));
var l = cljs.user.big.call(null,(3));
var sum = (0);
var emitted = (0);
while(true){
if((emitted < cljs.user.DIGITS)){
if(cljs.core.truth_(cljs.user.blt.call(null,cljs.user.b_.call(null,cljs.user.b_PLUS_.call(null,cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(4)),q),r),t),cljs.user.b_STAR_.call(null,n,t)))){
var nq = cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(10)),q);
var nr = cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(10)),cljs.user.b_.call(null,r,cljs.user.b_STAR_.call(null,n,t)));
var nn = cljs.user.b_.call(null,cljs.user.floor_div.call(null,cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(10)),cljs.user.b_PLUS_.call(null,cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(3)),q),r)),t),cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(10)),n));
var G__24 = nq;
var G__25 = nr;
var G__26 = t;
var G__27 = k;
var G__28 = nn;
var G__29 = l;
var G__30 = (sum + cljs.user.bnum.call(null,n));
var G__31 = (emitted + (1));
q = G__24;
r = G__25;
t = G__26;
k = G__27;
n = G__28;
l = G__29;
sum = G__30;
emitted = G__31;
continue;
} else {
var nq = cljs.user.b_STAR_.call(null,q,k);
var nr = cljs.user.b_STAR_.call(null,cljs.user.b_PLUS_.call(null,cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(2)),q),r),l);
var nt = cljs.user.b_STAR_.call(null,t,l);
var nn = cljs.user.floor_div.call(null,cljs.user.b_PLUS_.call(null,cljs.user.b_STAR_.call(null,q,cljs.user.b_PLUS_.call(null,cljs.user.big.call(null,(7)),cljs.user.b_STAR_.call(null,cljs.user.big.call(null,(2)),k))),cljs.user.b_STAR_.call(null,r,l)),nt);
var nl = cljs.user.b_PLUS_.call(null,l,cljs.user.big.call(null,(2)));
var G__32 = nq;
var G__33 = nr;
var G__34 = nt;
var G__35 = cljs.user.b_PLUS_.call(null,k,cljs.user.big.call(null,(1)));
var G__36 = nn;
var G__37 = nl;
var G__38 = sum;
var G__39 = emitted;
q = G__32;
r = G__33;
t = G__34;
k = G__35;
n = G__36;
l = G__37;
sum = G__38;
emitted = G__39;
continue;
}
} else {
return sum;
}
break;
}
})();
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,sum);
});
cljs.user._main.call(null);
