// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.nodejs');
goog.require('cljs.core');
cljs.nodejs.require = require;
cljs.nodejs.process = process;
cljs.nodejs.enable_util_print_BANG_ = (function cljs$nodejs$enable_util_print_BANG_(){
(cljs.core._STAR_print_newline_STAR_ = false);

cljs.core.set_print_fn_BANG_.call(null,(function() { 
var G__45__delegate = function (args){
return console.log.apply(console,cljs.core.into_array.call(null,args));
};
var G__45 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__46__i = 0, G__46__a = new Array(arguments.length -  0);
while (G__46__i < G__46__a.length) {G__46__a[G__46__i] = arguments[G__46__i + 0]; ++G__46__i;}
  args = new cljs.core.IndexedSeq(G__46__a,0,null);
} 
return G__45__delegate.call(this,args);};
G__45.cljs$lang$maxFixedArity = 0;
G__45.cljs$lang$applyTo = (function (arglist__47){
var args = cljs.core.seq(arglist__47);
return G__45__delegate(args);
});
G__45.cljs$core$IFn$_invoke$arity$variadic = G__45__delegate;
return G__45;
})()
);

cljs.core.set_print_err_fn_BANG_.call(null,(function() { 
var G__48__delegate = function (args){
return console.error.apply(console,cljs.core.into_array.call(null,args));
};
var G__48 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__49__i = 0, G__49__a = new Array(arguments.length -  0);
while (G__49__i < G__49__a.length) {G__49__a[G__49__i] = arguments[G__49__i + 0]; ++G__49__i;}
  args = new cljs.core.IndexedSeq(G__49__a,0,null);
} 
return G__48__delegate.call(this,args);};
G__48.cljs$lang$maxFixedArity = 0;
G__48.cljs$lang$applyTo = (function (arglist__50){
var args = cljs.core.seq(arglist__50);
return G__48__delegate(args);
});
G__48.cljs$core$IFn$_invoke$arity$variadic = G__48__delegate;
return G__48;
})()
);

return null;
});
