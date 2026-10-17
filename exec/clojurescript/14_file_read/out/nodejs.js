// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.nodejs');
goog.require('cljs.core');
cljs.nodejs.require = require;
cljs.nodejs.process = process;
cljs.nodejs.enable_util_print_BANG_ = (function cljs$nodejs$enable_util_print_BANG_(){
(cljs.core._STAR_print_newline_STAR_ = false);

cljs.core.set_print_fn_BANG_.call(null,(function() { 
var G__31__delegate = function (args){
return console.log.apply(console,cljs.core.into_array.call(null,args));
};
var G__31 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__32__i = 0, G__32__a = new Array(arguments.length -  0);
while (G__32__i < G__32__a.length) {G__32__a[G__32__i] = arguments[G__32__i + 0]; ++G__32__i;}
  args = new cljs.core.IndexedSeq(G__32__a,0,null);
} 
return G__31__delegate.call(this,args);};
G__31.cljs$lang$maxFixedArity = 0;
G__31.cljs$lang$applyTo = (function (arglist__33){
var args = cljs.core.seq(arglist__33);
return G__31__delegate(args);
});
G__31.cljs$core$IFn$_invoke$arity$variadic = G__31__delegate;
return G__31;
})()
);

cljs.core.set_print_err_fn_BANG_.call(null,(function() { 
var G__34__delegate = function (args){
return console.error.apply(console,cljs.core.into_array.call(null,args));
};
var G__34 = function (var_args){
var args = null;
if (arguments.length > 0) {
var G__35__i = 0, G__35__a = new Array(arguments.length -  0);
while (G__35__i < G__35__a.length) {G__35__a[G__35__i] = arguments[G__35__i + 0]; ++G__35__i;}
  args = new cljs.core.IndexedSeq(G__35__a,0,null);
} 
return G__34__delegate.call(this,args);};
G__34.cljs$lang$maxFixedArity = 0;
G__34.cljs$lang$applyTo = (function (arglist__36){
var args = cljs.core.seq(arglist__36);
return G__34__delegate(args);
});
G__34.cljs$core$IFn$_invoke$arity$variadic = G__34__delegate;
return G__34;
})()
);

return null;
});
