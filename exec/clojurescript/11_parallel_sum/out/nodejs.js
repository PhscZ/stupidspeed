// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.nodejs');
goog.require('cljs.core');
cljs.nodejs.require = require;
cljs.nodejs.process = process;
cljs.nodejs.enable_util_print_BANG_ = (function cljs$nodejs$enable_util_print_BANG_(){
(cljs.core._STAR_print_newline_STAR_ = false);

cljs.core.set_print_fn_BANG_.call(null,(function() { 
var G__35__delegate = function (args){
return console.log.apply(console,cljs.core.into_array.call(null,args));
};
var G__35 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__36__i = 0, G__36__a = new Array(arguments.length -  0);
while (G__36__i < G__36__a.length) {G__36__a[G__36__i] = arguments[G__36__i + 0]; ++G__36__i;}
  args = new cljs.core.IndexedSeq(G__36__a,0,null);
} 
return G__35__delegate.call(this,args);};
G__35.cljs$lang$maxFixedArity = 0;
G__35.cljs$lang$applyTo = (function (arglist__37){
var args = cljs.core.seq(arglist__37);
return G__35__delegate(args);
});
G__35.cljs$core$IFn$_invoke$arity$variadic = G__35__delegate;
return G__35;
})()
);

cljs.core.set_print_err_fn_BANG_.call(null,(function() { 
var G__38__delegate = function (args){
return console.error.apply(console,cljs.core.into_array.call(null,args));
};
var G__38 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__39__i = 0, G__39__a = new Array(arguments.length -  0);
while (G__39__i < G__39__a.length) {G__39__a[G__39__i] = arguments[G__39__i + 0]; ++G__39__i;}
  args = new cljs.core.IndexedSeq(G__39__a,0,null);
} 
return G__38__delegate.call(this,args);};
G__38.cljs$lang$maxFixedArity = 0;
G__38.cljs$lang$applyTo = (function (arglist__40){
var args = cljs.core.seq(arglist__40);
return G__38__delegate(args);
});
G__38.cljs$core$IFn$_invoke$arity$variadic = G__38__delegate;
return G__38;
})()
);

return null;
});
