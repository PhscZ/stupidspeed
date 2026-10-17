// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_14_file_read_BSLASH_t14_file_readA3F3813');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var fs = require("fs");
var chunk = ((1024) * (1024));
var buf = (new Uint8Array(chunk));
var total = (function (){var pass = (0);
var total = (0);
while(true){
if((pass < (8))){
var fd = fs.openSync("data.bin","r");
var t = (function (){var t = total;
while(true){
var n = fs.readSync(fd,buf,(0),chunk,null);
if((n > (0))){
var G__24 = cljs.core.rem.call(null,(function (){var i = (0);
var tt = t;
while(true){
if((i < n)){
var G__25 = (i + (1));
var G__26 = (tt + (buf[i]));
i = G__25;
tt = G__26;
continue;
} else {
return tt;
}
break;
}
})(),(4294967296));
t = G__24;
continue;
} else {
return t;
}
break;
}
})();
fs.closeSync(fd);

var G__27 = (pass + (1));
var G__28 = t;
pass = G__27;
total = G__28;
continue;
} else {
return total;
}
break;
}
})();
process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,total);
});
cljs.user._main.call(null);
