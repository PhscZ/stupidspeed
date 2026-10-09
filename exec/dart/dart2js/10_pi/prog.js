(function dartProgram(){function copyProperties(a,b){var t=Object.keys(a)
for(var s=0;s<t.length;s++){var r=t[s]
b[r]=a[r]}}function mixinPropertiesHard(a,b){var t=Object.keys(a)
for(var s=0;s<t.length;s++){var r=t[s]
if(!b.hasOwnProperty(r)){b[r]=a[r]}}}function mixinPropertiesEasy(a,b){Object.assign(b,a)}var z=function(){var t=function(){}
t.prototype={p:{}}
var s=new t()
if(!(Object.getPrototypeOf(s)&&Object.getPrototypeOf(s).p===t.prototype.p))return false
try{if(typeof navigator!="undefined"&&typeof navigator.userAgent=="string"&&navigator.userAgent.indexOf("Chrome/")>=0)return true
if(typeof version=="function"&&version.length==0){var r=version()
if(/^\d+\.\d+\.\d+\.\d+$/.test(r))return true}}catch(q){}return false}()
function inherit(a,b){a.prototype.constructor=a
a.prototype["$i"+a.name]=a
if(b!=null){if(z){Object.setPrototypeOf(a.prototype,b.prototype)
return}var t=Object.create(b.prototype)
copyProperties(a.prototype,t)
a.prototype=t}}function inheritMany(a,b){for(var t=0;t<b.length;t++){inherit(b[t],a)}}function mixinEasy(a,b){mixinPropertiesEasy(b.prototype,a.prototype)
a.prototype.constructor=a}function mixinHard(a,b){mixinPropertiesHard(b.prototype,a.prototype)
a.prototype.constructor=a}function lazy(a,b,c,d){var t=a
a[b]=t
a[c]=function(){if(a[b]===t){a[b]=d()}a[c]=function(){return this[b]}
return a[b]}}function lazyFinal(a,b,c,d){var t=a
a[b]=t
a[c]=function(){if(a[b]===t){var s=d()
if(a[b]!==t){A.du(b)}a[b]=s}var r=a[b]
a[c]=function(){return r}
return r}}function makeConstList(a,b){if(b!=null)A.A(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var t=0;t<a.length;++t){convertToFastObject(a[t])}}var y=0
function instanceTearOffGetter(a,b){var t=null
return a?function(c){if(t===null)t=A.bd(b)
return new t(c,this)}:function(){if(t===null)t=A.bd(b)
return new t(this,null)}}function staticTearOffGetter(a){var t=null
return function(){if(t===null)t=A.bd(a).prototype
return t}}var x=0
function tearOffParameters(a,b,c,d,e,f,g,h,i,j){if(typeof h=="number"){h+=x}return{co:a,iS:b,iI:c,rC:d,dV:e,cs:f,fs:g,fT:h,aI:i||0,nDA:j}}function installStaticTearOff(a,b,c,d,e,f,g,h){var t=tearOffParameters(a,true,false,c,d,e,f,g,h,false)
var s=staticTearOffGetter(t)
a[b]=s}function installInstanceTearOff(a,b,c,d,e,f,g,h,i,j){c=!!c
var t=tearOffParameters(a,false,c,d,e,f,g,h,i,!!j)
var s=instanceTearOffGetter(c,t)
a[b]=s}function setOrUpdateInterceptorsByTag(a){var t=v.interceptorsByTag
if(!t){v.interceptorsByTag=a
return}copyProperties(a,t)}function setOrUpdateLeafTags(a){var t=v.leafTags
if(!t){v.leafTags=a
return}copyProperties(a,t)}function updateTypes(a){var t=v.types
var s=t.length
t.push.apply(t,a)
return s}function updateHolder(a,b){copyProperties(b,a)
return a}var hunkHelpers=function(){var t=function(a,b,c,d,e){return function(f,g,h,i){return installInstanceTearOff(f,g,a,b,c,d,[h],i,e,false)}},s=function(a,b,c,d){return function(e,f,g,h){return installStaticTearOff(e,f,a,b,c,[g],h,d)}}
return{inherit:inherit,inheritMany:inheritMany,mixin:mixinEasy,mixinHard:mixinHard,installStaticTearOff:installStaticTearOff,installInstanceTearOff:installInstanceTearOff,_instance_0u:t(0,0,null,["$0"],0),_instance_1u:t(0,1,null,["$1"],0),_instance_2u:t(0,2,null,["$2"],0),_instance_0i:t(1,0,null,["$0"],0),_instance_1i:t(1,1,null,["$1"],0),_instance_2i:t(1,2,null,["$2"],0),_static_0:s(0,null,["$0"],0),_static_1:s(1,null,["$1"],0),_static_2:s(2,null,["$2"],0),makeConstList:makeConstList,lazy:lazy,lazyFinal:lazyFinal,updateHolder:updateHolder,convertToFastObject:convertToFastObject,updateTypes:updateTypes,setOrUpdateInterceptorsByTag:setOrUpdateInterceptorsByTag,setOrUpdateLeafTags:setOrUpdateLeafTags}}()
function initializeDeferredHunk(a){x=v.types.length
a(hunkHelpers,v,w,$)}var J={
bh(a,b,c,d){return{i:a,p:b,e:c,x:d}},
bf(a){var t,s,r,q,p,o="_$dart_js",n=a[v.dispatchPropertyName]
if(n==null)if($.bg==null){A.dj()
n=a[v.dispatchPropertyName]}if(n!=null){t=n.p
if(!1===t)return n.i
if(!0===t)return a
s=Object.getPrototypeOf(a)
if(t===s)return n.i
if(n.e===s)throw A.f(A.bv("Return interceptor for "+A.o(t(a,n))))}r=a.constructor
if(r==null)q=null
else{p=$.aS
if(p==null)p=$.aS=A.aZ(o)
q=r[p]}if(q!=null)return q
q=A.dp(a)
if(q!=null)return q
if(typeof a=="function")return B.q
t=Object.getPrototypeOf(a)
if(t==null)return B.i
if(t===Object.prototype)return B.i
if(typeof r=="function"){p=$.aS
if(p==null)p=$.aS=A.aZ(o)
Object.defineProperty(r,p,{value:B.c,enumerable:false,writable:true,configurable:true})
return B.c}return B.c},
a4(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.K.prototype
return J.af.prototype}if(typeof a=="string")return J.N.prototype
if(a==null)return J.L.prototype
if(typeof a=="boolean")return J.ae.prototype
if(Array.isArray(a))return J.j.prototype
if(typeof a!="object"){if(typeof a=="function")return J.v.prototype
if(typeof a=="symbol")return J.Q.prototype
if(typeof a=="bigint")return J.O.prototype
return a}if(a instanceof A.h)return a
return J.bf(a)},
de(a){if(typeof a=="string")return J.N.prototype
if(a==null)return a
if(Array.isArray(a))return J.j.prototype
if(typeof a!="object"){if(typeof a=="function")return J.v.prototype
if(typeof a=="symbol")return J.Q.prototype
if(typeof a=="bigint")return J.O.prototype
return a}if(a instanceof A.h)return a
return J.bf(a)},
df(a){if(a==null)return a
if(Array.isArray(a))return J.j.prototype
if(typeof a!="object"){if(typeof a=="function")return J.v.prototype
if(typeof a=="symbol")return J.Q.prototype
if(typeof a=="bigint")return J.O.prototype
return a}if(a instanceof A.h)return a
return J.bf(a)},
c1(a){return J.df(a).gu(a)},
c2(a){return J.a4(a).gi(a)},
a6(a){return J.a4(a).h(a)},
ac:function ac(){},
ae:function ae(){},
L:function L(){},
P:function P(){},
w:function w(){},
aq:function aq(){},
X:function X(){},
v:function v(){},
O:function O(){},
Q:function Q(){},
j:function j(a){this.$ti=a},
ad:function ad(){},
aD:function aD(a){this.$ti=a},
a8:function a8(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
M:function M(){},
K:function K(){},
af:function af(){},
N:function N(){}},A={b5:function b5(){},
dn(a){var t,s
for(t=$.aX.length,s=0;s<t;++s)if(a===$.aX[s])return!0
return!1},
aE:function aE(a){this.a=a},
ag:function ag(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
J:function J(){},
bY(a){var t=A.bX(a)
if(t!=null)return t
return"minified:"+a},
dP(a,b){var t
if(b!=null){t=b.x
if(t!=null)return t}return u.p.b(a)},
o(a){var t
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
t=J.a6(a)
return t},
ar(a){var t,s,r,q
if(a instanceof A.h)return A.l(A.a5(a),null)
t=J.a4(a)
if(t===B.p||t===B.r||u.o.b(a)){s=B.d(a)
if(s!=="Object"&&s!=="")return s
r=a.constructor
if(typeof r=="function"){q=r.name
if(typeof q=="string"&&q!=="Object"&&q!=="")return q}}return A.l(A.a5(a),null)},
cf(a){var t,s,r
if(typeof a=="number"||A.bc(a))return J.a6(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.y)return a.h(0)
t=$.c0()
for(s=0;s<1;++s){r=t[s].H(a)
if(r!=null)return r}return"Instance of '"+A.ar(a)+"'"},
cd(){return Date.now()},
ce(){var t,s
if($.aG!==0)return
$.aG=1000
if(typeof window=="undefined")return
t=window
if(t==null)return
if(!!t.dartUseDateNowForTicks)return
s=t.performance
if(s==null)return
if(typeof s.now!="function")return
$.aG=1e6
$.b7=new A.aF(s)},
f(a){return A.i(a,new Error())},
i(a,b){var t
if(a==null)a=new A.aO()
b.dartException=a
t=A.dv
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:t})
b.name=""}else b.toString=t
return b},
dv(){return J.a6(this.dartException)},
bW(a,b){throw A.i(a,b==null?new Error():b)},
dt(a){throw A.f(A.br(a))},
cb(a1){var t,s,r,q,p,o,n,m,l,k,j=a1.co,i=a1.iS,h=a1.iI,g=a1.nDA,f=a1.aI,e=a1.fs,d=a1.cs,c=e[0],b=d[0],a=j[c],a0=a1.fT
a0.toString
t=i?Object.create(new A.aK().constructor.prototype):Object.create(new A.ab(null,null).constructor.prototype)
t.$initialize=t.constructor
s=i?function static_tear_off(){this.$initialize()}:function tear_off(a2,a3){this.$initialize(a2,a3)}
t.constructor=s
s.prototype=t
t.$_name=c
t.$_target=a
r=!i
if(r)q=A.bq(c,a,h,g)
else{t.$static_name=c
q=a}t.$S=A.c7(a0,i,h)
t[b]=q
for(p=q,o=1;o<e.length;++o){n=e[o]
if(typeof n=="string"){m=j[n]
l=n
n=m}else l=""
k=d[o]
if(k!=null){if(r)n=A.bq(l,n,h,g)
t[k]=n}if(o===f)p=n}t.$C=p
t.$R=a1.rC
t.$D=a1.dV
return s},
c7(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.f("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.c5)}throw A.f("Error in functionType of tearoff")},
c8(a,b,c,d){var t=A.bp
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,t)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,t)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,t)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,t)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,t)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,t)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,t)}},
bq(a,b,c,d){if(c)return A.ca(a,b,d)
return A.c8(b.length,d,a,b)},
c9(a,b,c,d){var t=A.bp,s=A.c6
switch(b?-1:a){case 0:throw A.f(new A.aJ("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,s,t)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,s,t)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,s,t)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,s,t)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,s,t)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,s,t)
default:return function(e,f,g){return function(){var r=[g(this)]
Array.prototype.push.apply(r,arguments)
return e.apply(f(this),r)}}(d,s,t)}},
ca(a,b,c){var t,s
if($.bn==null)$.bn=A.bm("interceptor")
if($.bo==null)$.bo=A.bm("receiver")
t=b.length
s=A.c9(t,c,a,b)
return s},
bd(a){return A.cb(a)},
c5(a,b){return A.aV(v.typeUniverse,A.a5(a.a),b)},
bp(a){return a.a},
c6(a){return a.b},
bm(a){var t,s,r,q=new A.ab("receiver","interceptor"),p=Object.getOwnPropertyNames(q)
p.$flags=1
t=p
for(p=t.length,s=0;s<p;++s){r=t[s]
if(q[r]===a)return r}throw A.f(A.c3("Field name "+a+" not found."))},
aZ(a){return v.getIsolateTag(a)},
dp(a){var t,s,r,q,p,o=$.bS.$1(a),n=$.aY[o]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.b2[o]
if(t!=null)return t
s=v.interceptorsByTag[o]
if(s==null){r=$.bP.$2(a,o)
if(r!=null){n=$.aY[r]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.b2[r]
if(t!=null)return t
s=v.interceptorsByTag[r]
o=r}}if(s==null)return null
t=s.prototype
q=o[0]
if(q==="!"){n=A.b3(t)
$.aY[o]=n
Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}if(q==="~"){$.b2[o]=t
return t}if(q==="-"){p=A.b3(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}if(q==="+")return A.bU(a,t)
if(q==="*")throw A.f(A.bv(o))
if(v.leafTags[o]===true){p=A.b3(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}else return A.bU(a,t)},
bU(a,b){var t=Object.getPrototypeOf(a)
Object.defineProperty(t,v.dispatchPropertyName,{value:J.bh(b,t,null,null),enumerable:false,writable:true,configurable:true})
return b},
b3(a){return J.bh(a,!1,null,!!a.$ik)},
dr(a,b,c){var t=b.prototype
if(v.leafTags[a]===true)return A.b3(t)
else return J.bh(t,c,null,null)},
dj(){if(!0===$.bg)return
$.bg=!0
A.dk()},
dk(){var t,s,r,q,p,o,n,m
$.aY=Object.create(null)
$.b2=Object.create(null)
A.di()
t=v.interceptorsByTag
s=Object.getOwnPropertyNames(t)
if(typeof window!="undefined"){window
r=function(){}
for(q=0;q<s.length;++q){p=s[q]
o=$.bV.$1(p)
if(o!=null){n=A.dr(p,t[p],o)
if(n!=null){Object.defineProperty(o,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
r.prototype=o}}}}for(q=0;q<s.length;++q){p=s[q]
if(/^[A-Za-z_]/.test(p)){m=t[p]
t["!"+p]=m
t["~"+p]=m
t["-"+p]=m
t["+"+p]=m
t["*"+p]=m}}},
di(){var t,s,r,q,p,o,n=B.j()
n=A.H(B.k,A.H(B.l,A.H(B.e,A.H(B.e,A.H(B.m,A.H(B.n,A.H(B.o(B.d),n)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){t=dartNativeDispatchHooksTransformer
if(typeof t=="function")t=[t]
if(Array.isArray(t))for(s=0;s<t.length;++s){r=t[s]
if(typeof r=="function")n=r(n)||n}}q=n.getTag
p=n.getUnknownTag
o=n.prototypeForTag
$.bS=new A.b_(q)
$.bP=new A.b0(p)
$.bV=new A.b1(o)},
H(a,b){return a(b)||b},
dd(a,b){var t=b.length,s=v.rttc[""+t+";"+a]
if(s==null)return null
if(t===0)return s
if(t===s.length)return s.apply(null,b)
return s(b)},
aF:function aF(a){this.a=a},
W:function W(){},
y:function y(){},
ay:function ay(){},
az:function az(){},
aN:function aN(){},
aK:function aK(){},
ab:function ab(a,b){this.a=a
this.b=b},
aJ:function aJ(a){this.a=a},
b_:function b_(a){this.a=a},
b0:function b0(a){this.a=a},
b1:function b1(a){this.a=a},
E:function E(){},
T:function T(){},
ah:function ah(){},
F:function F(){},
R:function R(){},
S:function S(){},
ai:function ai(){},
aj:function aj(){},
ak:function ak(){},
al:function al(){},
am:function am(){},
an:function an(){},
ao:function ao(){},
U:function U(){},
ap:function ap(){},
Y:function Y(){},
Z:function Z(){},
a_:function a_(){},
a0:function a0(){},
b8(a,b){var t=b.c
return t==null?b.c=A.a2(a,"bs",[b.x]):t},
bu(a){var t=a.w
if(t===6||t===7)return A.bu(a.x)
return t===11||t===12},
cg(a){return a.as},
be(a){return A.aU(v.typeUniverse,a,!1)},
B(a0,a1,a2,a3){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=a1.w
switch(a){case 5:case 1:case 2:case 3:case 4:return a1
case 6:t=a1.x
s=A.B(a0,t,a2,a3)
if(s===t)return a1
return A.bD(a0,s,!0)
case 7:t=a1.x
s=A.B(a0,t,a2,a3)
if(s===t)return a1
return A.bC(a0,s,!0)
case 8:r=a1.y
q=A.G(a0,r,a2,a3)
if(q===r)return a1
return A.a2(a0,a1.x,q)
case 9:p=a1.x
o=A.B(a0,p,a2,a3)
n=a1.y
m=A.G(a0,n,a2,a3)
if(o===p&&m===n)return a1
return A.b9(a0,o,m)
case 10:l=a1.x
k=a1.y
j=A.G(a0,k,a2,a3)
if(j===k)return a1
return A.bE(a0,l,j)
case 11:i=a1.x
h=A.B(a0,i,a2,a3)
g=a1.y
f=A.da(a0,g,a2,a3)
if(h===i&&f===g)return a1
return A.bB(a0,h,f)
case 12:e=a1.y
a3+=e.length
d=A.G(a0,e,a2,a3)
p=a1.x
o=A.B(a0,p,a2,a3)
if(d===e&&o===p)return a1
return A.ba(a0,o,d,!0)
case 13:c=a1.x
if(c<a3)return a1
b=a2[c-a3]
if(b==null)return a1
return b
default:throw A.f(A.a9("Attempted to substitute unexpected RTI kind "+a))}},
G(a,b,c,d){var t,s,r,q,p=b.length,o=A.aW(p)
for(t=!1,s=0;s<p;++s){r=b[s]
q=A.B(a,r,c,d)
if(q!==r)t=!0
o[s]=q}return t?o:b},
db(a,b,c,d){var t,s,r,q,p,o,n=b.length,m=A.aW(n)
for(t=!1,s=0;s<n;s+=3){r=b[s]
q=b[s+1]
p=b[s+2]
o=A.B(a,p,c,d)
if(o!==p)t=!0
m.splice(s,3,r,q,o)}return t?m:b},
da(a,b,c,d){var t,s=b.a,r=A.G(a,s,c,d),q=b.b,p=A.G(a,q,c,d),o=b.c,n=A.db(a,o,c,d)
if(r===s&&p===q&&n===o)return b
t=new A.at()
t.a=r
t.b=p
t.c=n
return t},
A(a,b){a[v.arrayRti]=b
return a},
bR(a){var t=a.$S
if(t!=null){if(typeof t=="number")return A.dh(t)
return a.$S()}return null},
dl(a,b){var t
if(A.bu(b))if(a instanceof A.y){t=A.bR(a)
if(t!=null)return t}return A.a5(a)},
a5(a){if(a instanceof A.h)return A.bK(a)
if(Array.isArray(a))return A.av(a)
return A.bb(J.a4(a))},
av(a){var t=a[v.arrayRti],s=u.b
if(t==null)return s
if(t.constructor!==s.constructor)return s
return t},
bK(a){var t=a.$ti
return t!=null?t:A.bb(a)},
bb(a){var t=a.constructor,s=t.$ccache
if(s!=null)return s
return A.cU(a,t)},
cU(a,b){var t=a instanceof A.y?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,s=A.cy(v.typeUniverse,t.name)
b.$ccache=s
return s},
dh(a){var t,s=v.types,r=s[a]
if(typeof r=="string"){t=A.aU(v.typeUniverse,r,!1)
s[a]=t
return t}return r},
dg(a){return A.C(A.bK(a))},
d9(a){var t=a instanceof A.y?A.bR(a):null
if(t!=null)return t
if(u.R.b(a))return J.c2(a).a
if(Array.isArray(a))return A.av(a)
return A.a5(a)},
C(a){var t=a.r
return t==null?a.r=new A.aT(a):t},
r(a){return A.C(A.aU(v.typeUniverse,a,!1))},
cT(a){var t=this
t.b=A.d8(t)
return t.b(a)},
d8(a){var t,s,r,q
if(a===u.K)return A.d0
if(A.D(a))return A.d4
t=a.w
if(t===6)return A.cR
if(t===1)return A.bN
if(t===7)return A.cV
s=A.d7(a)
if(s!=null)return s
if(t===8){r=a.x
if(a.y.every(A.D)){a.f="$i"+r
if(r==="cc")return A.cZ
if(a===u.m)return A.cY
return A.d3}}else if(t===10){q=A.dd(a.x,a.y)
return q==null?A.bN:q}return A.cP},
d7(a){if(a.w===8){if(a===u.S)return A.cW
if(a===u.i||a===u.H)return A.d_
if(a===u.N)return A.d2
if(a===u.y)return A.bc}return null},
cS(a){var t=this,s=A.cO
if(A.D(t))s=A.cN
else if(t===u.K)s=A.cK
else if(A.I(t)){s=A.cQ
if(t===u.w)s=A.cF
else if(t===u.v)s=A.cM
else if(t===u.u)s=A.cB
else if(t===u.n)s=A.cJ
else if(t===u.I)s=A.cD
else if(t===u.z)s=A.cH}else if(t===u.S)s=A.cE
else if(t===u.N)s=A.cL
else if(t===u.y)s=A.cA
else if(t===u.H)s=A.cI
else if(t===u.i)s=A.cC
else if(t===u.m)s=A.cG
t.a=s
return t.a(a)},
cP(a){var t=this
if(a==null)return A.I(t)
return A.dm(v.typeUniverse,A.dl(a,t),t)},
cR(a){if(a==null)return!0
return this.x.b(a)},
d3(a){var t,s=this
if(a==null)return A.I(s)
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.a4(a)[t]},
cZ(a){var t,s=this
if(a==null)return A.I(s)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.a4(a)[t]},
cY(a){var t=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.h)return!!a[t.f]
return!0}if(typeof a=="function")return!0
return!1},
bM(a){if(typeof a=="object"){if(a instanceof A.h)return u.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
cO(a){var t=this
if(a==null){if(A.I(t))return a}else if(t.b(a))return a
throw A.i(A.bI(a,t),new Error())},
cQ(a){var t=this
if(a==null||t.b(a))return a
throw A.i(A.bI(a,t),new Error())},
bI(a,b){return new A.au("TypeError: "+A.bx(a,A.l(b,null)))},
bx(a,b){return A.aC(a)+": type '"+A.l(A.d9(a),null)+"' is not a subtype of type '"+b+"'"},
p(a,b){return new A.au("TypeError: "+A.bx(a,b))},
cV(a){var t=this
return t.x.b(a)||A.b8(v.typeUniverse,t).b(a)},
d0(a){return a!=null},
cK(a){if(a!=null)return a
throw A.i(A.p(a,"Object"),new Error())},
d4(a){return!0},
cN(a){return a},
bN(a){return!1},
bc(a){return!0===a||!1===a},
cA(a){if(!0===a)return!0
if(!1===a)return!1
throw A.i(A.p(a,"bool"),new Error())},
cB(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.i(A.p(a,"bool?"),new Error())},
cC(a){if(typeof a=="number")return a
throw A.i(A.p(a,"double"),new Error())},
cD(a){if(typeof a=="number")return a
if(a==null)return a
throw A.i(A.p(a,"double?"),new Error())},
cW(a){return typeof a=="number"&&Math.floor(a)===a},
cE(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.i(A.p(a,"int"),new Error())},
cF(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.i(A.p(a,"int?"),new Error())},
d_(a){return typeof a=="number"},
cI(a){if(typeof a=="number")return a
throw A.i(A.p(a,"num"),new Error())},
cJ(a){if(typeof a=="number")return a
if(a==null)return a
throw A.i(A.p(a,"num?"),new Error())},
d2(a){return typeof a=="string"},
cL(a){if(typeof a=="string")return a
throw A.i(A.p(a,"String"),new Error())},
cM(a){if(typeof a=="string")return a
if(a==null)return a
throw A.i(A.p(a,"String?"),new Error())},
cG(a){if(A.bM(a))return a
throw A.i(A.p(a,"JSObject"),new Error())},
cH(a){if(a==null)return a
if(A.bM(a))return a
throw A.i(A.p(a,"JSObject?"),new Error())},
bO(a,b){var t,s,r
for(t="",s="",r=0;r<a.length;++r,s=", ")t+=s+A.l(a[r],b)
return t},
d6(a,b){var t,s,r,q,p,o,n=a.x,m=a.y
if(""===n)return"("+A.bO(m,b)+")"
t=m.length
s=n.split(",")
r=s.length-t
for(q="(",p="",o=0;o<t;++o,p=", "){q+=p
if(r===0)q+="{"
q+=A.l(m[o],b)
if(r>=0)q+=" "+s[r];++r}return q+"})"},
bJ(a0,a1,a2){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b=", ",a=null
if(a2!=null){t=a2.length
if(a1==null)a1=A.A([],u.s)
else a=a1.length
s=a1.length
for(r=t;r>0;--r)a1.push("T"+(s+r))
for(q=u.X,p="<",o="",r=0;r<t;++r,o=b){p=p+o+a1[a1.length-1-r]
n=a2[r]
m=n.w
if(!(m===2||m===3||m===4||m===5||n===q))p+=" extends "+A.l(n,a1)}p+=">"}else p=""
q=a0.x
l=a0.y
k=l.a
j=k.length
i=l.b
h=i.length
g=l.c
f=g.length
e=A.l(q,a1)
for(d="",c="",r=0;r<j;++r,c=b)d+=c+A.l(k[r],a1)
if(h>0){d+=c+"["
for(c="",r=0;r<h;++r,c=b)d+=c+A.l(i[r],a1)
d+="]"}if(f>0){d+=c+"{"
for(c="",r=0;r<f;r+=3,c=b){d+=c
if(g[r+1])d+="required "
d+=A.l(g[r+2],a1)+" "+g[r]}d+="}"}if(a!=null){a1.toString
a1.length=a}return p+"("+d+") => "+e},
l(a,b){var t,s,r,q,p,o,n=a.w
if(n===5)return"erased"
if(n===2)return"dynamic"
if(n===3)return"void"
if(n===1)return"Never"
if(n===4)return"any"
if(n===6){t=a.x
s=A.l(t,b)
r=t.w
return(r===11||r===12?"("+s+")":s)+"?"}if(n===7)return"FutureOr<"+A.l(a.x,b)+">"
if(n===8){q=A.dc(a.x)
p=a.y
return p.length>0?q+("<"+A.bO(p,b)+">"):q}if(n===10)return A.d6(a,b)
if(n===11)return A.bJ(a,b,null)
if(n===12)return A.bJ(a.x,b,a.y)
if(n===13){o=a.x
return b[b.length-1-o]}return"?"},
dc(a){var t=A.bX(a)
if(t!=null)return t
return"minified:"+a},
cz(a,b){var t=a.tR[b]
while(typeof t=="string")t=a.tR[t]
return t},
cy(a,b){var t,s,r,q,p,o=a.eT,n=o[b]
if(n==null)return A.aU(a,b,!1)
else if(typeof n=="number"){t=n
s=A.a3(a,5,"#")
r=A.aW(t)
for(q=0;q<t;++q)r[q]=s
p=A.a2(a,b,r)
o[b]=p
return p}else return n},
cw(a,b){return A.bG(a.tR,b)},
cv(a,b){return A.bG(a.eT,b)},
aU(a,b,c){var t,s=a.eC,r=s.get(b)
if(r!=null)return r
t=A.bF(a,null,b,!1)
s.set(b,t)
return t},
aV(a,b,c){var t,s,r=b.z
if(r==null)r=b.z=new Map()
t=r.get(c)
if(t!=null)return t
s=A.bF(a,b,c,!0)
r.set(c,s)
return s},
cx(a,b,c){var t,s,r,q=b.Q
if(q==null)q=b.Q=new Map()
t=c.as
s=q.get(t)
if(s!=null)return s
r=A.b9(a,b,c.w===9?c.y:[c])
q.set(t,r)
return r},
bF(a,b,c,d){return A.co(A.ci(a,b,c,d))},
x(a,b){b.a=A.cS
b.b=A.cT
return b},
a3(a,b,c){var t,s,r=a.eC.get(c)
if(r!=null)return r
t=new A.q(null,null)
t.w=b
t.as=c
s=A.x(a,t)
a.eC.set(c,s)
return s},
bD(a,b,c){var t,s=b.as+"?",r=a.eC.get(s)
if(r!=null)return r
t=A.ct(a,b,s,c)
a.eC.set(s,t)
return t},
ct(a,b,c,d){var t,s,r
if(d){t=b.w
s=!0
if(!A.D(b))if(!(b===u.P||b===u.T))if(t!==6)s=t===7&&A.I(b.x)
if(s)return b
else if(t===1)return u.P}r=new A.q(null,null)
r.w=6
r.x=b
r.as=c
return A.x(a,r)},
bC(a,b,c){var t,s=b.as+"/",r=a.eC.get(s)
if(r!=null)return r
t=A.cr(a,b,s,c)
a.eC.set(s,t)
return t},
cr(a,b,c,d){var t,s
if(d){t=b.w
if(A.D(b)||b===u.K)return b
else if(t===1)return A.a2(a,"bs",[b])
else if(b===u.P||b===u.T)return u.O}s=new A.q(null,null)
s.w=7
s.x=b
s.as=c
return A.x(a,s)},
cu(a,b){var t,s,r=""+b+"^",q=a.eC.get(r)
if(q!=null)return q
t=new A.q(null,null)
t.w=13
t.x=b
t.as=r
s=A.x(a,t)
a.eC.set(r,s)
return s},
a1(a){var t,s,r,q=a.length
for(t="",s="",r=0;r<q;++r,s=",")t+=s+a[r].as
return t},
cq(a){var t,s,r,q,p,o=a.length
for(t="",s="",r=0;r<o;r+=3,s=","){q=a[r]
p=a[r+1]?"!":":"
t+=s+q+p+a[r+2].as}return t},
a2(a,b,c){var t,s,r,q=b
if(c.length>0)q+="<"+A.a1(c)+">"
t=a.eC.get(q)
if(t!=null)return t
s=new A.q(null,null)
s.w=8
s.x=b
s.y=c
if(c.length>0)s.c=c[0]
s.as=q
r=A.x(a,s)
a.eC.set(q,r)
return r},
b9(a,b,c){var t,s,r,q,p,o
if(b.w===9){t=b.x
s=b.y.concat(c)}else{s=c
t=b}r=t.as+(";<"+A.a1(s)+">")
q=a.eC.get(r)
if(q!=null)return q
p=new A.q(null,null)
p.w=9
p.x=t
p.y=s
p.as=r
o=A.x(a,p)
a.eC.set(r,o)
return o},
bE(a,b,c){var t,s,r="+"+(b+"("+A.a1(c)+")"),q=a.eC.get(r)
if(q!=null)return q
t=new A.q(null,null)
t.w=10
t.x=b
t.y=c
t.as=r
s=A.x(a,t)
a.eC.set(r,s)
return s},
bB(a,b,c){var t,s,r,q,p,o=b.as,n=c.a,m=n.length,l=c.b,k=l.length,j=c.c,i=j.length,h="("+A.a1(n)
if(k>0){t=m>0?",":""
h+=t+"["+A.a1(l)+"]"}if(i>0){t=m>0?",":""
h+=t+"{"+A.cq(j)+"}"}s=o+(h+")")
r=a.eC.get(s)
if(r!=null)return r
q=new A.q(null,null)
q.w=11
q.x=b
q.y=c
q.as=s
p=A.x(a,q)
a.eC.set(s,p)
return p},
ba(a,b,c,d){var t,s=b.as+("<"+A.a1(c)+">"),r=a.eC.get(s)
if(r!=null)return r
t=A.cs(a,b,c,s,d)
a.eC.set(s,t)
return t},
cs(a,b,c,d,e){var t,s,r,q,p,o,n,m
if(e){t=c.length
s=A.aW(t)
for(r=0,q=0;q<t;++q){p=c[q]
if(p.w===1){s[q]=p;++r}}if(r>0){o=A.B(a,b,s,0)
n=A.G(a,c,s,0)
return A.ba(a,o,n,c!==n)}}m=new A.q(null,null)
m.w=12
m.x=b
m.y=c
m.as=d
return A.x(a,m)},
ci(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
co(a){var t,s,r,q,p,o,n,m=a.r,l=a.s
for(t=m.length,s=0;s<t;){r=m.charCodeAt(s)
if(r>=48&&r<=57)s=A.ck(s+1,r,m,l)
else if((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124)s=A.bz(a,s,m,l,!1)
else if(r===46)s=A.bz(a,s,m,l,!0)
else{++s
switch(r){case 44:break
case 58:l.push(!1)
break
case 33:l.push(!0)
break
case 59:l.push(A.z(a.u,a.e,l.pop()))
break
case 94:l.push(A.cu(a.u,l.pop()))
break
case 35:l.push(A.a3(a.u,5,"#"))
break
case 64:l.push(A.a3(a.u,2,"@"))
break
case 126:l.push(A.a3(a.u,3,"~"))
break
case 60:l.push(a.p)
a.p=l.length
break
case 62:A.cm(a,l)
break
case 38:A.cl(a,l)
break
case 63:q=a.u
l.push(A.bD(q,A.z(q,a.e,l.pop()),a.n))
break
case 47:q=a.u
l.push(A.bC(q,A.z(q,a.e,l.pop()),a.n))
break
case 40:l.push(-3)
l.push(a.p)
a.p=l.length
break
case 41:A.cj(a,l)
break
case 91:l.push(a.p)
a.p=l.length
break
case 93:p=l.splice(a.p)
A.bA(a.u,a.e,p)
a.p=l.pop()
l.push(p)
l.push(-1)
break
case 123:l.push(a.p)
a.p=l.length
break
case 125:p=l.splice(a.p)
A.cp(a.u,a.e,p)
a.p=l.pop()
l.push(p)
l.push(-2)
break
case 43:o=m.indexOf("(",s)
l.push(m.substring(s,o))
l.push(-4)
l.push(a.p)
a.p=l.length
s=o+1
break
default:throw"Bad character "+r}}}n=l.pop()
return A.z(a.u,a.e,n)},
ck(a,b,c,d){var t,s,r=b-48
for(t=c.length;a<t;++a){s=c.charCodeAt(a)
if(!(s>=48&&s<=57))break
r=r*10+(s-48)}d.push(r)
return a},
bz(a,b,c,d,e){var t,s,r,q,p,o,n=b+1
for(t=c.length;n<t;++n){s=c.charCodeAt(n)
if(s===46){if(e)break
e=!0}else{if(!((((s|32)>>>0)-97&65535)<26||s===95||s===36||s===124))r=s>=48&&s<=57
else r=!0
if(!r)break}}q=c.substring(b,n)
if(e){t=a.u
p=a.e
if(p.w===9)p=p.x
o=A.cz(t,p.x)[q]
if(o==null)A.bW('No "'+q+'" in "'+A.cg(p)+'"')
d.push(A.aV(t,p,o))}else d.push(q)
return n},
cm(a,b){var t,s=a.u,r=A.by(a,b),q=b.pop()
if(typeof q=="string")b.push(A.a2(s,q,r))
else{t=A.z(s,a.e,q)
switch(t.w){case 11:b.push(A.ba(s,t,r,a.n))
break
default:b.push(A.b9(s,t,r))
break}}},
cj(a,b){var t,s,r,q=a.u,p=b.pop(),o=null,n=null
if(typeof p=="number")switch(p){case-1:o=b.pop()
break
case-2:n=b.pop()
break
default:b.push(p)
break}else b.push(p)
t=A.by(a,b)
p=b.pop()
switch(p){case-3:p=b.pop()
if(o==null)o=q.sEA
if(n==null)n=q.sEA
s=A.z(q,a.e,p)
r=new A.at()
r.a=t
r.b=o
r.c=n
b.push(A.bB(q,s,r))
return
case-4:b.push(A.bE(q,b.pop(),t))
return
default:throw A.f(A.a9("Unexpected state under `()`: "+A.o(p)))}},
cl(a,b){var t=b.pop()
if(0===t){b.push(A.a3(a.u,1,"0&"))
return}if(1===t){b.push(A.a3(a.u,4,"1&"))
return}throw A.f(A.a9("Unexpected extended operation "+A.o(t)))},
by(a,b){var t=b.splice(a.p)
A.bA(a.u,a.e,t)
a.p=b.pop()
return t},
z(a,b,c){if(typeof c=="string")return A.a2(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.cn(a,b,c)}else return c},
bA(a,b,c){var t,s=c.length
for(t=0;t<s;++t)c[t]=A.z(a,b,c[t])},
cp(a,b,c){var t,s=c.length
for(t=2;t<s;t+=3)c[t]=A.z(a,b,c[t])},
cn(a,b,c){var t,s,r=b.w
if(r===9){if(c===0)return b.x
t=b.y
s=t.length
if(c<=s)return t[c-1]
c-=s
b=b.x
r=b.w}else if(c===0)return b
if(r!==8)throw A.f(A.a9("Indexed base must be an interface type"))
t=b.y
if(c<=t.length)return t[c-1]
throw A.f(A.a9("Bad index "+c+" for "+b.h(0)))},
dm(a,b,c){var t,s=b.d
if(s==null)s=b.d=new Map()
t=s.get(c)
if(t==null){t=A.e(a,b,null,c,null)
s.set(c,t)}return t},
e(a,b,c,d,e){var t,s,r,q,p,o,n,m,l,k,j
if(b===d)return!0
if(A.D(d))return!0
t=b.w
if(t===4)return!0
if(A.D(b))return!1
if(b.w===1)return!0
s=t===13
if(s)if(A.e(a,c[b.x],c,d,e))return!0
r=d.w
q=u.P
if(b===q||b===u.T){if(r===7)return A.e(a,b,c,d.x,e)
return d===q||d===u.T||r===6}if(d===u.K){if(t===7)return A.e(a,b.x,c,d,e)
return t!==6}if(t===7){if(!A.e(a,b.x,c,d,e))return!1
return A.e(a,A.b8(a,b),c,d,e)}if(t===6)return A.e(a,q,c,d,e)&&A.e(a,b.x,c,d,e)
if(r===7){if(A.e(a,b,c,d.x,e))return!0
return A.e(a,b,c,A.b8(a,d),e)}if(r===6)return A.e(a,b,c,q,e)||A.e(a,b,c,d.x,e)
if(s)return!1
q=t!==11
if((!q||t===12)&&d===u.Z)return!0
p=t===10
if(p&&d===u.L)return!0
if(r===12){if(b===u.g)return!0
if(t!==12)return!1
o=b.y
n=d.y
m=o.length
if(m!==n.length)return!1
c=c==null?o:o.concat(c)
e=e==null?n:n.concat(e)
for(l=0;l<m;++l){k=o[l]
j=n[l]
if(!A.e(a,k,c,j,e)||!A.e(a,j,e,k,c))return!1}return A.bL(a,b.x,c,d.x,e)}if(r===11){if(b===u.g)return!0
if(q)return!1
return A.bL(a,b,c,d,e)}if(t===8){if(r!==8)return!1
return A.cX(a,b,c,d,e)}if(p&&r===10)return A.d1(a,b,c,d,e)
return!1},
bL(a2,a3,a4,a5,a6){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1
if(!A.e(a2,a3.x,a4,a5.x,a6))return!1
t=a3.y
s=a5.y
r=t.a
q=s.a
p=r.length
o=q.length
if(p>o)return!1
n=o-p
m=t.b
l=s.b
k=m.length
j=l.length
if(p+k<o+j)return!1
for(i=0;i<p;++i){h=r[i]
if(!A.e(a2,q[i],a6,h,a4))return!1}for(i=0;i<n;++i){h=m[i]
if(!A.e(a2,q[p+i],a6,h,a4))return!1}for(i=0;i<j;++i){h=m[n+i]
if(!A.e(a2,l[i],a6,h,a4))return!1}g=t.c
f=s.c
e=g.length
d=f.length
for(c=0,b=0;b<d;b+=3){a=f[b]
for(;;){if(c>=e)return!1
a0=g[c]
c+=3
if(a<a0)return!1
a1=g[c-2]
if(a0<a){if(a1)return!1
continue}h=f[b+1]
if(a1&&!h)return!1
h=g[c-1]
if(!A.e(a2,f[b+2],a6,h,a4))return!1
break}}while(c<e){if(g[c+1])return!1
c+=3}return!0},
cX(a,b,c,d,e){var t,s,r,q,p,o=b.x,n=d.x
while(o!==n){t=a.tR[o]
if(t==null)return!1
if(typeof t=="string"){o=t
continue}s=t[n]
if(s==null)return!1
r=s.length
q=r>0?new Array(r):v.typeUniverse.sEA
for(p=0;p<r;++p)q[p]=A.aV(a,b,s[p])
return A.bH(a,q,null,c,d.y,e)}return A.bH(a,b.y,null,c,d.y,e)},
bH(a,b,c,d,e,f){var t,s=b.length
for(t=0;t<s;++t)if(!A.e(a,b[t],d,e[t],f))return!1
return!0},
d1(a,b,c,d,e){var t,s=b.y,r=d.y,q=s.length
if(q!==r.length)return!1
if(b.x!==d.x)return!1
for(t=0;t<q;++t)if(!A.e(a,s[t],c,r[t],e))return!1
return!0},
I(a){var t=a.w,s=!0
if(!(a===u.P||a===u.T))if(!A.D(a))if(t!==6)s=t===7&&A.I(a.x)
return s},
D(a){var t=a.w
return t===2||t===3||t===4||t===5||a===u.X},
bG(a,b){var t,s,r=Object.keys(b),q=r.length
for(t=0;t<q;++t){s=r[t]
a[s]=b[s]}},
aW(a){return a>0?new Array(a):v.typeUniverse.sEA},
q:function q(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
at:function at(){this.c=this.b=this.a=null},
aT:function aT(a){this.a=a},
aR:function aR(){},
au:function au(a){this.a=a},
c:function c(){},
b6(a,b,c){var t,s,r
if(a>4294967295)A.bW(A.aI(a,0,4294967295,"length",null))
t=A.A(new Array(a),c.m("j<0>"))
t.$flags=1
s=t
if(a!==0)for(t=s.length,r=0;r<t;++r)s[r]=b
return s},
ch(a,b,c){var t=J.c1(b)
if(!t.k())return a
if(c.length===0){do a+=A.o(t.gj())
while(t.k())}else{a+=A.o(t.gj())
while(t.k())a=a+c+A.o(t.gj())}return a},
aC(a){if(typeof a=="number"||A.bc(a)||a==null)return J.a6(a)
if(typeof a=="string")return JSON.stringify(a)
return A.cf(a)},
a9(a){return new A.aw(a)},
c3(a){return new A.a7(!1,null,null,a)},
aI(a,b,c,d,e){return new A.aH(b,c,!0,a,d,"Invalid value")},
bw(a){return new A.aQ(a)},
bv(a){return new A.aP(a)},
br(a){return new A.aA(a)},
bt(a,b,c){var t,s
if(A.dn(a))return b+"..."+c
t=new A.aM(b)
$.aX.push(a)
try{s=t
s.a=A.ch(s.a,a,", ")}finally{$.aX.pop()}t.a+=c
s=t.a
return s.charCodeAt(0)==0?s:s},
aB:function aB(){},
aw:function aw(a){this.a=a},
aO:function aO(){},
a7:function a7(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
aH:function aH(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
aQ:function aQ(a){this.a=a},
aP:function aP(a){this.a=a},
aA:function aA(a){this.a=a},
V:function V(){},
h:function h(){},
aL:function aL(){this.b=this.a=0},
aM:function aM(a){this.a=a},
aa(a,b){var t=a.length,s=t
for(;;){if(!(s>0&&a[s-1]===0))break;--s}if(s===0)return B.a
return new A.t(s===t?a:B.b.l(a,0,s),b)},
b4(a){if(a===0)return B.a
return A.aa(A.A([a],u.t),!1)},
bj(a,b){var t,s=a.length,r=b.length
if(s!==r)return s<r?-1:1
for(t=s-1;t>=0;--t){s=a[t]
r=b[t]
if(s!==r)return s<r?-1:1}return 0},
ax(a,b){var t,s=a.b
if(s!==b.b)return s?-1:1
t=A.bj(a.a,b.a)
return s?-t:t},
c4(a,b){var t,s,r,q,p,o,n=a.length,m=b.length
n=n>m?n:m
t=A.b6(n+1,0,u.S)
for(s=b.length,r=a.length,q=0,p=0;p<n;++p){o=p<r?q+a[p]:q
if(p<s)o+=b[p]
if(o>=1e9){o-=1e9
q=1}else q=0
t[p]=o}if(q!==0){t[n]=q
return t}return B.b.l(t,0,n)},
bl(a,b){var t,s,r,q,p,o,n=a.length,m=A.b6(n,0,u.S)
for(t=b.length,s=0,r=0;r<n;++r){q=a[r]
p=r<t?b[r]:0
o=q-s-p
if(o<0){o+=1e9
s=1}else s=0
m[r]=o}return m},
u(a,b){var t,s,r,q=a.b,p=b.b
if(q===p)return A.aa(A.c4(a.a,b.a),q)
t=a.a
s=b.a
r=A.bj(t,s)
if(r===0)return B.a
if(r>0)return A.aa(A.bl(t,s),q)
return A.aa(A.bl(s,t),p)},
n(a,b){var t,s,r,q,p,o,n=1e9
if(b===0||a.a.length===0)return B.a
t=a.a
s=A.b6(t.length+1,0,u.S)
for(r=t.length,q=0,p=0;p<r;++p){o=t[p]*b+q
s[p]=B.f.v(o,n)
q=B.f.B(o,n)}if(q!==0){s[r]=q;++r}return A.aa(B.b.l(s,0,r),a.b)},
bk(a,b){var t,s,r,q=0
if(a.b)while(A.ax(a,B.a)<0){a=A.u(a,b);--q}else{t=A.n(b,10)
for(s=t.a,r=!t.b;A.ax(a,t)>=0;){a=A.u(a,s.length===0?t:new A.t(s,r))
q+=10}for(s=b.a,r=!b.b;A.ax(a,b)>=0;){a=A.u(a,s.length===0?b:new A.t(s,r));++q}}return q},
dq(){var t,s,r,q,p,o,n,m,l,k,j,i,h,g=new A.aL()
$.bi()
t=$.b7.$0()
g.a=t
g.b=null
s=A.b4(1)
r=A.b4(0)
q=A.b4(1)
for(p=1,o=3,n=3,m=0,l=0;m<1000;){k=A.n(q,o)
t=A.u(A.n(s,4),r)
j=q.a
if(A.ax(A.u(t,j.length===0?q:new A.t(j,!q.b)),k)<0){l+=o;++m
i=A.n(s,10)
t=k.a
h=A.n(A.u(r,t.length===0?k:new A.t(t,!k.b)),10)
o=A.bk(A.n(A.u(A.n(s,3),r),10),q)-10*o
r=h
s=i}else{i=A.n(s,p)
h=A.n(A.u(A.n(s,2),r),n)
j=A.n(q,n)
o=A.bk(A.u(A.n(s,7*p+2),A.n(r,n)),j);++p
n+=2
q=j
r=h
s=i}}v.G.console.error("TIME_MS="+B.h.G(g.gD()/1000,3))
A.ds(""+l)},
t:function t(a,b){this.a=a
this.b=b},
bX(a){return v.mangledGlobalNames[a]},
ds(a){if(typeof dartPrint=="function"){dartPrint(a)
return}if(typeof console=="object"&&typeof console.log!="undefined"){console.log(a)
return}if(typeof print=="function"){print(a)
return}throw"Unable to print message: "+String(a)},
du(a){throw A.i(new A.aE("Field '"+a+"' has been assigned during initialization."),new Error())}},B={}
var w=[A,J,B]
var $={}
A.b5.prototype={}
J.ac.prototype={
h(a){return"Instance of '"+A.ar(a)+"'"},
gi(a){return A.C(A.bb(this))}}
J.ae.prototype={
h(a){return String(a)},
gi(a){return A.C(u.y)},
$ia:1}
J.L.prototype={
h(a){return"null"},
$ia:1}
J.P.prototype={$id:1}
J.w.prototype={
h(a){return String(a)}}
J.aq.prototype={}
J.X.prototype={}
J.v.prototype={
h(a){var t=a[$.c_()]
if(t==null)t=a[$.bZ()]
if(t==null)return this.A(a)
return"JavaScript function for "+J.a6(t)}}
J.O.prototype={
h(a){return String(a)}}
J.Q.prototype={
h(a){return String(a)}}
J.j.prototype={
l(a,b,c){var t=a.length
if(b>t)throw A.f(A.aI(b,0,t,"start",null))
if(c<b||c>t)throw A.f(A.aI(c,b,t,"end",null))
if(b===c)return A.A([],A.av(a))
return A.A(a.slice(b,c),A.av(a))},
h(a){return A.bt(a,"[","]")},
gu(a){return new J.a8(a,a.length,A.av(a).m("a8<1>"))}}
J.ad.prototype={
H(a){var t,s,r
if(!Array.isArray(a))return null
t=a.$flags|0
if((t&4)!==0)s="const, "
else if((t&2)!==0)s="unmodifiable, "
else s=(t&1)!==0?"fixed, ":""
r="Instance of '"+A.ar(a)+"'"
if(s==="")return r
return r+" ("+s+"length: "+a.length+")"}}
J.aD.prototype={}
J.a8.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=r.length
if(s.b!==q)throw A.f(A.dt(r))
t=s.c
if(t>=q){s.d=null
return!1}s.d=r[t]
s.c=t+1
return!0}}
J.M.prototype={
F(a){var t,s
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){t=a|0
return a===t?t:t-1}s=Math.floor(a)
if(isFinite(s))return s
throw A.f(A.bw(""+a+".floor()"))},
G(a,b){var t,s
if(b>20)throw A.f(A.aI(b,0,20,"fractionDigits",null))
t=a.toFixed(b)
if(a===0)s=1/a<0
else s=!1
if(s)return"-"+t
return t},
h(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
v(a,b){var t=a%b
if(t===0)return 0
if(t>0)return t
return t+b},
B(a,b){return(a|0)===a?a/b|0:this.C(a,b)},
C(a,b){var t=a/b
if(t>=-2147483648&&t<=2147483647)return t|0
if(t>0){if(t!==1/0)return Math.floor(t)}else if(t>-1/0)return Math.ceil(t)
throw A.f(A.bw("Result of truncating division is "+A.o(t)+": "+A.o(a)+" ~/ "+b))},
gi(a){return A.C(u.H)},
$im:1}
J.K.prototype={
gi(a){return A.C(u.S)},
$ia:1,
$ib:1}
J.af.prototype={
gi(a){return A.C(u.i)},
$ia:1}
J.N.prototype={
h(a){return a},
gi(a){return A.C(u.N)},
$ia:1,
$ias:1}
A.aE.prototype={
h(a){return"LateInitializationError: "+this.a}}
A.ag.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=J.de(r),p=q.gn(r)
if(s.b!==p)throw A.f(A.br(r))
t=s.c
if(t>=p){s.d=null
return!1}s.d=q.E(r,t);++s.c
return!0}}
A.J.prototype={}
A.aF.prototype={
$0(){return B.h.F(1000*this.a.now())}}
A.W.prototype={}
A.y.prototype={
h(a){var t=this.constructor,s=t==null?null:t.name
return"Closure '"+A.bY(s==null?"unknown":s)+"'"},
gI(){return this},
$C:"$1",
$R:1,
$D:null}
A.ay.prototype={$C:"$0",$R:0}
A.az.prototype={$C:"$2",$R:2}
A.aN.prototype={}
A.aK.prototype={
h(a){var t=this.$static_name
if(t==null)return"Closure of unknown static method"
return"Closure '"+A.bY(t)+"'"}}
A.ab.prototype={
h(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.ar(this.a)+"'")}}
A.aJ.prototype={
h(a){return"RuntimeError: "+this.a}}
A.b_.prototype={
$1(a){return this.a(a)}}
A.b0.prototype={
$2(a,b){return this.a(a,b)}}
A.b1.prototype={
$1(a){return this.a(a)}}
A.E.prototype={
gi(a){return B.u},
$ia:1}
A.T.prototype={}
A.ah.prototype={
gi(a){return B.v},
$ia:1}
A.F.prototype={
gn(a){return a.length},
$ik:1}
A.R.prototype={}
A.S.prototype={}
A.ai.prototype={
gi(a){return B.w},
$ia:1}
A.aj.prototype={
gi(a){return B.x},
$ia:1}
A.ak.prototype={
gi(a){return B.y},
$ia:1}
A.al.prototype={
gi(a){return B.z},
$ia:1}
A.am.prototype={
gi(a){return B.A},
$ia:1}
A.an.prototype={
gi(a){return B.B},
$ia:1}
A.ao.prototype={
gi(a){return B.C},
$ia:1}
A.U.prototype={
gi(a){return B.D},
gn(a){return a.length},
$ia:1}
A.ap.prototype={
gi(a){return B.E},
gn(a){return a.length},
$ia:1}
A.Y.prototype={}
A.Z.prototype={}
A.a_.prototype={}
A.a0.prototype={}
A.q.prototype={
m(a){return A.aV(v.typeUniverse,this,a)},
J(a){return A.cx(v.typeUniverse,this,a)}}
A.at.prototype={}
A.aT.prototype={
h(a){return A.l(this.a,null)}}
A.aR.prototype={
h(a){return this.a}}
A.au.prototype={}
A.c.prototype={
gu(a){return new A.ag(a,a.length,A.a5(a).m("ag<c.E>"))},
E(a,b){return a[b]},
h(a){return A.bt(a,"[","]")}}
A.aB.prototype={}
A.aw.prototype={
h(a){var t=this.a
if(t!=null)return"Assertion failed: "+A.aC(t)
return"Assertion failed"}}
A.aO.prototype={}
A.a7.prototype={
gq(){return"Invalid argument"+(!this.a?"(s)":"")},
gp(){return""},
h(a){var t=this,s=t.c,r=s==null?"":" ("+s+")",q=t.d,p=q==null?"":": "+q,o=t.gq()+r+p
if(!t.a)return o
return o+t.gp()+": "+A.aC(t.gt())},
gt(){return this.b}}
A.aH.prototype={
gt(){return this.b},
gq(){return"RangeError"},
gp(){var t,s=this.e,r=this.f
if(s==null)t=r!=null?": Not less than or equal to "+A.o(r):""
else if(r==null)t=": Not greater than or equal to "+A.o(s)
else if(r>s)t=": Not in inclusive range "+A.o(s)+".."+A.o(r)
else t=r<s?": Valid value range is empty":": Only valid value is "+A.o(s)
return t}}
A.aQ.prototype={
h(a){return"Unsupported operation: "+this.a}}
A.aP.prototype={
h(a){return"UnimplementedError: "+this.a}}
A.aA.prototype={
h(a){var t=this.a
if(t==null)return"Concurrent modification during iteration."
return"Concurrent modification during iteration: "+A.aC(t)+"."}}
A.V.prototype={
h(a){return"null"}}
A.h.prototype={$ih:1,
h(a){return"Instance of '"+A.ar(this)+"'"},
gi(a){return A.dg(this)},
toString(){return this.h(this)}}
A.aL.prototype={
gD(){var t,s=this.b
if(s==null)s=$.b7.$0()
t=s-this.a
if($.bi()===1e6)return t
return t*1000}}
A.aM.prototype={
h(a){var t=this.a
return t.charCodeAt(0)==0?t:t}}
A.t.prototype={};(function aliases(){var t=J.w.prototype
t.A=t.h})();(function installTearOffs(){var t=hunkHelpers._static_0
t(A,"d5","cd",0)})();(function inheritance(){var t=hunkHelpers.mixin,s=hunkHelpers.inherit,r=hunkHelpers.inheritMany
s(A.h,null)
r(A.h,[A.b5,J.ac,A.W,J.a8,A.aB,A.ag,A.J,A.y,A.q,A.at,A.aT,A.c,A.V,A.aL,A.aM,A.t])
r(J.ac,[J.ae,J.L,J.P,J.O,J.Q,J.M,J.N])
r(J.P,[J.w,J.j,A.E,A.T])
r(J.w,[J.aq,J.X,J.v])
s(J.ad,A.W)
s(J.aD,J.j)
r(J.M,[J.K,J.af])
r(A.aB,[A.aE,A.aJ,A.aR,A.aw,A.aO,A.a7,A.aQ,A.aP,A.aA])
r(A.y,[A.ay,A.az,A.aN,A.b_,A.b1])
s(A.aF,A.ay)
r(A.aN,[A.aK,A.ab])
s(A.b0,A.az)
r(A.T,[A.ah,A.F])
r(A.F,[A.Y,A.a_])
s(A.Z,A.Y)
s(A.R,A.Z)
s(A.a0,A.a_)
s(A.S,A.a0)
r(A.R,[A.ai,A.aj])
r(A.S,[A.ak,A.al,A.am,A.an,A.ao,A.U,A.ap])
s(A.au,A.aR)
s(A.aH,A.a7)
t(A.Y,A.c)
t(A.Z,A.J)
t(A.a_,A.c)
t(A.a0,A.J)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{b:"int",m:"double",bT:"num",as:"String",bQ:"bool",V:"Null",cc:"List",h:"Object",dG:"Map",d:"JSObject"},mangledNames:{},types:["b()"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti")}
A.cw(v.typeUniverse,JSON.parse('{"aq":"w","X":"w","v":"w","dH":"E","ae":{"a":[]},"L":{"a":[]},"P":{"d":[]},"w":{"d":[]},"j":{"d":[]},"ad":{"W":[]},"aD":{"j":["1"],"d":[]},"M":{"m":[]},"K":{"m":[],"b":[],"a":[]},"af":{"m":[],"a":[]},"N":{"as":[],"a":[]},"E":{"d":[],"a":[]},"T":{"d":[]},"ah":{"d":[],"a":[]},"F":{"k":["1"],"d":[]},"R":{"c":["m"],"k":["m"],"d":[]},"S":{"c":["b"],"k":["b"],"d":[]},"ai":{"c":["m"],"k":["m"],"d":[],"a":[],"c.E":"m"},"aj":{"c":["m"],"k":["m"],"d":[],"a":[],"c.E":"m"},"ak":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"al":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"am":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"an":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"ao":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"U":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"},"ap":{"c":["b"],"k":["b"],"d":[],"a":[],"c.E":"b"}}'))
A.cv(v.typeUniverse,JSON.parse('{"J":1,"F":1}'))
var u=(function rtii(){var t=A.be
return{Z:t("dC"),s:t("j<as>"),b:t("j<@>"),t:t("j<b>"),T:t("L"),m:t("d"),g:t("v"),p:t("k<@>"),P:t("V"),K:t("h"),L:t("dI"),N:t("as"),R:t("a"),o:t("X"),y:t("bQ"),i:t("m"),S:t("b"),O:t("bs<V>?"),z:t("d?"),X:t("h?"),v:t("as?"),u:t("bQ?"),I:t("m?"),w:t("b?"),n:t("bT?"),H:t("bT")}})();(function constants(){var t=hunkHelpers.makeConstList
B.p=J.ac.prototype
B.b=J.j.prototype
B.f=J.K.prototype
B.h=J.M.prototype
B.q=J.v.prototype
B.r=J.P.prototype
B.i=J.aq.prototype
B.c=J.X.prototype
B.t=t([],u.t)
B.a=new A.t(B.t,!1)
B.d=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.j=function() {
  var toStringFunction = Object.prototype.toString;
  function getTag(o) {
    var s = toStringFunction.call(o);
    return s.substring(8, s.length - 1);
  }
  function getUnknownTag(object, tag) {
    if (/^HTML[A-Z].*Element$/.test(tag)) {
      var name = toStringFunction.call(object);
      if (name == "[object Object]") return null;
      return "HTMLElement";
    }
  }
  function getUnknownTagGenericBrowser(object, tag) {
    if (object instanceof HTMLElement) return "HTMLElement";
    return getUnknownTag(object, tag);
  }
  function prototypeForTag(tag) {
    if (typeof window == "undefined") return null;
    if (typeof window[tag] == "undefined") return null;
    var constructor = window[tag];
    if (typeof constructor != "function") return null;
    return constructor.prototype;
  }
  function discriminator(tag) { return null; }
  var isBrowser = typeof HTMLElement == "function";
  return {
    getTag: getTag,
    getUnknownTag: isBrowser ? getUnknownTagGenericBrowser : getUnknownTag,
    prototypeForTag: prototypeForTag,
    discriminator: discriminator };
}
B.o=function(getTagFallback) {
  return function(hooks) {
    if (typeof navigator != "object") return hooks;
    var userAgent = navigator.userAgent;
    if (typeof userAgent != "string") return hooks;
    if (userAgent.indexOf("DumpRenderTree") >= 0) return hooks;
    if (userAgent.indexOf("Chrome") >= 0) {
      function confirm(p) {
        return typeof window == "object" && window[p] && window[p].name == p;
      }
      if (confirm("Window") && confirm("HTMLElement")) return hooks;
    }
    hooks.getTag = getTagFallback;
  };
}
B.k=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.n=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Firefox") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "GeoGeolocation": "Geolocation",
    "Location": "!Location",
    "WorkerMessageEvent": "MessageEvent",
    "XMLDocument": "!Document"};
  function getTagFirefox(o) {
    var tag = getTag(o);
    return quickMap[tag] || tag;
  }
  hooks.getTag = getTagFirefox;
}
B.m=function(hooks) {
  if (typeof navigator != "object") return hooks;
  var userAgent = navigator.userAgent;
  if (typeof userAgent != "string") return hooks;
  if (userAgent.indexOf("Trident/") == -1) return hooks;
  var getTag = hooks.getTag;
  var quickMap = {
    "BeforeUnloadEvent": "Event",
    "DataTransfer": "Clipboard",
    "HTMLDDElement": "HTMLElement",
    "HTMLDTElement": "HTMLElement",
    "HTMLPhraseElement": "HTMLElement",
    "Position": "Geoposition"
  };
  function getTagIE(o) {
    var tag = getTag(o);
    var newTag = quickMap[tag];
    if (newTag) return newTag;
    if (tag == "Object") {
      if (window.DataView && (o instanceof window.DataView)) return "DataView";
    }
    return tag;
  }
  function prototypeForTagIE(tag) {
    var constructor = window[tag];
    if (constructor == null) return null;
    return constructor.prototype;
  }
  hooks.getTag = getTagIE;
  hooks.prototypeForTag = prototypeForTagIE;
}
B.l=function(hooks) {
  var getTag = hooks.getTag;
  var prototypeForTag = hooks.prototypeForTag;
  function getTagFixed(o) {
    var tag = getTag(o);
    if (tag == "Document") {
      if (!!o.xmlVersion) return "!Document";
      return "!HTMLDocument";
    }
    return tag;
  }
  function prototypeForTagFixed(tag) {
    if (tag == "Document") return null;
    return prototypeForTag(tag);
  }
  hooks.getTag = getTagFixed;
  hooks.prototypeForTag = prototypeForTagFixed;
}
B.e=function(hooks) { return hooks; }

B.u=A.r("dw")
B.v=A.r("dx")
B.w=A.r("dA")
B.x=A.r("dB")
B.y=A.r("dD")
B.z=A.r("dE")
B.A=A.r("dF")
B.B=A.r("dK")
B.C=A.r("dL")
B.D=A.r("dM")
B.E=A.r("dN")})();(function staticFields(){$.aS=null
$.aX=A.A([],A.be("j<h>"))
$.aG=0
$.b7=A.d5()
$.bo=null
$.bn=null
$.bS=null
$.bP=null
$.bV=null
$.aY=null
$.b2=null
$.bg=null})();(function lazyInitializers(){var t=hunkHelpers.lazyFinal
t($,"dz","c_",()=>A.aZ("_$dart_dartClosure"))
t($,"dy","bZ",()=>A.aZ("_$dart_dartClosure_dartJSInterop"))
t($,"dO","c0",()=>A.A([new J.ad()],A.be("j<W>")))
t($,"dJ","bi",()=>{A.ce()
return $.aG})})();(function nativeSupport(){!function(){var t=function(a){var n={}
n[a]=1
return Object.keys(hunkHelpers.convertToFastObject(n))[0]}
v.getIsolateTag=function(a){return t("___dart_"+a+v.isolateTag)}
var s="___dart_isolate_tags_"
var r=Object[s]||(Object[s]=Object.create(null))
var q="_ZxYxX"
for(var p=0;;p++){var o=t(q+"_"+p+"_")
if(!(o in r)){r[o]=1
v.isolateTag=o
break}}v.dispatchPropertyName=v.getIsolateTag("dispatch_record")}()
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.E,SharedArrayBuffer:A.E,ArrayBufferView:A.T,DataView:A.ah,Float32Array:A.ai,Float64Array:A.aj,Int16Array:A.ak,Int32Array:A.al,Int8Array:A.am,Uint16Array:A.an,Uint32Array:A.ao,Uint8ClampedArray:A.U,CanvasPixelArray:A.U,Uint8Array:A.ap})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.F.$nativeSuperclassTag="ArrayBufferView"
A.Y.$nativeSuperclassTag="ArrayBufferView"
A.Z.$nativeSuperclassTag="ArrayBufferView"
A.R.$nativeSuperclassTag="ArrayBufferView"
A.a_.$nativeSuperclassTag="ArrayBufferView"
A.a0.$nativeSuperclassTag="ArrayBufferView"
A.S.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var t=document.scripts
function onLoad(b){for(var r=0;r<t.length;++r){t[r].removeEventListener("load",onLoad,false)}a(b.target)}for(var s=0;s<t.length;++s){t[s].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var t=A.dq
if(typeof dartMainRunner==="function"){dartMainRunner(t,[])}else{t([])}})})()