// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.nodejs');
goog.require('cljs.core');
cljs.nodejs.require = require;
cljs.nodejs.process = process;
cljs.nodejs.enable_util_print_BANG_ = (function cljs$nodejs$enable_util_print_BANG_(){
(cljs.core._STAR_print_newline_STAR_ = false);

cljs.core.set_print_fn_BANG_.call(null,(function() { 
var G__36__delegate = function (args){
return console.log.apply(console,cljs.core.into_array.call(null,args));
};
var G__36 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__37__i = 0, G__37__a = new Array(arguments.length -  0);
while (G__37__i < G__37__a.length) {G__37__a[G__37__i] = arguments[G__37__i + 0]; ++G__37__i;}
  args = new cljs.core.IndexedSeq(G__37__a,0,null);
} 
return G__36__delegate.call(this,args);};
G__36.cljs$lang$maxFixedArity = 0;
G__36.cljs$lang$applyTo = (function (arglist__38){
var args = cljs.core.seq(arglist__38);
return G__36__delegate(args);
});
G__36.cljs$core$IFn$_invoke$arity$variadic = G__36__delegate;
return G__36;
})()
);

cljs.core.set_print_err_fn_BANG_.call(null,(function() { 
var G__39__delegate = function (args){
return console.error.apply(console,cljs.core.into_array.call(null,args));
};
var G__39 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__40__i = 0, G__40__a = new Array(arguments.length -  0);
while (G__40__i < G__40__a.length) {G__40__a[G__40__i] = arguments[G__40__i + 0]; ++G__40__i;}
  args = new cljs.core.IndexedSeq(G__40__a,0,null);
} 
return G__39__delegate.call(this,args);};
G__39.cljs$lang$maxFixedArity = 0;
G__39.cljs$lang$applyTo = (function (arglist__41){
var args = cljs.core.seq(arglist__41);
return G__39__delegate(args);
});
G__39.cljs$core$IFn$_invoke$arity$variadic = G__39__delegate;
return G__39;
})()
);

return null;
});
