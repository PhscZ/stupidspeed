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
if(a[b]!==t){A.de(b)}a[b]=s}var r=a[b]
a[c]=function(){return r}
return r}}function makeConstList(a,b){if(b!=null)A.aN(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var t=0;t<a.length;++t){convertToFastObject(a[t])}}var y=0
function instanceTearOffGetter(a,b){var t=null
return a?function(c){if(t===null)t=A.b2(b)
return new t(c,this)}:function(){if(t===null)t=A.b2(b)
return new t(this,null)}}function staticTearOffGetter(a){var t=null
return function(){if(t===null)t=A.b2(a).prototype
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
b5(a,b,c,d){return{i:a,p:b,e:c,x:d}},
bD(a){var t,s,r,q,p,o="_$dart_js",n=a[v.dispatchPropertyName]
if(n==null)if($.b4==null){A.d4()
n=a[v.dispatchPropertyName]}if(n!=null){t=n.p
if(!1===t)return n.i
if(!0===t)return a
s=Object.getPrototypeOf(a)
if(t===s)return n.i
if(n.e===s)throw A.i(A.bg("Return interceptor for "+A.O(t(a,n))))}r=a.constructor
if(r==null)q=null
else{p=$.aI
if(p==null)p=$.aI=A.aQ(o)
q=r[p]}if(q!=null)return q
q=A.d9(a)
if(q!=null)return q
if(typeof a=="function")return B.o
t=Object.getPrototypeOf(a)
if(t==null)return B.e
if(t===Object.prototype)return B.e
if(typeof r=="function"){p=$.aI
if(p==null)p=$.aI=A.aQ(o)
Object.defineProperty(r,p,{value:B.a,enumerable:false,writable:true,configurable:true})
return B.a}return B.a},
Y(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.F.prototype
return J.a6.prototype}if(typeof a=="string")return J.a7.prototype
if(a==null)return J.G.prototype
if(typeof a=="boolean")return J.a5.prototype
if(Array.isArray(a))return J.n.prototype
if(typeof a!="object"){if(typeof a=="function")return J.u.prototype
if(typeof a=="symbol")return J.a9.prototype
if(typeof a=="bigint")return J.a8.prototype
return a}if(a instanceof A.h)return a
return J.bD(a)},
d0(a){if(a==null)return a
if(Array.isArray(a))return J.n.prototype
if(typeof a!="object"){if(typeof a=="function")return J.u.prototype
if(typeof a=="symbol")return J.a9.prototype
if(typeof a=="bigint")return J.a8.prototype
return a}if(a instanceof A.h)return a
return J.bD(a)},
bO(a){return J.d0(a).gn(a)},
bP(a){return J.Y(a).gi(a)},
a_(a){return J.Y(a).h(a)},
a3:function a3(){},
a5:function a5(){},
G:function G(){},
I:function I(){},
q:function q(){},
ak:function ak(){},
Q:function Q(){},
u:function u(){},
a8:function a8(){},
a9:function a9(){},
n:function n(a){this.$ti=a},
a4:function a4(){},
aw:function aw(a){this.$ti=a},
a0:function a0(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
H:function H(){},
F:function F(){},
a6:function a6(){},
a7:function a7(){}},A={aW:function aW(){},
d8(a){var t,s
for(t=$.aO.length,s=0;s<t;++s)if(a===$.aO[s])return!0
return!1},
ax:function ax(a){this.a=a},
aa:function aa(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
E:function E(){},
bJ(a){var t=A.bI(a)
if(t!=null)return t
return"minified:"+a},
dA(a,b){var t
if(b!=null){t=b.x
if(t!=null)return t}return u.p.b(a)},
O(a){var t
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
t=J.a_(a)
return t},
al(a){var t,s,r,q
if(a instanceof A.h)return A.k(A.Z(a),null)
t=J.Y(a)
if(t===B.m||t===B.p||u.o.b(a)){s=B.b(a)
if(s!=="Object"&&s!=="")return s
r=a.constructor
if(typeof r=="function"){q=r.name
if(typeof q=="string"&&q!=="Object"&&q!=="")return q}}return A.k(A.Z(a),null)},
c1(a){var t,s,r
if(typeof a=="number"||A.b1(a))return J.a_(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.t)return a.h(0)
t=$.bN()
for(s=0;s<1;++s){r=t[s].A(a)
if(r!=null)return r}return"Instance of '"+A.al(a)+"'"},
c_(){return Date.now()},
c0(){var t,s
if($.az!==0)return
$.az=1000
if(typeof window=="undefined")return
t=window
if(t==null)return
if(!!t.dartUseDateNowForTicks)return
s=t.performance
if(s==null)return
if(typeof s.now!="function")return
$.az=1e6
$.be=new A.ay(s)},
i(a){return A.f(a,new Error())},
f(a,b){var t
if(a==null)a=new A.aE()
b.dartException=a
t=A.df
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:t})
b.name=""}else b.toString=t
return b},
df(){return J.a_(this.dartException)},
dd(a,b){throw A.f(a,b==null?new Error():b)},
dc(a){throw A.i(A.bb(a))},
bX(a1){var t,s,r,q,p,o,n,m,l,k,j=a1.co,i=a1.iS,h=a1.iI,g=a1.nDA,f=a1.aI,e=a1.fs,d=a1.cs,c=e[0],b=d[0],a=j[c],a0=a1.fT
a0.toString
t=i?Object.create(new A.aB().constructor.prototype):Object.create(new A.a2(null,null).constructor.prototype)
t.$initialize=t.constructor
s=i?function static_tear_off(){this.$initialize()}:function tear_off(a2,a3){this.$initialize(a2,a3)}
t.constructor=s
s.prototype=t
t.$_name=c
t.$_target=a
r=!i
if(r)q=A.ba(c,a,h,g)
else{t.$static_name=c
q=a}t.$S=A.bT(a0,i,h)
t[b]=q
for(p=q,o=1;o<e.length;++o){n=e[o]
if(typeof n=="string"){m=j[n]
l=n
n=m}else l=""
k=d[o]
if(k!=null){if(r)n=A.ba(l,n,h,g)
t[k]=n}if(o===f)p=n}t.$C=p
t.$R=a1.rC
t.$D=a1.dV
return s},
bT(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.i("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.bR)}throw A.i("Error in functionType of tearoff")},
bU(a,b,c,d){var t=A.b9
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,t)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,t)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,t)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,t)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,t)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,t)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,t)}},
ba(a,b,c,d){if(c)return A.bW(a,b,d)
return A.bU(b.length,d,a,b)},
bV(a,b,c,d){var t=A.b9,s=A.bS
switch(b?-1:a){case 0:throw A.i(new A.aA("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,s,t)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,s,t)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,s,t)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,s,t)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,s,t)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,s,t)
default:return function(e,f,g){return function(){var r=[g(this)]
Array.prototype.push.apply(r,arguments)
return e.apply(f(this),r)}}(d,s,t)}},
bW(a,b,c){var t,s
if($.b7==null)$.b7=A.b6("interceptor")
if($.b8==null)$.b8=A.b6("receiver")
t=b.length
s=A.bV(t,c,a,b)
return s},
b2(a){return A.bX(a)},
bR(a,b){return A.aL(v.typeUniverse,A.Z(a.a),b)},
b9(a){return a.a},
bS(a){return a.b},
b6(a){var t,s,r,q=new A.a2("receiver","interceptor"),p=Object.getOwnPropertyNames(q)
p.$flags=1
t=p
for(p=t.length,s=0;s<p;++s){r=t[s]
if(q[r]===a)return r}throw A.i(A.bQ("Field name "+a+" not found."))},
aQ(a){return v.getIsolateTag(a)},
d9(a){var t,s,r,q,p,o=$.bE.$1(a),n=$.aP[o]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.aU[o]
if(t!=null)return t
s=v.interceptorsByTag[o]
if(s==null){r=$.bA.$2(a,o)
if(r!=null){n=$.aP[r]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.aU[r]
if(t!=null)return t
s=v.interceptorsByTag[r]
o=r}}if(s==null)return null
t=s.prototype
q=o[0]
if(q==="!"){n=A.aV(t)
$.aP[o]=n
Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}if(q==="~"){$.aU[o]=t
return t}if(q==="-"){p=A.aV(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}if(q==="+")return A.bG(a,t)
if(q==="*")throw A.i(A.bg(o))
if(v.leafTags[o]===true){p=A.aV(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}else return A.bG(a,t)},
bG(a,b){var t=Object.getPrototypeOf(a)
Object.defineProperty(t,v.dispatchPropertyName,{value:J.b5(b,t,null,null),enumerable:false,writable:true,configurable:true})
return b},
aV(a){return J.b5(a,!1,null,!!a.$ij)},
db(a,b,c){var t=b.prototype
if(v.leafTags[a]===true)return A.aV(t)
else return J.b5(t,c,null,null)},
d4(){if(!0===$.b4)return
$.b4=!0
A.d5()},
d5(){var t,s,r,q,p,o,n,m
$.aP=Object.create(null)
$.aU=Object.create(null)
A.d3()
t=v.interceptorsByTag
s=Object.getOwnPropertyNames(t)
if(typeof window!="undefined"){window
r=function(){}
for(q=0;q<s.length;++q){p=s[q]
o=$.bH.$1(p)
if(o!=null){n=A.db(p,t[p],o)
if(n!=null){Object.defineProperty(o,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
r.prototype=o}}}}for(q=0;q<s.length;++q){p=s[q]
if(/^[A-Za-z_]/.test(p)){m=t[p]
t["!"+p]=m
t["~"+p]=m
t["-"+p]=m
t["+"+p]=m
t["*"+p]=m}}},
d3(){var t,s,r,q,p,o,n=B.f()
n=A.C(B.h,A.C(B.i,A.C(B.c,A.C(B.c,A.C(B.j,A.C(B.k,A.C(B.l(B.b),n)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){t=dartNativeDispatchHooksTransformer
if(typeof t=="function")t=[t]
if(Array.isArray(t))for(s=0;s<t.length;++s){r=t[s]
if(typeof r=="function")n=r(n)||n}}q=n.getTag
p=n.getUnknownTag
o=n.prototypeForTag
$.bE=new A.aR(q)
$.bA=new A.aS(p)
$.bH=new A.aT(o)},
C(a,b){return a(b)||b},
d_(a,b){var t=b.length,s=v.rttc[""+t+";"+a]
if(s==null)return null
if(t===0)return s
if(t===s.length)return s.apply(null,b)
return s(b)},
ay:function ay(a){this.a=a},
P:function P(){},
t:function t(){},
ar:function ar(){},
as:function as(){},
aD:function aD(){},
aB:function aB(){},
a2:function a2(a,b){this.a=a
this.b=b},
aA:function aA(a){this.a=a},
aR:function aR(a){this.a=a},
aS:function aS(a){this.a=a},
aT:function aT(a){this.a=a},
z:function z(){},
L:function L(){},
ab:function ab(){},
A:function A(){},
J:function J(){},
K:function K(){},
ac:function ac(){},
ad:function ad(){},
ae:function ae(){},
af:function af(){},
ag:function ag(){},
ah:function ah(){},
ai:function ai(){},
M:function M(){},
aj:function aj(){},
R:function R(){},
S:function S(){},
T:function T(){},
U:function U(){},
aX(a,b){var t=b.c
return t==null?b.c=A.W(a,"bc",[b.x]):t},
bf(a){var t=a.w
if(t===6||t===7)return A.bf(a.x)
return t===11||t===12},
c2(a){return a.as},
b3(a){return A.aK(v.typeUniverse,a,!1)},
w(a0,a1,a2,a3){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=a1.w
switch(a){case 5:case 1:case 2:case 3:case 4:return a1
case 6:t=a1.x
s=A.w(a0,t,a2,a3)
if(s===t)return a1
return A.bo(a0,s,!0)
case 7:t=a1.x
s=A.w(a0,t,a2,a3)
if(s===t)return a1
return A.bn(a0,s,!0)
case 8:r=a1.y
q=A.B(a0,r,a2,a3)
if(q===r)return a1
return A.W(a0,a1.x,q)
case 9:p=a1.x
o=A.w(a0,p,a2,a3)
n=a1.y
m=A.B(a0,n,a2,a3)
if(o===p&&m===n)return a1
return A.aY(a0,o,m)
case 10:l=a1.x
k=a1.y
j=A.B(a0,k,a2,a3)
if(j===k)return a1
return A.bp(a0,l,j)
case 11:i=a1.x
h=A.w(a0,i,a2,a3)
g=a1.y
f=A.cX(a0,g,a2,a3)
if(h===i&&f===g)return a1
return A.bm(a0,h,f)
case 12:e=a1.y
a3+=e.length
d=A.B(a0,e,a2,a3)
p=a1.x
o=A.w(a0,p,a2,a3)
if(d===e&&o===p)return a1
return A.aZ(a0,o,d,!0)
case 13:c=a1.x
if(c<a3)return a1
b=a2[c-a3]
if(b==null)return a1
return b
default:throw A.i(A.a1("Attempted to substitute unexpected RTI kind "+a))}},
B(a,b,c,d){var t,s,r,q,p=b.length,o=A.aM(p)
for(t=!1,s=0;s<p;++s){r=b[s]
q=A.w(a,r,c,d)
if(q!==r)t=!0
o[s]=q}return t?o:b},
cY(a,b,c,d){var t,s,r,q,p,o,n=b.length,m=A.aM(n)
for(t=!1,s=0;s<n;s+=3){r=b[s]
q=b[s+1]
p=b[s+2]
o=A.w(a,p,c,d)
if(o!==p)t=!0
m.splice(s,3,r,q,o)}return t?m:b},
cX(a,b,c,d){var t,s=b.a,r=A.B(a,s,c,d),q=b.b,p=A.B(a,q,c,d),o=b.c,n=A.cY(a,o,c,d)
if(r===s&&p===q&&n===o)return b
t=new A.an()
t.a=r
t.b=p
t.c=n
return t},
aN(a,b){a[v.arrayRti]=b
return a},
bC(a){var t=a.$S
if(t!=null){if(typeof t=="number")return A.d2(t)
return a.$S()}return null},
d6(a,b){var t
if(A.bf(b))if(a instanceof A.t){t=A.bC(a)
if(t!=null)return t}return A.Z(a)},
Z(a){if(a instanceof A.h)return A.bv(a)
if(Array.isArray(a))return A.b_(a)
return A.b0(J.Y(a))},
b_(a){var t=a[v.arrayRti],s=u.b
if(t==null)return s
if(t.constructor!==s.constructor)return s
return t},
bv(a){var t=a.$ti
return t!=null?t:A.b0(a)},
b0(a){var t=a.constructor,s=t.$ccache
if(s!=null)return s
return A.cG(a,t)},
cG(a,b){var t=a instanceof A.t?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,s=A.ck(v.typeUniverse,t.name)
b.$ccache=s
return s},
d2(a){var t,s=v.types,r=s[a]
if(typeof r=="string"){t=A.aK(v.typeUniverse,r,!1)
s[a]=t
return t}return r},
d1(a){return A.x(A.bv(a))},
cW(a){var t=a instanceof A.t?A.bC(a):null
if(t!=null)return t
if(u.R.b(a))return J.bP(a).a
if(Array.isArray(a))return A.b_(a)
return A.Z(a)},
x(a){var t=a.r
return t==null?a.r=new A.aJ(a):t},
p(a){return A.x(A.aK(v.typeUniverse,a,!1))},
cF(a){var t=this
t.b=A.cV(t)
return t.b(a)},
cV(a){var t,s,r,q
if(a===u.K)return A.cN
if(A.y(a))return A.cR
t=a.w
if(t===6)return A.cD
if(t===1)return A.by
if(t===7)return A.cH
s=A.cU(a)
if(s!=null)return s
if(t===8){r=a.x
if(a.y.every(A.y)){a.f="$i"+r
if(r==="bZ")return A.cL
if(a===u.m)return A.cK
return A.cQ}}else if(t===10){q=A.d_(a.x,a.y)
return q==null?A.by:q}return A.cB},
cU(a){if(a.w===8){if(a===u.S)return A.cI
if(a===u.i||a===u.H)return A.cM
if(a===u.N)return A.cP
if(a===u.y)return A.b1}return null},
cE(a){var t=this,s=A.cA
if(A.y(t))s=A.cz
else if(t===u.K)s=A.cw
else if(A.D(t)){s=A.cC
if(t===u.t)s=A.cr
else if(t===u.v)s=A.cy
else if(t===u.u)s=A.cn
else if(t===u.n)s=A.cv
else if(t===u.I)s=A.cp
else if(t===u.z)s=A.ct}else if(t===u.S)s=A.cq
else if(t===u.N)s=A.cx
else if(t===u.y)s=A.cm
else if(t===u.H)s=A.cu
else if(t===u.i)s=A.co
else if(t===u.m)s=A.cs
t.a=s
return t.a(a)},
cB(a){var t=this
if(a==null)return A.D(t)
return A.d7(v.typeUniverse,A.d6(a,t),t)},
cD(a){if(a==null)return!0
return this.x.b(a)},
cQ(a){var t,s=this
if(a==null)return A.D(s)
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.Y(a)[t]},
cL(a){var t,s=this
if(a==null)return A.D(s)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.Y(a)[t]},
cK(a){var t=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.h)return!!a[t.f]
return!0}if(typeof a=="function")return!0
return!1},
bx(a){if(typeof a=="object"){if(a instanceof A.h)return u.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
cA(a){var t=this
if(a==null){if(A.D(t))return a}else if(t.b(a))return a
throw A.f(A.bt(a,t),new Error())},
cC(a){var t=this
if(a==null||t.b(a))return a
throw A.f(A.bt(a,t),new Error())},
bt(a,b){return new A.ao("TypeError: "+A.bi(a,A.k(b,null)))},
bi(a,b){return A.av(a)+": type '"+A.k(A.cW(a),null)+"' is not a subtype of type '"+b+"'"},
m(a,b){return new A.ao("TypeError: "+A.bi(a,b))},
cH(a){var t=this
return t.x.b(a)||A.aX(v.typeUniverse,t).b(a)},
cN(a){return a!=null},
cw(a){if(a!=null)return a
throw A.f(A.m(a,"Object"),new Error())},
cR(a){return!0},
cz(a){return a},
by(a){return!1},
b1(a){return!0===a||!1===a},
cm(a){if(!0===a)return!0
if(!1===a)return!1
throw A.f(A.m(a,"bool"),new Error())},
cn(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.f(A.m(a,"bool?"),new Error())},
co(a){if(typeof a=="number")return a
throw A.f(A.m(a,"double"),new Error())},
cp(a){if(typeof a=="number")return a
if(a==null)return a
throw A.f(A.m(a,"double?"),new Error())},
cI(a){return typeof a=="number"&&Math.floor(a)===a},
cq(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.f(A.m(a,"int"),new Error())},
cr(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.f(A.m(a,"int?"),new Error())},
cM(a){return typeof a=="number"},
cu(a){if(typeof a=="number")return a
throw A.f(A.m(a,"num"),new Error())},
cv(a){if(typeof a=="number")return a
if(a==null)return a
throw A.f(A.m(a,"num?"),new Error())},
cP(a){return typeof a=="string"},
cx(a){if(typeof a=="string")return a
throw A.f(A.m(a,"String"),new Error())},
cy(a){if(typeof a=="string")return a
if(a==null)return a
throw A.f(A.m(a,"String?"),new Error())},
cs(a){if(A.bx(a))return a
throw A.f(A.m(a,"JSObject"),new Error())},
ct(a){if(a==null)return a
if(A.bx(a))return a
throw A.f(A.m(a,"JSObject?"),new Error())},
bz(a,b){var t,s,r
for(t="",s="",r=0;r<a.length;++r,s=", ")t+=s+A.k(a[r],b)
return t},
cT(a,b){var t,s,r,q,p,o,n=a.x,m=a.y
if(""===n)return"("+A.bz(m,b)+")"
t=m.length
s=n.split(",")
r=s.length-t
for(q="(",p="",o=0;o<t;++o,p=", "){q+=p
if(r===0)q+="{"
q+=A.k(m[o],b)
if(r>=0)q+=" "+s[r];++r}return q+"})"},
bu(a0,a1,a2){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b=", ",a=null
if(a2!=null){t=a2.length
if(a1==null)a1=A.aN([],u.s)
else a=a1.length
s=a1.length
for(r=t;r>0;--r)a1.push("T"+(s+r))
for(q=u.X,p="<",o="",r=0;r<t;++r,o=b){p=p+o+a1[a1.length-1-r]
n=a2[r]
m=n.w
if(!(m===2||m===3||m===4||m===5||n===q))p+=" extends "+A.k(n,a1)}p+=">"}else p=""
q=a0.x
l=a0.y
k=l.a
j=k.length
i=l.b
h=i.length
g=l.c
f=g.length
e=A.k(q,a1)
for(d="",c="",r=0;r<j;++r,c=b)d+=c+A.k(k[r],a1)
if(h>0){d+=c+"["
for(c="",r=0;r<h;++r,c=b)d+=c+A.k(i[r],a1)
d+="]"}if(f>0){d+=c+"{"
for(c="",r=0;r<f;r+=3,c=b){d+=c
if(g[r+1])d+="required "
d+=A.k(g[r+2],a1)+" "+g[r]}d+="}"}if(a!=null){a1.toString
a1.length=a}return p+"("+d+") => "+e},
k(a,b){var t,s,r,q,p,o,n=a.w
if(n===5)return"erased"
if(n===2)return"dynamic"
if(n===3)return"void"
if(n===1)return"Never"
if(n===4)return"any"
if(n===6){t=a.x
s=A.k(t,b)
r=t.w
return(r===11||r===12?"("+s+")":s)+"?"}if(n===7)return"FutureOr<"+A.k(a.x,b)+">"
if(n===8){q=A.cZ(a.x)
p=a.y
return p.length>0?q+("<"+A.bz(p,b)+">"):q}if(n===10)return A.cT(a,b)
if(n===11)return A.bu(a,b,null)
if(n===12)return A.bu(a.x,b,a.y)
if(n===13){o=a.x
return b[b.length-1-o]}return"?"},
cZ(a){var t=A.bI(a)
if(t!=null)return t
return"minified:"+a},
cl(a,b){var t=a.tR[b]
while(typeof t=="string")t=a.tR[t]
return t},
ck(a,b){var t,s,r,q,p,o=a.eT,n=o[b]
if(n==null)return A.aK(a,b,!1)
else if(typeof n=="number"){t=n
s=A.X(a,5,"#")
r=A.aM(t)
for(q=0;q<t;++q)r[q]=s
p=A.W(a,b,r)
o[b]=p
return p}else return n},
ci(a,b){return A.br(a.tR,b)},
ch(a,b){return A.br(a.eT,b)},
aK(a,b,c){var t,s=a.eC,r=s.get(b)
if(r!=null)return r
t=A.bq(a,null,b,!1)
s.set(b,t)
return t},
aL(a,b,c){var t,s,r=b.z
if(r==null)r=b.z=new Map()
t=r.get(c)
if(t!=null)return t
s=A.bq(a,b,c,!0)
r.set(c,s)
return s},
cj(a,b,c){var t,s,r,q=b.Q
if(q==null)q=b.Q=new Map()
t=c.as
s=q.get(t)
if(s!=null)return s
r=A.aY(a,b,c.w===9?c.y:[c])
q.set(t,r)
return r},
bq(a,b,c,d){return A.ca(A.c4(a,b,c,d))},
r(a,b){b.a=A.cE
b.b=A.cF
return b},
X(a,b,c){var t,s,r=a.eC.get(c)
if(r!=null)return r
t=new A.o(null,null)
t.w=b
t.as=c
s=A.r(a,t)
a.eC.set(c,s)
return s},
bo(a,b,c){var t,s=b.as+"?",r=a.eC.get(s)
if(r!=null)return r
t=A.cf(a,b,s,c)
a.eC.set(s,t)
return t},
cf(a,b,c,d){var t,s,r
if(d){t=b.w
s=!0
if(!A.y(b))if(!(b===u.P||b===u.T))if(t!==6)s=t===7&&A.D(b.x)
if(s)return b
else if(t===1)return u.P}r=new A.o(null,null)
r.w=6
r.x=b
r.as=c
return A.r(a,r)},
bn(a,b,c){var t,s=b.as+"/",r=a.eC.get(s)
if(r!=null)return r
t=A.cd(a,b,s,c)
a.eC.set(s,t)
return t},
cd(a,b,c,d){var t,s
if(d){t=b.w
if(A.y(b)||b===u.K)return b
else if(t===1)return A.W(a,"bc",[b])
else if(b===u.P||b===u.T)return u.O}s=new A.o(null,null)
s.w=7
s.x=b
s.as=c
return A.r(a,s)},
cg(a,b){var t,s,r=""+b+"^",q=a.eC.get(r)
if(q!=null)return q
t=new A.o(null,null)
t.w=13
t.x=b
t.as=r
s=A.r(a,t)
a.eC.set(r,s)
return s},
V(a){var t,s,r,q=a.length
for(t="",s="",r=0;r<q;++r,s=",")t+=s+a[r].as
return t},
cc(a){var t,s,r,q,p,o=a.length
for(t="",s="",r=0;r<o;r+=3,s=","){q=a[r]
p=a[r+1]?"!":":"
t+=s+q+p+a[r+2].as}return t},
W(a,b,c){var t,s,r,q=b
if(c.length>0)q+="<"+A.V(c)+">"
t=a.eC.get(q)
if(t!=null)return t
s=new A.o(null,null)
s.w=8
s.x=b
s.y=c
if(c.length>0)s.c=c[0]
s.as=q
r=A.r(a,s)
a.eC.set(q,r)
return r},
aY(a,b,c){var t,s,r,q,p,o
if(b.w===9){t=b.x
s=b.y.concat(c)}else{s=c
t=b}r=t.as+(";<"+A.V(s)+">")
q=a.eC.get(r)
if(q!=null)return q
p=new A.o(null,null)
p.w=9
p.x=t
p.y=s
p.as=r
o=A.r(a,p)
a.eC.set(r,o)
return o},
bp(a,b,c){var t,s,r="+"+(b+"("+A.V(c)+")"),q=a.eC.get(r)
if(q!=null)return q
t=new A.o(null,null)
t.w=10
t.x=b
t.y=c
t.as=r
s=A.r(a,t)
a.eC.set(r,s)
return s},
bm(a,b,c){var t,s,r,q,p,o=b.as,n=c.a,m=n.length,l=c.b,k=l.length,j=c.c,i=j.length,h="("+A.V(n)
if(k>0){t=m>0?",":""
h+=t+"["+A.V(l)+"]"}if(i>0){t=m>0?",":""
h+=t+"{"+A.cc(j)+"}"}s=o+(h+")")
r=a.eC.get(s)
if(r!=null)return r
q=new A.o(null,null)
q.w=11
q.x=b
q.y=c
q.as=s
p=A.r(a,q)
a.eC.set(s,p)
return p},
aZ(a,b,c,d){var t,s=b.as+("<"+A.V(c)+">"),r=a.eC.get(s)
if(r!=null)return r
t=A.ce(a,b,c,s,d)
a.eC.set(s,t)
return t},
ce(a,b,c,d,e){var t,s,r,q,p,o,n,m
if(e){t=c.length
s=A.aM(t)
for(r=0,q=0;q<t;++q){p=c[q]
if(p.w===1){s[q]=p;++r}}if(r>0){o=A.w(a,b,s,0)
n=A.B(a,c,s,0)
return A.aZ(a,o,n,c!==n)}}m=new A.o(null,null)
m.w=12
m.x=b
m.y=c
m.as=d
return A.r(a,m)},
c4(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
ca(a){var t,s,r,q,p,o,n,m=a.r,l=a.s
for(t=m.length,s=0;s<t;){r=m.charCodeAt(s)
if(r>=48&&r<=57)s=A.c6(s+1,r,m,l)
else if((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124)s=A.bk(a,s,m,l,!1)
else if(r===46)s=A.bk(a,s,m,l,!0)
else{++s
switch(r){case 44:break
case 58:l.push(!1)
break
case 33:l.push(!0)
break
case 59:l.push(A.v(a.u,a.e,l.pop()))
break
case 94:l.push(A.cg(a.u,l.pop()))
break
case 35:l.push(A.X(a.u,5,"#"))
break
case 64:l.push(A.X(a.u,2,"@"))
break
case 126:l.push(A.X(a.u,3,"~"))
break
case 60:l.push(a.p)
a.p=l.length
break
case 62:A.c8(a,l)
break
case 38:A.c7(a,l)
break
case 63:q=a.u
l.push(A.bo(q,A.v(q,a.e,l.pop()),a.n))
break
case 47:q=a.u
l.push(A.bn(q,A.v(q,a.e,l.pop()),a.n))
break
case 40:l.push(-3)
l.push(a.p)
a.p=l.length
break
case 41:A.c5(a,l)
break
case 91:l.push(a.p)
a.p=l.length
break
case 93:p=l.splice(a.p)
A.bl(a.u,a.e,p)
a.p=l.pop()
l.push(p)
l.push(-1)
break
case 123:l.push(a.p)
a.p=l.length
break
case 125:p=l.splice(a.p)
A.cb(a.u,a.e,p)
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
return A.v(a.u,a.e,n)},
c6(a,b,c,d){var t,s,r=b-48
for(t=c.length;a<t;++a){s=c.charCodeAt(a)
if(!(s>=48&&s<=57))break
r=r*10+(s-48)}d.push(r)
return a},
bk(a,b,c,d,e){var t,s,r,q,p,o,n=b+1
for(t=c.length;n<t;++n){s=c.charCodeAt(n)
if(s===46){if(e)break
e=!0}else{if(!((((s|32)>>>0)-97&65535)<26||s===95||s===36||s===124))r=s>=48&&s<=57
else r=!0
if(!r)break}}q=c.substring(b,n)
if(e){t=a.u
p=a.e
if(p.w===9)p=p.x
o=A.cl(t,p.x)[q]
if(o==null)A.dd('No "'+q+'" in "'+A.c2(p)+'"')
d.push(A.aL(t,p,o))}else d.push(q)
return n},
c8(a,b){var t,s=a.u,r=A.bj(a,b),q=b.pop()
if(typeof q=="string")b.push(A.W(s,q,r))
else{t=A.v(s,a.e,q)
switch(t.w){case 11:b.push(A.aZ(s,t,r,a.n))
break
default:b.push(A.aY(s,t,r))
break}}},
c5(a,b){var t,s,r,q=a.u,p=b.pop(),o=null,n=null
if(typeof p=="number")switch(p){case-1:o=b.pop()
break
case-2:n=b.pop()
break
default:b.push(p)
break}else b.push(p)
t=A.bj(a,b)
p=b.pop()
switch(p){case-3:p=b.pop()
if(o==null)o=q.sEA
if(n==null)n=q.sEA
s=A.v(q,a.e,p)
r=new A.an()
r.a=t
r.b=o
r.c=n
b.push(A.bm(q,s,r))
return
case-4:b.push(A.bp(q,b.pop(),t))
return
default:throw A.i(A.a1("Unexpected state under `()`: "+A.O(p)))}},
c7(a,b){var t=b.pop()
if(0===t){b.push(A.X(a.u,1,"0&"))
return}if(1===t){b.push(A.X(a.u,4,"1&"))
return}throw A.i(A.a1("Unexpected extended operation "+A.O(t)))},
bj(a,b){var t=b.splice(a.p)
A.bl(a.u,a.e,t)
a.p=b.pop()
return t},
v(a,b,c){if(typeof c=="string")return A.W(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.c9(a,b,c)}else return c},
bl(a,b,c){var t,s=c.length
for(t=0;t<s;++t)c[t]=A.v(a,b,c[t])},
cb(a,b,c){var t,s=c.length
for(t=2;t<s;t+=3)c[t]=A.v(a,b,c[t])},
c9(a,b,c){var t,s,r=b.w
if(r===9){if(c===0)return b.x
t=b.y
s=t.length
if(c<=s)return t[c-1]
c-=s
b=b.x
r=b.w}else if(c===0)return b
if(r!==8)throw A.i(A.a1("Indexed base must be an interface type"))
t=b.y
if(c<=t.length)return t[c-1]
throw A.i(A.a1("Bad index "+c+" for "+b.h(0)))},
d7(a,b,c){var t,s=b.d
if(s==null)s=b.d=new Map()
t=s.get(c)
if(t==null){t=A.e(a,b,null,c,null)
s.set(c,t)}return t},
e(a,b,c,d,e){var t,s,r,q,p,o,n,m,l,k,j
if(b===d)return!0
if(A.y(d))return!0
t=b.w
if(t===4)return!0
if(A.y(b))return!1
if(b.w===1)return!0
s=t===13
if(s)if(A.e(a,c[b.x],c,d,e))return!0
r=d.w
q=u.P
if(b===q||b===u.T){if(r===7)return A.e(a,b,c,d.x,e)
return d===q||d===u.T||r===6}if(d===u.K){if(t===7)return A.e(a,b.x,c,d,e)
return t!==6}if(t===7){if(!A.e(a,b.x,c,d,e))return!1
return A.e(a,A.aX(a,b),c,d,e)}if(t===6)return A.e(a,q,c,d,e)&&A.e(a,b.x,c,d,e)
if(r===7){if(A.e(a,b,c,d.x,e))return!0
return A.e(a,b,c,A.aX(a,d),e)}if(r===6)return A.e(a,b,c,q,e)||A.e(a,b,c,d.x,e)
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
if(!A.e(a,k,c,j,e)||!A.e(a,j,e,k,c))return!1}return A.bw(a,b.x,c,d.x,e)}if(r===11){if(b===u.g)return!0
if(q)return!1
return A.bw(a,b,c,d,e)}if(t===8){if(r!==8)return!1
return A.cJ(a,b,c,d,e)}if(p&&r===10)return A.cO(a,b,c,d,e)
return!1},
bw(a2,a3,a4,a5,a6){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1
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
cJ(a,b,c,d,e){var t,s,r,q,p,o=b.x,n=d.x
while(o!==n){t=a.tR[o]
if(t==null)return!1
if(typeof t=="string"){o=t
continue}s=t[n]
if(s==null)return!1
r=s.length
q=r>0?new Array(r):v.typeUniverse.sEA
for(p=0;p<r;++p)q[p]=A.aL(a,b,s[p])
return A.bs(a,q,null,c,d.y,e)}return A.bs(a,b.y,null,c,d.y,e)},
bs(a,b,c,d,e,f){var t,s=b.length
for(t=0;t<s;++t)if(!A.e(a,b[t],d,e[t],f))return!1
return!0},
cO(a,b,c,d,e){var t,s=b.y,r=d.y,q=s.length
if(q!==r.length)return!1
if(b.x!==d.x)return!1
for(t=0;t<q;++t)if(!A.e(a,s[t],c,r[t],e))return!1
return!0},
D(a){var t=a.w,s=!0
if(!(a===u.P||a===u.T))if(!A.y(a))if(t!==6)s=t===7&&A.D(a.x)
return s},
y(a){var t=a.w
return t===2||t===3||t===4||t===5||a===u.X},
br(a,b){var t,s,r=Object.keys(b),q=r.length
for(t=0;t<q;++t){s=r[t]
a[s]=b[s]}},
aM(a){return a>0?new Array(a):v.typeUniverse.sEA},
o:function o(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
an:function an(){this.c=this.b=this.a=null},
aJ:function aJ(a){this.a=a},
aH:function aH(){},
ao:function ao(a){this.a=a},
c:function c(){},
c3(a,b,c){var t=J.bO(b)
if(!t.k())return a
if(c.length===0){do a+=A.O(t.gj())
while(t.k())}else{a+=A.O(t.gj())
while(t.k())a=a+c+A.O(t.gj())}return a},
av(a){if(typeof a=="number"||A.b1(a)||a==null)return J.a_(a)
if(typeof a=="string")return JSON.stringify(a)
return A.c1(a)},
a1(a){return new A.aq(a)},
bQ(a){return new A.ap(!1,null,null,a)},
bh(a){return new A.aG(a)},
bg(a){return new A.aF(a)},
bb(a){return new A.at(a)},
bd(a,b,c){var t,s
if(A.d8(a))return b+"..."+c
t=new A.aC(b)
$.aO.push(a)
try{s=t
s.a=A.c3(s.a,a,", ")}finally{$.aO.pop()}t.a+=c
s=t.a
return s.charCodeAt(0)==0?s:s},
au:function au(){},
aq:function aq(a){this.a=a},
aE:function aE(){},
ap:function ap(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
aG:function aG(a){this.a=a},
aF:function aF(a){this.a=a},
at:function at(a){this.a=a},
N:function N(){},
h:function h(){},
aC:function aC(a){this.a=a},
bY(a){throw A.i(A.bh("Int64List not supported on the web."))},
bI(a){return v.mangledGlobalNames[a]},
de(a){throw A.f(new A.ax("Field '"+a+"' has been assigned during initialization."),new Error())},
da(){var t,s,r,q,p
$.bM()
$.be.$0()
t=new Int32Array(25e4)
s=new Int32Array(25e4)
for(r=0;r<500;++r)for(q=r*500,p=0;p<500;++p)t[q+p]=B.d.l(r+p,7)
for(r=0;r<500;++r)for(q=r*500,p=0;p<500;++p)s[q+p]=B.d.l(r*p,5)
A.bY(25e4)}},B={}
var w=[A,J,B]
var $={}
A.aW.prototype={}
J.a3.prototype={
h(a){return"Instance of '"+A.al(a)+"'"},
gi(a){return A.x(A.b0(this))}}
J.a5.prototype={
h(a){return String(a)},
gi(a){return A.x(u.y)},
$ia:1}
J.G.prototype={
h(a){return"null"},
$ia:1}
J.I.prototype={$id:1}
J.q.prototype={
h(a){return String(a)}}
J.ak.prototype={}
J.Q.prototype={}
J.u.prototype={
h(a){var t=a[$.bL()]
if(t==null)t=a[$.bK()]
if(t==null)return this.p(a)
return"JavaScript function for "+J.a_(t)}}
J.a8.prototype={
h(a){return String(a)}}
J.a9.prototype={
h(a){return String(a)}}
J.n.prototype={
h(a){return A.bd(a,"[","]")},
gn(a){return new J.a0(a,a.length,A.b_(a).m("a0<1>"))}}
J.a4.prototype={
A(a){var t,s,r
if(!Array.isArray(a))return null
t=a.$flags|0
if((t&4)!==0)s="const, "
else if((t&2)!==0)s="unmodifiable, "
else s=(t&1)!==0?"fixed, ":""
r="Instance of '"+A.al(a)+"'"
if(s==="")return r
return r+" ("+s+"length: "+a.length+")"}}
J.aw.prototype={}
J.a0.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=r.length
if(s.b!==q)throw A.i(A.dc(r))
t=s.c
if(t>=q){s.d=null
return!1}s.d=r[t]
s.c=t+1
return!0}}
J.H.prototype={
u(a){var t,s
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){t=a|0
return a===t?t:t-1}s=Math.floor(a)
if(isFinite(s))return s
throw A.i(A.bh(""+a+".floor()"))},
h(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
l(a,b){var t=a%b
if(t===0)return 0
if(t>0)return t
return t+b},
gi(a){return A.x(u.H)},
$il:1}
J.F.prototype={
gi(a){return A.x(u.S)},
$ia:1,
$ib:1}
J.a6.prototype={
gi(a){return A.x(u.i)},
$ia:1}
J.a7.prototype={
h(a){return a},
gi(a){return A.x(u.N)},
$ia:1,
$iam:1}
A.ax.prototype={
h(a){return"LateInitializationError: "+this.a}}
A.aa.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=r.length
if(s.b!==q)throw A.i(A.bb(r))
t=s.c
if(t>=q){s.d=null
return!1}s.d=r[t]
s.c=t+1
return!0}}
A.E.prototype={}
A.ay.prototype={
$0(){return B.n.u(1000*this.a.now())}}
A.P.prototype={}
A.t.prototype={
h(a){var t=this.constructor,s=t==null?null:t.name
return"Closure '"+A.bJ(s==null?"unknown":s)+"'"},
gB(){return this},
$C:"$1",
$R:1,
$D:null}
A.ar.prototype={$C:"$0",$R:0}
A.as.prototype={$C:"$2",$R:2}
A.aD.prototype={}
A.aB.prototype={
h(a){var t=this.$static_name
if(t==null)return"Closure of unknown static method"
return"Closure '"+A.bJ(t)+"'"}}
A.a2.prototype={
h(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.al(this.a)+"'")}}
A.aA.prototype={
h(a){return"RuntimeError: "+this.a}}
A.aR.prototype={
$1(a){return this.a(a)}}
A.aS.prototype={
$2(a,b){return this.a(a,b)}}
A.aT.prototype={
$1(a){return this.a(a)}}
A.z.prototype={
gi(a){return B.q},
$ia:1}
A.L.prototype={}
A.ab.prototype={
gi(a){return B.r},
$ia:1}
A.A.prototype={$ij:1}
A.J.prototype={}
A.K.prototype={}
A.ac.prototype={
gi(a){return B.t},
$ia:1}
A.ad.prototype={
gi(a){return B.u},
$ia:1}
A.ae.prototype={
gi(a){return B.v},
$ia:1}
A.af.prototype={
gi(a){return B.w},
$ia:1}
A.ag.prototype={
gi(a){return B.x},
$ia:1}
A.ah.prototype={
gi(a){return B.y},
$ia:1}
A.ai.prototype={
gi(a){return B.z},
$ia:1}
A.M.prototype={
gi(a){return B.A},
$ia:1}
A.aj.prototype={
gi(a){return B.B},
$ia:1}
A.R.prototype={}
A.S.prototype={}
A.T.prototype={}
A.U.prototype={}
A.o.prototype={
m(a){return A.aL(v.typeUniverse,this,a)},
C(a){return A.cj(v.typeUniverse,this,a)}}
A.an.prototype={}
A.aJ.prototype={
h(a){return A.k(this.a,null)}}
A.aH.prototype={
h(a){return this.a}}
A.ao.prototype={}
A.c.prototype={
gn(a){return new A.aa(a,a.length,A.Z(a).m("aa<c.E>"))},
h(a){return A.bd(a,"[","]")}}
A.au.prototype={}
A.aq.prototype={
h(a){var t=this.a
if(t!=null)return"Assertion failed: "+A.av(t)
return"Assertion failed"}}
A.aE.prototype={}
A.ap.prototype={
gt(){return"Invalid argument"+(!this.a?"(s)":"")},
gq(){return""},
h(a){var t=this,s=t.c,r=s==null?"":" ("+s+")",q=t.d,p=q==null?"":": "+q,o=t.gt()+r+p
if(!t.a)return o
return o+t.gq()+": "+A.av(t.gv())},
gv(){return this.b}}
A.aG.prototype={
h(a){return"Unsupported operation: "+this.a}}
A.aF.prototype={
h(a){return"UnimplementedError: "+this.a}}
A.at.prototype={
h(a){return"Concurrent modification during iteration: "+A.av(this.a)+"."}}
A.N.prototype={
h(a){return"null"}}
A.h.prototype={$ih:1,
h(a){return"Instance of '"+A.al(this)+"'"},
gi(a){return A.d1(this)},
toString(){return this.h(this)}}
A.aC.prototype={
h(a){var t=this.a
return t.charCodeAt(0)==0?t:t}};(function aliases(){var t=J.q.prototype
t.p=t.h})();(function installTearOffs(){var t=hunkHelpers._static_0
t(A,"cS","c_",0)})();(function inheritance(){var t=hunkHelpers.mixin,s=hunkHelpers.inherit,r=hunkHelpers.inheritMany
s(A.h,null)
r(A.h,[A.aW,J.a3,A.P,J.a0,A.au,A.aa,A.E,A.t,A.o,A.an,A.aJ,A.c,A.N,A.aC])
r(J.a3,[J.a5,J.G,J.I,J.a8,J.a9,J.H,J.a7])
r(J.I,[J.q,J.n,A.z,A.L])
r(J.q,[J.ak,J.Q,J.u])
s(J.a4,A.P)
s(J.aw,J.n)
r(J.H,[J.F,J.a6])
r(A.au,[A.ax,A.aA,A.aH,A.aq,A.aE,A.ap,A.aG,A.aF,A.at])
r(A.t,[A.ar,A.as,A.aD,A.aR,A.aT])
s(A.ay,A.ar)
r(A.aD,[A.aB,A.a2])
s(A.aS,A.as)
r(A.L,[A.ab,A.A])
r(A.A,[A.R,A.T])
s(A.S,A.R)
s(A.J,A.S)
s(A.U,A.T)
s(A.K,A.U)
r(A.J,[A.ac,A.ad])
r(A.K,[A.ae,A.af,A.ag,A.ah,A.ai,A.M,A.aj])
s(A.ao,A.aH)
t(A.R,A.c)
t(A.S,A.E)
t(A.T,A.c)
t(A.U,A.E)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{b:"int",l:"double",bF:"num",am:"String",bB:"bool",N:"Null",bZ:"List",h:"Object",dr:"Map",d:"JSObject"},mangledNames:{},types:["b()"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti")}
A.ci(v.typeUniverse,JSON.parse('{"ak":"q","Q":"q","u":"q","ds":"z","a5":{"a":[]},"G":{"a":[]},"I":{"d":[]},"q":{"d":[]},"n":{"d":[]},"a4":{"P":[]},"aw":{"n":["1"],"d":[]},"H":{"l":[]},"F":{"l":[],"b":[],"a":[]},"a6":{"l":[],"a":[]},"a7":{"am":[],"a":[]},"z":{"d":[],"a":[]},"L":{"d":[]},"ab":{"d":[],"a":[]},"A":{"j":["1"],"d":[]},"J":{"c":["l"],"j":["l"],"d":[]},"K":{"c":["b"],"j":["b"],"d":[]},"ac":{"c":["l"],"j":["l"],"d":[],"a":[],"c.E":"l"},"ad":{"c":["l"],"j":["l"],"d":[],"a":[],"c.E":"l"},"ae":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"af":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ag":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ah":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ai":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"M":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"aj":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"}}'))
A.ch(v.typeUniverse,JSON.parse('{"E":1,"A":1}'))
var u=(function rtii(){var t=A.b3
return{Z:t("dm"),s:t("n<am>"),b:t("n<@>"),T:t("G"),m:t("d"),g:t("u"),p:t("j<@>"),P:t("N"),K:t("h"),L:t("dt"),N:t("am"),R:t("a"),o:t("Q"),y:t("bB"),i:t("l"),S:t("b"),O:t("bc<N>?"),z:t("d?"),X:t("h?"),v:t("am?"),u:t("bB?"),I:t("l?"),t:t("b?"),n:t("bF?"),H:t("bF")}})();(function constants(){B.m=J.a3.prototype
B.d=J.F.prototype
B.n=J.H.prototype
B.o=J.u.prototype
B.p=J.I.prototype
B.e=J.ak.prototype
B.a=J.Q.prototype
B.b=function getTagFallback(o) {
  var s = Object.prototype.toString.call(o);
  return s.substring(8, s.length - 1);
}
B.f=function() {
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
B.l=function(getTagFallback) {
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
B.h=function(hooks) {
  if (typeof dartExperimentalFixupGetTag != "function") return hooks;
  hooks.getTag = dartExperimentalFixupGetTag(hooks.getTag);
}
B.k=function(hooks) {
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
B.j=function(hooks) {
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
B.i=function(hooks) {
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
B.c=function(hooks) { return hooks; }

B.q=A.p("dg")
B.r=A.p("dh")
B.t=A.p("dk")
B.u=A.p("dl")
B.v=A.p("dn")
B.w=A.p("dp")
B.x=A.p("dq")
B.y=A.p("dv")
B.z=A.p("dw")
B.A=A.p("dx")
B.B=A.p("dy")})();(function staticFields(){$.aI=null
$.aO=A.aN([],A.b3("n<h>"))
$.az=0
$.be=A.cS()
$.b8=null
$.b7=null
$.bE=null
$.bA=null
$.bH=null
$.aP=null
$.aU=null
$.b4=null})();(function lazyInitializers(){var t=hunkHelpers.lazyFinal
t($,"dj","bL",()=>A.aQ("_$dart_dartClosure"))
t($,"di","bK",()=>A.aQ("_$dart_dartClosure_dartJSInterop"))
t($,"dz","bN",()=>A.aN([new J.a4()],A.b3("n<P>")))
t($,"du","bM",()=>{A.c0()
return $.az})})();(function nativeSupport(){!function(){var t=function(a){var n={}
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
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.z,SharedArrayBuffer:A.z,ArrayBufferView:A.L,DataView:A.ab,Float32Array:A.ac,Float64Array:A.ad,Int16Array:A.ae,Int32Array:A.af,Int8Array:A.ag,Uint16Array:A.ah,Uint32Array:A.ai,Uint8ClampedArray:A.M,CanvasPixelArray:A.M,Uint8Array:A.aj})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.A.$nativeSuperclassTag="ArrayBufferView"
A.R.$nativeSuperclassTag="ArrayBufferView"
A.S.$nativeSuperclassTag="ArrayBufferView"
A.J.$nativeSuperclassTag="ArrayBufferView"
A.T.$nativeSuperclassTag="ArrayBufferView"
A.U.$nativeSuperclassTag="ArrayBufferView"
A.K.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var t=document.scripts
function onLoad(b){for(var r=0;r<t.length;++r){t[r].removeEventListener("load",onLoad,false)}a(b.target)}for(var s=0;s<t.length;++s){t[s].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var t=A.da
if(typeof dartMainRunner==="function"){dartMainRunner(t,[])}else{t([])}})})()