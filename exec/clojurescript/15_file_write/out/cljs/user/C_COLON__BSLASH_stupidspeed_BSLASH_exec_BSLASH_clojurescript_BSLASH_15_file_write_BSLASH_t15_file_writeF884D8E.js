// Compiled by ClojureScript 1.11.132 {:target :nodejs, :nodejs-rt true, :optimizations :simple}
goog.provide('cljs.user.C_COLON__BSLASH_stupidspeed_BSLASH_exec_BSLASH_clojurescript_BSLASH_15_file_write_BSLASH_t15_file_writeF884D8E');
goog.require('cljs.core');
cljs.user.__t0 = cljs.core.volatile_BANG_.call(null,(0));
cljs.user._main = (function cljs$user$_main(){
cljs.core.vreset_BANG_.call(null,cljs.user.__t0,cljs.core.system_time.call(null));

var fs = require("fs");
var len = ((1024) * (1024));
var buf = (new Uint8Array(len));
var n__2060__auto___24 = len;
var i_25 = (0);
while(true){
if((i_25 < n__2060__auto___24)){
(buf[i_25] = cljs.core.rem.call(null,i_25,(256)));

var G__26 = (i_25 + (1));
i_25 = G__26;
continue;
} else {
}
break;
}

var n__2060__auto___27 = (8);
var p_28 = (0);
while(true){
if((p_28 < n__2060__auto___27)){
var fd_29 = fs.openSync("out.bin","w");
var n__2060__auto___30__$1 = (50);
var i_31 = (0);
while(true){
if((i_31 < n__2060__auto___30__$1)){
fs.writeSync(fd_29,buf,(0),len);

var G__32 = (i_31 + (1));
i_31 = G__32;
continue;
} else {
}
break;
}

fs.fsyncSync(fd_29);

fs.closeSync(fd_29);

var G__33 = (p_28 + (1));
p_28 = G__33;
continue;
} else {
}
break;
}

process.stderr.write(["TIME_MS=",cljs.core.str.cljs$core$IFn$_invoke$arity$1((cljs.core.system_time.call(null) - cljs.core.deref.call(null,cljs.user.__t0))),"\n"].join(''));

return cljs.core.println.call(null,(((8) * (50)) * len));
});
cljs.user._main.call(null);
