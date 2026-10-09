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
if(a[b]!==t){A.dg(b)}a[b]=s}var r=a[b]
a[c]=function(){return r}
return r}}function makeConstList(a,b){if(b!=null)A.aP(a,b)
a.$flags=7
return a}function convertToFastObject(a){function t(){}t.prototype=a
new t()
return a}function convertAllToFastObject(a){for(var t=0;t<a.length;++t){convertToFastObject(a[t])}}var y=0
function instanceTearOffGetter(a,b){var t=null
return a?function(c){if(t===null)t=A.b5(b)
return new t(c,this)}:function(){if(t===null)t=A.b5(b)
return new t(this,null)}}function staticTearOffGetter(a){var t=null
return function(){if(t===null)t=A.b5(a).prototype
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
b9(a,b,c,d){return{i:a,p:b,e:c,x:d}},
bG(a){var t,s,r,q,p,o="_$dart_js",n=a[v.dispatchPropertyName]
if(n==null)if($.b8==null){A.d5()
n=a[v.dispatchPropertyName]}if(n!=null){t=n.p
if(!1===t)return n.i
if(!0===t)return a
s=Object.getPrototypeOf(a)
if(t===s)return n.i
if(n.e===s)throw A.i(A.bk("Return interceptor for "+A.p(t(a,n))))}r=a.constructor
if(r==null)q=null
else{p=$.aK
if(p==null)p=$.aK=A.aS(o)
q=r[p]}if(q!=null)return q
q=A.da(a)
if(q!=null)return q
if(typeof a=="function")return B.n
t=Object.getPrototypeOf(a)
if(t==null)return B.e
if(t===Object.prototype)return B.e
if(typeof r=="function"){p=$.aK
if(p==null)p=$.aK=A.aS(o)
Object.defineProperty(r,p,{value:B.a,enumerable:false,writable:true,configurable:true})
return B.a}return B.a},
X(a){if(typeof a=="number"){if(Math.floor(a)==a)return J.a6.prototype
return J.a7.prototype}if(typeof a=="string")return J.a8.prototype
if(a==null)return J.G.prototype
if(typeof a=="boolean")return J.a5.prototype
if(Array.isArray(a))return J.n.prototype
if(typeof a!="object"){if(typeof a=="function")return J.v.prototype
if(typeof a=="symbol")return J.aa.prototype
if(typeof a=="bigint")return J.a9.prototype
return a}if(a instanceof A.h)return a
return J.bG(a)},
d1(a){if(a==null)return a
if(Array.isArray(a))return J.n.prototype
if(typeof a!="object"){if(typeof a=="function")return J.v.prototype
if(typeof a=="symbol")return J.aa.prototype
if(typeof a=="bigint")return J.a9.prototype
return a}if(a instanceof A.h)return a
return J.bG(a)},
bQ(a){return J.d1(a).gq(a)},
bR(a){return J.X(a).gi(a)},
Z(a){return J.X(a).h(a)},
a3:function a3(){},
a5:function a5(){},
G:function G(){},
I:function I(){},
r:function r(){},
al:function al(){},
P:function P(){},
v:function v(){},
a9:function a9(){},
aa:function aa(){},
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
a6:function a6(){},
a7:function a7(){},
a8:function a8(){}},A={aY:function aY(){},
d9(a){var t,s
for(t=$.aQ.length,s=0;s<t;++s)if(a===$.aQ[s])return!0
return!1},
ax:function ax(a){this.a=a},
ab:function ab(a,b,c){var _=this
_.a=a
_.b=b
_.c=0
_.d=null
_.$ti=c},
F:function F(){},
bM(a){var t=A.bL(a)
if(t!=null)return t
return"minified:"+a},
dC(a,b){var t
if(b!=null){t=b.x
if(t!=null)return t}return u.p.b(a)},
p(a){var t
if(typeof a=="string")return a
if(typeof a=="number"){if(a!==0)return""+a}else if(!0===a)return"true"
else if(!1===a)return"false"
else if(a==null)return"null"
t=J.Z(a)
return t},
am(a){var t,s,r,q
if(a instanceof A.h)return A.k(A.Y(a),null)
t=J.X(a)
if(t===B.m||t===B.o||u.o.b(a)){s=B.b(a)
if(s!=="Object"&&s!=="")return s
r=a.constructor
if(typeof r=="function"){q=r.name
if(typeof q=="string"&&q!=="Object"&&q!=="")return q}}return A.k(A.Y(a),null)},
c1(a){var t,s,r
if(typeof a=="number"||A.b4(a))return J.Z(a)
if(typeof a=="string")return JSON.stringify(a)
if(a instanceof A.u)return a.h(0)
t=$.bP()
for(s=0;s<1;++s){r=t[s].B(a)
if(r!=null)return r}return"Instance of '"+A.am(a)+"'"},
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
$.aZ=new A.ay(s)},
i(a){return A.f(a,new Error())},
f(a,b){var t
if(a==null)a=new A.aG()
b.dartException=a
t=A.dh
if("defineProperty" in Object){Object.defineProperty(b,"message",{get:t})
b.name=""}else b.toString=t
return b},
dh(){return J.Z(this.dartException)},
df(a,b){throw A.f(a,b==null?new Error():b)},
de(a){throw A.i(A.bg(a))},
bY(a1){var t,s,r,q,p,o,n,m,l,k,j=a1.co,i=a1.iS,h=a1.iI,g=a1.nDA,f=a1.aI,e=a1.fs,d=a1.cs,c=e[0],b=d[0],a=j[c],a0=a1.fT
a0.toString
t=i?Object.create(new A.aC().constructor.prototype):Object.create(new A.a2(null,null).constructor.prototype)
t.$initialize=t.constructor
s=i?function static_tear_off(){this.$initialize()}:function tear_off(a2,a3){this.$initialize(a2,a3)}
t.constructor=s
s.prototype=t
t.$_name=c
t.$_target=a
r=!i
if(r)q=A.bf(c,a,h,g)
else{t.$static_name=c
q=a}t.$S=A.bU(a0,i,h)
t[b]=q
for(p=q,o=1;o<e.length;++o){n=e[o]
if(typeof n=="string"){m=j[n]
l=n
n=m}else l=""
k=d[o]
if(k!=null){if(r)n=A.bf(l,n,h,g)
t[k]=n}if(o===f)p=n}t.$C=p
t.$R=a1.rC
t.$D=a1.dV
return s},
bU(a,b,c){if(typeof a=="number")return a
if(typeof a=="string"){if(b)throw A.i("Cannot compute signature for static tearoff.")
return function(d,e){return function(){return e(this,d)}}(a,A.bS)}throw A.i("Error in functionType of tearoff")},
bV(a,b,c,d){var t=A.be
switch(b?-1:a){case 0:return function(e,f){return function(){return f(this)[e]()}}(c,t)
case 1:return function(e,f){return function(g){return f(this)[e](g)}}(c,t)
case 2:return function(e,f){return function(g,h){return f(this)[e](g,h)}}(c,t)
case 3:return function(e,f){return function(g,h,i){return f(this)[e](g,h,i)}}(c,t)
case 4:return function(e,f){return function(g,h,i,j){return f(this)[e](g,h,i,j)}}(c,t)
case 5:return function(e,f){return function(g,h,i,j,k){return f(this)[e](g,h,i,j,k)}}(c,t)
default:return function(e,f){return function(){return e.apply(f(this),arguments)}}(d,t)}},
bf(a,b,c,d){if(c)return A.bX(a,b,d)
return A.bV(b.length,d,a,b)},
bW(a,b,c,d){var t=A.be,s=A.bT
switch(b?-1:a){case 0:throw A.i(new A.aB("Intercepted function with no arguments."))
case 1:return function(e,f,g){return function(){return f(this)[e](g(this))}}(c,s,t)
case 2:return function(e,f,g){return function(h){return f(this)[e](g(this),h)}}(c,s,t)
case 3:return function(e,f,g){return function(h,i){return f(this)[e](g(this),h,i)}}(c,s,t)
case 4:return function(e,f,g){return function(h,i,j){return f(this)[e](g(this),h,i,j)}}(c,s,t)
case 5:return function(e,f,g){return function(h,i,j,k){return f(this)[e](g(this),h,i,j,k)}}(c,s,t)
case 6:return function(e,f,g){return function(h,i,j,k,l){return f(this)[e](g(this),h,i,j,k,l)}}(c,s,t)
default:return function(e,f,g){return function(){var r=[g(this)]
Array.prototype.push.apply(r,arguments)
return e.apply(f(this),r)}}(d,s,t)}},
bX(a,b,c){var t,s
if($.bc==null)$.bc=A.bb("interceptor")
if($.bd==null)$.bd=A.bb("receiver")
t=b.length
s=A.bW(t,c,a,b)
return s},
b5(a){return A.bY(a)},
bS(a,b){return A.aN(v.typeUniverse,A.Y(a.a),b)},
be(a){return a.a},
bT(a){return a.b},
bb(a){var t,s,r,q=new A.a2("receiver","interceptor"),p=Object.getOwnPropertyNames(q)
p.$flags=1
t=p
for(p=t.length,s=0;s<p;++s){r=t[s]
if(q[r]===a)return r}throw A.i(new A.a_(!1,null,null,"Field name "+a+" not found."))},
aS(a){return v.getIsolateTag(a)},
da(a){var t,s,r,q,p,o=$.bH.$1(a),n=$.aR[o]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.aW[o]
if(t!=null)return t
s=v.interceptorsByTag[o]
if(s==null){r=$.bD.$2(a,o)
if(r!=null){n=$.aR[r]
if(n!=null){Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}t=$.aW[r]
if(t!=null)return t
s=v.interceptorsByTag[r]
o=r}}if(s==null)return null
t=s.prototype
q=o[0]
if(q==="!"){n=A.aX(t)
$.aR[o]=n
Object.defineProperty(a,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
return n.i}if(q==="~"){$.aW[o]=t
return t}if(q==="-"){p=A.aX(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}if(q==="+")return A.bJ(a,t)
if(q==="*")throw A.i(A.bk(o))
if(v.leafTags[o]===true){p=A.aX(t)
Object.defineProperty(Object.getPrototypeOf(a),v.dispatchPropertyName,{value:p,enumerable:false,writable:true,configurable:true})
return p.i}else return A.bJ(a,t)},
bJ(a,b){var t=Object.getPrototypeOf(a)
Object.defineProperty(t,v.dispatchPropertyName,{value:J.b9(b,t,null,null),enumerable:false,writable:true,configurable:true})
return b},
aX(a){return J.b9(a,!1,null,!!a.$ij)},
dc(a,b,c){var t=b.prototype
if(v.leafTags[a]===true)return A.aX(t)
else return J.b9(t,c,null,null)},
d5(){if(!0===$.b8)return
$.b8=!0
A.d6()},
d6(){var t,s,r,q,p,o,n,m
$.aR=Object.create(null)
$.aW=Object.create(null)
A.d4()
t=v.interceptorsByTag
s=Object.getOwnPropertyNames(t)
if(typeof window!="undefined"){window
r=function(){}
for(q=0;q<s.length;++q){p=s[q]
o=$.bK.$1(p)
if(o!=null){n=A.dc(p,t[p],o)
if(n!=null){Object.defineProperty(o,v.dispatchPropertyName,{value:n,enumerable:false,writable:true,configurable:true})
r.prototype=o}}}}for(q=0;q<s.length;++q){p=s[q]
if(/^[A-Za-z_]/.test(p)){m=t[p]
t["!"+p]=m
t["~"+p]=m
t["-"+p]=m
t["+"+p]=m
t["*"+p]=m}}},
d4(){var t,s,r,q,p,o,n=B.f()
n=A.D(B.h,A.D(B.i,A.D(B.c,A.D(B.c,A.D(B.j,A.D(B.k,A.D(B.l(B.b),n)))))))
if(typeof dartNativeDispatchHooksTransformer!="undefined"){t=dartNativeDispatchHooksTransformer
if(typeof t=="function")t=[t]
if(Array.isArray(t))for(s=0;s<t.length;++s){r=t[s]
if(typeof r=="function")n=r(n)||n}}q=n.getTag
p=n.getUnknownTag
o=n.prototypeForTag
$.bH=new A.aT(q)
$.bD=new A.aU(p)
$.bK=new A.aV(o)},
D(a,b){return a(b)||b},
d0(a,b){var t=b.length,s=v.rttc[""+t+";"+a]
if(s==null)return null
if(t===0)return s
if(t===s.length)return s.apply(null,b)
return s(b)},
ay:function ay(a){this.a=a},
O:function O(){},
u:function u(){},
ar:function ar(){},
as:function as(){},
aF:function aF(){},
aC:function aC(){},
a2:function a2(a,b){this.a=a
this.b=b},
aB:function aB(a){this.a=a},
aT:function aT(a){this.a=a},
aU:function aU(a){this.a=a},
aV:function aV(a){this.a=a},
A:function A(){},
L:function L(){},
ac:function ac(){},
B:function B(){},
J:function J(){},
K:function K(){},
ad:function ad(){},
ae:function ae(){},
af:function af(){},
ag:function ag(){},
ah:function ah(){},
ai:function ai(){},
aj:function aj(){},
M:function M(){},
ak:function ak(){},
Q:function Q(){},
R:function R(){},
S:function S(){},
T:function T(){},
b_(a,b){var t=b.c
return t==null?b.c=A.V(a,"bh",[b.x]):t},
bj(a){var t=a.w
if(t===6||t===7)return A.bj(a.x)
return t===11||t===12},
c2(a){return a.as},
b7(a){return A.aM(v.typeUniverse,a,!1)},
x(a0,a1,a2,a3){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a=a1.w
switch(a){case 5:case 1:case 2:case 3:case 4:return a1
case 6:t=a1.x
s=A.x(a0,t,a2,a3)
if(s===t)return a1
return A.br(a0,s,!0)
case 7:t=a1.x
s=A.x(a0,t,a2,a3)
if(s===t)return a1
return A.bq(a0,s,!0)
case 8:r=a1.y
q=A.C(a0,r,a2,a3)
if(q===r)return a1
return A.V(a0,a1.x,q)
case 9:p=a1.x
o=A.x(a0,p,a2,a3)
n=a1.y
m=A.C(a0,n,a2,a3)
if(o===p&&m===n)return a1
return A.b0(a0,o,m)
case 10:l=a1.x
k=a1.y
j=A.C(a0,k,a2,a3)
if(j===k)return a1
return A.bs(a0,l,j)
case 11:i=a1.x
h=A.x(a0,i,a2,a3)
g=a1.y
f=A.cY(a0,g,a2,a3)
if(h===i&&f===g)return a1
return A.bp(a0,h,f)
case 12:e=a1.y
a3+=e.length
d=A.C(a0,e,a2,a3)
p=a1.x
o=A.x(a0,p,a2,a3)
if(d===e&&o===p)return a1
return A.b1(a0,o,d,!0)
case 13:c=a1.x
if(c<a3)return a1
b=a2[c-a3]
if(b==null)return a1
return b
default:throw A.i(A.a1("Attempted to substitute unexpected RTI kind "+a))}},
C(a,b,c,d){var t,s,r,q,p=b.length,o=A.aO(p)
for(t=!1,s=0;s<p;++s){r=b[s]
q=A.x(a,r,c,d)
if(q!==r)t=!0
o[s]=q}return t?o:b},
cZ(a,b,c,d){var t,s,r,q,p,o,n=b.length,m=A.aO(n)
for(t=!1,s=0;s<n;s+=3){r=b[s]
q=b[s+1]
p=b[s+2]
o=A.x(a,p,c,d)
if(o!==p)t=!0
m.splice(s,3,r,q,o)}return t?m:b},
cY(a,b,c,d){var t,s=b.a,r=A.C(a,s,c,d),q=b.b,p=A.C(a,q,c,d),o=b.c,n=A.cZ(a,o,c,d)
if(r===s&&p===q&&n===o)return b
t=new A.ao()
t.a=r
t.b=p
t.c=n
return t},
aP(a,b){a[v.arrayRti]=b
return a},
bF(a){var t=a.$S
if(t!=null){if(typeof t=="number")return A.d3(t)
return a.$S()}return null},
d7(a,b){var t
if(A.bj(b))if(a instanceof A.u){t=A.bF(a)
if(t!=null)return t}return A.Y(a)},
Y(a){if(a instanceof A.h)return A.by(a)
if(Array.isArray(a))return A.b2(a)
return A.b3(J.X(a))},
b2(a){var t=a[v.arrayRti],s=u.b
if(t==null)return s
if(t.constructor!==s.constructor)return s
return t},
by(a){var t=a.$ti
return t!=null?t:A.b3(a)},
b3(a){var t=a.constructor,s=t.$ccache
if(s!=null)return s
return A.cH(a,t)},
cH(a,b){var t=a instanceof A.u?Object.getPrototypeOf(Object.getPrototypeOf(a)).constructor:b,s=A.cl(v.typeUniverse,t.name)
b.$ccache=s
return s},
d3(a){var t,s=v.types,r=s[a]
if(typeof r=="string"){t=A.aM(v.typeUniverse,r,!1)
s[a]=t
return t}return r},
d2(a){return A.y(A.by(a))},
cX(a){var t=a instanceof A.u?A.bF(a):null
if(t!=null)return t
if(u.R.b(a))return J.bR(a).a
if(Array.isArray(a))return A.b2(a)
return A.Y(a)},
y(a){var t=a.r
return t==null?a.r=new A.aL(a):t},
q(a){return A.y(A.aM(v.typeUniverse,a,!1))},
cG(a){var t=this
t.b=A.cW(t)
return t.b(a)},
cW(a){var t,s,r,q
if(a===u.K)return A.cO
if(A.z(a))return A.cS
t=a.w
if(t===6)return A.cE
if(t===1)return A.bB
if(t===7)return A.cI
s=A.cV(a)
if(s!=null)return s
if(t===8){r=a.x
if(a.y.every(A.z)){a.f="$i"+r
if(r==="bZ")return A.cM
if(a===u.m)return A.cL
return A.cR}}else if(t===10){q=A.d0(a.x,a.y)
return q==null?A.bB:q}return A.cC},
cV(a){if(a.w===8){if(a===u.S)return A.cJ
if(a===u.i||a===u.H)return A.cN
if(a===u.N)return A.cQ
if(a===u.y)return A.b4}return null},
cF(a){var t=this,s=A.cB
if(A.z(t))s=A.cA
else if(t===u.K)s=A.cx
else if(A.E(t)){s=A.cD
if(t===u.t)s=A.cs
else if(t===u.v)s=A.cz
else if(t===u.u)s=A.co
else if(t===u.n)s=A.cw
else if(t===u.I)s=A.cq
else if(t===u.z)s=A.cu}else if(t===u.S)s=A.cr
else if(t===u.N)s=A.cy
else if(t===u.y)s=A.cn
else if(t===u.H)s=A.cv
else if(t===u.i)s=A.cp
else if(t===u.m)s=A.ct
t.a=s
return t.a(a)},
cC(a){var t=this
if(a==null)return A.E(t)
return A.d8(v.typeUniverse,A.d7(a,t),t)},
cE(a){if(a==null)return!0
return this.x.b(a)},
cR(a){var t,s=this
if(a==null)return A.E(s)
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.X(a)[t]},
cM(a){var t,s=this
if(a==null)return A.E(s)
if(typeof a!="object")return!1
if(Array.isArray(a))return!0
t=s.f
if(a instanceof A.h)return!!a[t]
return!!J.X(a)[t]},
cL(a){var t=this
if(a==null)return!1
if(typeof a=="object"){if(a instanceof A.h)return!!a[t.f]
return!0}if(typeof a=="function")return!0
return!1},
bA(a){if(typeof a=="object"){if(a instanceof A.h)return u.m.b(a)
return!0}if(typeof a=="function")return!0
return!1},
cB(a){var t=this
if(a==null){if(A.E(t))return a}else if(t.b(a))return a
throw A.f(A.bw(a,t),new Error())},
cD(a){var t=this
if(a==null||t.b(a))return a
throw A.f(A.bw(a,t),new Error())},
bw(a,b){return new A.ap("TypeError: "+A.bl(a,A.k(b,null)))},
bl(a,b){return A.av(a)+": type '"+A.k(A.cX(a),null)+"' is not a subtype of type '"+b+"'"},
m(a,b){return new A.ap("TypeError: "+A.bl(a,b))},
cI(a){var t=this
return t.x.b(a)||A.b_(v.typeUniverse,t).b(a)},
cO(a){return a!=null},
cx(a){if(a!=null)return a
throw A.f(A.m(a,"Object"),new Error())},
cS(a){return!0},
cA(a){return a},
bB(a){return!1},
b4(a){return!0===a||!1===a},
cn(a){if(!0===a)return!0
if(!1===a)return!1
throw A.f(A.m(a,"bool"),new Error())},
co(a){if(!0===a)return!0
if(!1===a)return!1
if(a==null)return a
throw A.f(A.m(a,"bool?"),new Error())},
cp(a){if(typeof a=="number")return a
throw A.f(A.m(a,"double"),new Error())},
cq(a){if(typeof a=="number")return a
if(a==null)return a
throw A.f(A.m(a,"double?"),new Error())},
cJ(a){return typeof a=="number"&&Math.floor(a)===a},
cr(a){if(typeof a=="number"&&Math.floor(a)===a)return a
throw A.f(A.m(a,"int"),new Error())},
cs(a){if(typeof a=="number"&&Math.floor(a)===a)return a
if(a==null)return a
throw A.f(A.m(a,"int?"),new Error())},
cN(a){return typeof a=="number"},
cv(a){if(typeof a=="number")return a
throw A.f(A.m(a,"num"),new Error())},
cw(a){if(typeof a=="number")return a
if(a==null)return a
throw A.f(A.m(a,"num?"),new Error())},
cQ(a){return typeof a=="string"},
cy(a){if(typeof a=="string")return a
throw A.f(A.m(a,"String"),new Error())},
cz(a){if(typeof a=="string")return a
if(a==null)return a
throw A.f(A.m(a,"String?"),new Error())},
ct(a){if(A.bA(a))return a
throw A.f(A.m(a,"JSObject"),new Error())},
cu(a){if(a==null)return a
if(A.bA(a))return a
throw A.f(A.m(a,"JSObject?"),new Error())},
bC(a,b){var t,s,r
for(t="",s="",r=0;r<a.length;++r,s=", ")t+=s+A.k(a[r],b)
return t},
cU(a,b){var t,s,r,q,p,o,n=a.x,m=a.y
if(""===n)return"("+A.bC(m,b)+")"
t=m.length
s=n.split(",")
r=s.length-t
for(q="(",p="",o=0;o<t;++o,p=", "){q+=p
if(r===0)q+="{"
q+=A.k(m[o],b)
if(r>=0)q+=" "+s[r];++r}return q+"})"},
bx(a0,a1,a2){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b=", ",a=null
if(a2!=null){t=a2.length
if(a1==null)a1=A.aP([],u.s)
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
if(n===8){q=A.d_(a.x)
p=a.y
return p.length>0?q+("<"+A.bC(p,b)+">"):q}if(n===10)return A.cU(a,b)
if(n===11)return A.bx(a,b,null)
if(n===12)return A.bx(a.x,b,a.y)
if(n===13){o=a.x
return b[b.length-1-o]}return"?"},
d_(a){var t=A.bL(a)
if(t!=null)return t
return"minified:"+a},
cm(a,b){var t=a.tR[b]
while(typeof t=="string")t=a.tR[t]
return t},
cl(a,b){var t,s,r,q,p,o=a.eT,n=o[b]
if(n==null)return A.aM(a,b,!1)
else if(typeof n=="number"){t=n
s=A.W(a,5,"#")
r=A.aO(t)
for(q=0;q<t;++q)r[q]=s
p=A.V(a,b,r)
o[b]=p
return p}else return n},
cj(a,b){return A.bu(a.tR,b)},
ci(a,b){return A.bu(a.eT,b)},
aM(a,b,c){var t,s=a.eC,r=s.get(b)
if(r!=null)return r
t=A.bt(a,null,b,!1)
s.set(b,t)
return t},
aN(a,b,c){var t,s,r=b.z
if(r==null)r=b.z=new Map()
t=r.get(c)
if(t!=null)return t
s=A.bt(a,b,c,!0)
r.set(c,s)
return s},
ck(a,b,c){var t,s,r,q=b.Q
if(q==null)q=b.Q=new Map()
t=c.as
s=q.get(t)
if(s!=null)return s
r=A.b0(a,b,c.w===9?c.y:[c])
q.set(t,r)
return r},
bt(a,b,c,d){return A.cb(A.c5(a,b,c,d))},
t(a,b){b.a=A.cF
b.b=A.cG
return b},
W(a,b,c){var t,s,r=a.eC.get(c)
if(r!=null)return r
t=new A.o(null,null)
t.w=b
t.as=c
s=A.t(a,t)
a.eC.set(c,s)
return s},
br(a,b,c){var t,s=b.as+"?",r=a.eC.get(s)
if(r!=null)return r
t=A.cg(a,b,s,c)
a.eC.set(s,t)
return t},
cg(a,b,c,d){var t,s,r
if(d){t=b.w
s=!0
if(!A.z(b))if(!(b===u.P||b===u.T))if(t!==6)s=t===7&&A.E(b.x)
if(s)return b
else if(t===1)return u.P}r=new A.o(null,null)
r.w=6
r.x=b
r.as=c
return A.t(a,r)},
bq(a,b,c){var t,s=b.as+"/",r=a.eC.get(s)
if(r!=null)return r
t=A.ce(a,b,s,c)
a.eC.set(s,t)
return t},
ce(a,b,c,d){var t,s
if(d){t=b.w
if(A.z(b)||b===u.K)return b
else if(t===1)return A.V(a,"bh",[b])
else if(b===u.P||b===u.T)return u.O}s=new A.o(null,null)
s.w=7
s.x=b
s.as=c
return A.t(a,s)},
ch(a,b){var t,s,r=""+b+"^",q=a.eC.get(r)
if(q!=null)return q
t=new A.o(null,null)
t.w=13
t.x=b
t.as=r
s=A.t(a,t)
a.eC.set(r,s)
return s},
U(a){var t,s,r,q=a.length
for(t="",s="",r=0;r<q;++r,s=",")t+=s+a[r].as
return t},
cd(a){var t,s,r,q,p,o=a.length
for(t="",s="",r=0;r<o;r+=3,s=","){q=a[r]
p=a[r+1]?"!":":"
t+=s+q+p+a[r+2].as}return t},
V(a,b,c){var t,s,r,q=b
if(c.length>0)q+="<"+A.U(c)+">"
t=a.eC.get(q)
if(t!=null)return t
s=new A.o(null,null)
s.w=8
s.x=b
s.y=c
if(c.length>0)s.c=c[0]
s.as=q
r=A.t(a,s)
a.eC.set(q,r)
return r},
b0(a,b,c){var t,s,r,q,p,o
if(b.w===9){t=b.x
s=b.y.concat(c)}else{s=c
t=b}r=t.as+(";<"+A.U(s)+">")
q=a.eC.get(r)
if(q!=null)return q
p=new A.o(null,null)
p.w=9
p.x=t
p.y=s
p.as=r
o=A.t(a,p)
a.eC.set(r,o)
return o},
bs(a,b,c){var t,s,r="+"+(b+"("+A.U(c)+")"),q=a.eC.get(r)
if(q!=null)return q
t=new A.o(null,null)
t.w=10
t.x=b
t.y=c
t.as=r
s=A.t(a,t)
a.eC.set(r,s)
return s},
bp(a,b,c){var t,s,r,q,p,o=b.as,n=c.a,m=n.length,l=c.b,k=l.length,j=c.c,i=j.length,h="("+A.U(n)
if(k>0){t=m>0?",":""
h+=t+"["+A.U(l)+"]"}if(i>0){t=m>0?",":""
h+=t+"{"+A.cd(j)+"}"}s=o+(h+")")
r=a.eC.get(s)
if(r!=null)return r
q=new A.o(null,null)
q.w=11
q.x=b
q.y=c
q.as=s
p=A.t(a,q)
a.eC.set(s,p)
return p},
b1(a,b,c,d){var t,s=b.as+("<"+A.U(c)+">"),r=a.eC.get(s)
if(r!=null)return r
t=A.cf(a,b,c,s,d)
a.eC.set(s,t)
return t},
cf(a,b,c,d,e){var t,s,r,q,p,o,n,m
if(e){t=c.length
s=A.aO(t)
for(r=0,q=0;q<t;++q){p=c[q]
if(p.w===1){s[q]=p;++r}}if(r>0){o=A.x(a,b,s,0)
n=A.C(a,c,s,0)
return A.b1(a,o,n,c!==n)}}m=new A.o(null,null)
m.w=12
m.x=b
m.y=c
m.as=d
return A.t(a,m)},
c5(a,b,c,d){return{u:a,e:b,r:c,s:[],p:0,n:d}},
cb(a){var t,s,r,q,p,o,n,m=a.r,l=a.s
for(t=m.length,s=0;s<t;){r=m.charCodeAt(s)
if(r>=48&&r<=57)s=A.c7(s+1,r,m,l)
else if((((r|32)>>>0)-97&65535)<26||r===95||r===36||r===124)s=A.bn(a,s,m,l,!1)
else if(r===46)s=A.bn(a,s,m,l,!0)
else{++s
switch(r){case 44:break
case 58:l.push(!1)
break
case 33:l.push(!0)
break
case 59:l.push(A.w(a.u,a.e,l.pop()))
break
case 94:l.push(A.ch(a.u,l.pop()))
break
case 35:l.push(A.W(a.u,5,"#"))
break
case 64:l.push(A.W(a.u,2,"@"))
break
case 126:l.push(A.W(a.u,3,"~"))
break
case 60:l.push(a.p)
a.p=l.length
break
case 62:A.c9(a,l)
break
case 38:A.c8(a,l)
break
case 63:q=a.u
l.push(A.br(q,A.w(q,a.e,l.pop()),a.n))
break
case 47:q=a.u
l.push(A.bq(q,A.w(q,a.e,l.pop()),a.n))
break
case 40:l.push(-3)
l.push(a.p)
a.p=l.length
break
case 41:A.c6(a,l)
break
case 91:l.push(a.p)
a.p=l.length
break
case 93:p=l.splice(a.p)
A.bo(a.u,a.e,p)
a.p=l.pop()
l.push(p)
l.push(-1)
break
case 123:l.push(a.p)
a.p=l.length
break
case 125:p=l.splice(a.p)
A.cc(a.u,a.e,p)
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
return A.w(a.u,a.e,n)},
c7(a,b,c,d){var t,s,r=b-48
for(t=c.length;a<t;++a){s=c.charCodeAt(a)
if(!(s>=48&&s<=57))break
r=r*10+(s-48)}d.push(r)
return a},
bn(a,b,c,d,e){var t,s,r,q,p,o,n=b+1
for(t=c.length;n<t;++n){s=c.charCodeAt(n)
if(s===46){if(e)break
e=!0}else{if(!((((s|32)>>>0)-97&65535)<26||s===95||s===36||s===124))r=s>=48&&s<=57
else r=!0
if(!r)break}}q=c.substring(b,n)
if(e){t=a.u
p=a.e
if(p.w===9)p=p.x
o=A.cm(t,p.x)[q]
if(o==null)A.df('No "'+q+'" in "'+A.c2(p)+'"')
d.push(A.aN(t,p,o))}else d.push(q)
return n},
c9(a,b){var t,s=a.u,r=A.bm(a,b),q=b.pop()
if(typeof q=="string")b.push(A.V(s,q,r))
else{t=A.w(s,a.e,q)
switch(t.w){case 11:b.push(A.b1(s,t,r,a.n))
break
default:b.push(A.b0(s,t,r))
break}}},
c6(a,b){var t,s,r,q=a.u,p=b.pop(),o=null,n=null
if(typeof p=="number")switch(p){case-1:o=b.pop()
break
case-2:n=b.pop()
break
default:b.push(p)
break}else b.push(p)
t=A.bm(a,b)
p=b.pop()
switch(p){case-3:p=b.pop()
if(o==null)o=q.sEA
if(n==null)n=q.sEA
s=A.w(q,a.e,p)
r=new A.ao()
r.a=t
r.b=o
r.c=n
b.push(A.bp(q,s,r))
return
case-4:b.push(A.bs(q,b.pop(),t))
return
default:throw A.i(A.a1("Unexpected state under `()`: "+A.p(p)))}},
c8(a,b){var t=b.pop()
if(0===t){b.push(A.W(a.u,1,"0&"))
return}if(1===t){b.push(A.W(a.u,4,"1&"))
return}throw A.i(A.a1("Unexpected extended operation "+A.p(t)))},
bm(a,b){var t=b.splice(a.p)
A.bo(a.u,a.e,t)
a.p=b.pop()
return t},
w(a,b,c){if(typeof c=="string")return A.V(a,c,a.sEA)
else if(typeof c=="number"){b.toString
return A.ca(a,b,c)}else return c},
bo(a,b,c){var t,s=c.length
for(t=0;t<s;++t)c[t]=A.w(a,b,c[t])},
cc(a,b,c){var t,s=c.length
for(t=2;t<s;t+=3)c[t]=A.w(a,b,c[t])},
ca(a,b,c){var t,s,r=b.w
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
d8(a,b,c){var t,s=b.d
if(s==null)s=b.d=new Map()
t=s.get(c)
if(t==null){t=A.e(a,b,null,c,null)
s.set(c,t)}return t},
e(a,b,c,d,e){var t,s,r,q,p,o,n,m,l,k,j
if(b===d)return!0
if(A.z(d))return!0
t=b.w
if(t===4)return!0
if(A.z(b))return!1
if(b.w===1)return!0
s=t===13
if(s)if(A.e(a,c[b.x],c,d,e))return!0
r=d.w
q=u.P
if(b===q||b===u.T){if(r===7)return A.e(a,b,c,d.x,e)
return d===q||d===u.T||r===6}if(d===u.K){if(t===7)return A.e(a,b.x,c,d,e)
return t!==6}if(t===7){if(!A.e(a,b.x,c,d,e))return!1
return A.e(a,A.b_(a,b),c,d,e)}if(t===6)return A.e(a,q,c,d,e)&&A.e(a,b.x,c,d,e)
if(r===7){if(A.e(a,b,c,d.x,e))return!0
return A.e(a,b,c,A.b_(a,d),e)}if(r===6)return A.e(a,b,c,q,e)||A.e(a,b,c,d.x,e)
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
if(!A.e(a,k,c,j,e)||!A.e(a,j,e,k,c))return!1}return A.bz(a,b.x,c,d.x,e)}if(r===11){if(b===u.g)return!0
if(q)return!1
return A.bz(a,b,c,d,e)}if(t===8){if(r!==8)return!1
return A.cK(a,b,c,d,e)}if(p&&r===10)return A.cP(a,b,c,d,e)
return!1},
bz(a2,a3,a4,a5,a6){var t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,a0,a1
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
cK(a,b,c,d,e){var t,s,r,q,p,o=b.x,n=d.x
while(o!==n){t=a.tR[o]
if(t==null)return!1
if(typeof t=="string"){o=t
continue}s=t[n]
if(s==null)return!1
r=s.length
q=r>0?new Array(r):v.typeUniverse.sEA
for(p=0;p<r;++p)q[p]=A.aN(a,b,s[p])
return A.bv(a,q,null,c,d.y,e)}return A.bv(a,b.y,null,c,d.y,e)},
bv(a,b,c,d,e,f){var t,s=b.length
for(t=0;t<s;++t)if(!A.e(a,b[t],d,e[t],f))return!1
return!0},
cP(a,b,c,d,e){var t,s=b.y,r=d.y,q=s.length
if(q!==r.length)return!1
if(b.x!==d.x)return!1
for(t=0;t<q;++t)if(!A.e(a,s[t],c,r[t],e))return!1
return!0},
E(a){var t=a.w,s=!0
if(!(a===u.P||a===u.T))if(!A.z(a))if(t!==6)s=t===7&&A.E(a.x)
return s},
z(a){var t=a.w
return t===2||t===3||t===4||t===5||a===u.X},
bu(a,b){var t,s,r=Object.keys(b),q=r.length
for(t=0;t<q;++t){s=r[t]
a[s]=b[s]}},
aO(a){return a>0?new Array(a):v.typeUniverse.sEA},
o:function o(a,b){var _=this
_.a=a
_.b=b
_.r=_.f=_.d=_.c=null
_.w=0
_.as=_.Q=_.z=_.y=_.x=null},
ao:function ao(){this.c=this.b=this.a=null},
aL:function aL(a){this.a=a},
aJ:function aJ(){},
ap:function ap(a){this.a=a},
c:function c(){},
c3(a,b,c){var t=J.bQ(b)
if(!t.k())return a
if(c.length===0){do a+=A.p(t.gj())
while(t.k())}else{a+=A.p(t.gj())
while(t.k())a=a+c+A.p(t.gj())}return a},
av(a){if(typeof a=="number"||A.b4(a)||a==null)return J.Z(a)
if(typeof a=="string")return JSON.stringify(a)
return A.c1(a)},
a1(a){return new A.aq(a)},
c4(a){return new A.aI(a)},
bk(a){return new A.aH(a)},
bg(a){return new A.at(a)},
bi(a,b,c){var t,s
if(A.d9(a))return b+"..."+c
t=new A.aE(b)
$.aQ.push(a)
try{s=t
s.a=A.c3(s.a,a,", ")}finally{$.aQ.pop()}t.a+=c
s=t.a
return s.charCodeAt(0)==0?s:s},
au:function au(){},
aq:function aq(a){this.a=a},
aG:function aG(){},
a_:function a_(a,b,c,d){var _=this
_.a=a
_.b=b
_.c=c
_.d=d},
aA:function aA(a,b,c,d,e,f){var _=this
_.e=a
_.f=b
_.a=c
_.b=d
_.c=e
_.d=f},
aI:function aI(a){this.a=a},
aH:function aH(a){this.a=a},
at:function at(a){this.a=a},
N:function N(){},
h:function h(){},
aD:function aD(){this.b=this.a=0},
aE:function aE(a){this.a=a},
bL(a){return v.mangledGlobalNames[a]},
dd(a){if(typeof dartPrint=="function"){dartPrint(a)
return}if(typeof console=="object"&&typeof console.log!="undefined"){console.log(a)
return}if(typeof print=="function"){print(a)
return}throw"Unable to print message: "+String(a)},
dg(a){throw A.f(new A.ax("Field '"+a+"' has been assigned during initialization."),new Error())},
b6(a){if(a<2)return a
return A.b6(a-1)+A.b6(a-2)},
db(){var t,s,r=new A.aD()
$.ba()
t=$.aZ.$0()
r.a=t
r.b=null
s=A.b6(40)
v.G.console.error("TIME_MS="+B.d.A(r.gu()/1000,3))
A.dd(""+s)}},B={}
var w=[A,J,B]
var $={}
A.aY.prototype={}
J.a3.prototype={
h(a){return"Instance of '"+A.am(a)+"'"},
gi(a){return A.y(A.b3(this))}}
J.a5.prototype={
h(a){return String(a)},
gi(a){return A.y(u.y)},
$ia:1}
J.G.prototype={
h(a){return"null"},
$ia:1}
J.I.prototype={$id:1}
J.r.prototype={
h(a){return String(a)}}
J.al.prototype={}
J.P.prototype={}
J.v.prototype={
h(a){var t=a[$.bO()]
if(t==null)t=a[$.bN()]
if(t==null)return this.t(a)
return"JavaScript function for "+J.Z(t)}}
J.a9.prototype={
h(a){return String(a)}}
J.aa.prototype={
h(a){return String(a)}}
J.n.prototype={
h(a){return A.bi(a,"[","]")},
gq(a){return new J.a0(a,a.length,A.b2(a).n("a0<1>"))}}
J.a4.prototype={
B(a){var t,s,r
if(!Array.isArray(a))return null
t=a.$flags|0
if((t&4)!==0)s="const, "
else if((t&2)!==0)s="unmodifiable, "
else s=(t&1)!==0?"fixed, ":""
r="Instance of '"+A.am(a)+"'"
if(s==="")return r
return r+" ("+s+"length: "+a.length+")"}}
J.aw.prototype={}
J.a0.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=r.length
if(s.b!==q)throw A.i(A.de(r))
t=s.c
if(t>=q){s.d=null
return!1}s.d=r[t]
s.c=t+1
return!0}}
J.H.prototype={
v(a){var t,s
if(a>=0){if(a<=2147483647)return a|0}else if(a>=-2147483648){t=a|0
return a===t?t:t-1}s=Math.floor(a)
if(isFinite(s))return s
throw A.i(A.c4(""+a+".floor()"))},
A(a,b){var t,s
if(b>20)throw A.i(new A.aA(0,20,!0,b,"fractionDigits","Invalid value"))
t=a.toFixed(b)
if(a===0)s=1/a<0
else s=!1
if(s)return"-"+t
return t},
h(a){if(a===0&&1/a<0)return"-0.0"
else return""+a},
gi(a){return A.y(u.H)},
$il:1}
J.a6.prototype={
gi(a){return A.y(u.S)},
$ia:1,
$ib:1}
J.a7.prototype={
gi(a){return A.y(u.i)},
$ia:1}
J.a8.prototype={
h(a){return a},
gi(a){return A.y(u.N)},
$ia:1,
$ian:1}
A.ax.prototype={
h(a){return"LateInitializationError: "+this.a}}
A.ab.prototype={
gj(){var t=this.d
return t==null?this.$ti.c.a(t):t},
k(){var t,s=this,r=s.a,q=r.length
if(s.b!==q)throw A.i(A.bg(r))
t=s.c
if(t>=q){s.d=null
return!1}s.d=r[t]
s.c=t+1
return!0}}
A.F.prototype={}
A.ay.prototype={
$0(){return B.d.v(1000*this.a.now())}}
A.O.prototype={}
A.u.prototype={
h(a){var t=this.constructor,s=t==null?null:t.name
return"Closure '"+A.bM(s==null?"unknown":s)+"'"},
gC(){return this},
$C:"$1",
$R:1,
$D:null}
A.ar.prototype={$C:"$0",$R:0}
A.as.prototype={$C:"$2",$R:2}
A.aF.prototype={}
A.aC.prototype={
h(a){var t=this.$static_name
if(t==null)return"Closure of unknown static method"
return"Closure '"+A.bM(t)+"'"}}
A.a2.prototype={
h(a){return"Closure '"+this.$_name+"' of "+("Instance of '"+A.am(this.a)+"'")}}
A.aB.prototype={
h(a){return"RuntimeError: "+this.a}}
A.aT.prototype={
$1(a){return this.a(a)}}
A.aU.prototype={
$2(a,b){return this.a(a,b)}}
A.aV.prototype={
$1(a){return this.a(a)}}
A.A.prototype={
gi(a){return B.p},
$ia:1}
A.L.prototype={}
A.ac.prototype={
gi(a){return B.q},
$ia:1}
A.B.prototype={$ij:1}
A.J.prototype={}
A.K.prototype={}
A.ad.prototype={
gi(a){return B.r},
$ia:1}
A.ae.prototype={
gi(a){return B.t},
$ia:1}
A.af.prototype={
gi(a){return B.u},
$ia:1}
A.ag.prototype={
gi(a){return B.v},
$ia:1}
A.ah.prototype={
gi(a){return B.w},
$ia:1}
A.ai.prototype={
gi(a){return B.x},
$ia:1}
A.aj.prototype={
gi(a){return B.y},
$ia:1}
A.M.prototype={
gi(a){return B.z},
$ia:1}
A.ak.prototype={
gi(a){return B.A},
$ia:1}
A.Q.prototype={}
A.R.prototype={}
A.S.prototype={}
A.T.prototype={}
A.o.prototype={
n(a){return A.aN(v.typeUniverse,this,a)},
D(a){return A.ck(v.typeUniverse,this,a)}}
A.ao.prototype={}
A.aL.prototype={
h(a){return A.k(this.a,null)}}
A.aJ.prototype={
h(a){return this.a}}
A.ap.prototype={}
A.c.prototype={
gq(a){return new A.ab(a,a.length,A.Y(a).n("ab<c.E>"))},
h(a){return A.bi(a,"[","]")}}
A.au.prototype={}
A.aq.prototype={
h(a){var t=this.a
if(t!=null)return"Assertion failed: "+A.av(t)
return"Assertion failed"}}
A.aG.prototype={}
A.a_.prototype={
gm(){return"Invalid argument"+(!this.a?"(s)":"")},
gl(){return""},
h(a){var t=this,s=t.c,r=s==null?"":" ("+s+")",q=t.d,p=q==null?"":": "+q,o=t.gm()+r+p
if(!t.a)return o
return o+t.gl()+": "+A.av(t.gp())},
gp(){return this.b}}
A.aA.prototype={
gp(){return this.b},
gm(){return"RangeError"},
gl(){var t,s=this.e,r=this.f
if(s==null)t=r!=null?": Not less than or equal to "+A.p(r):""
else if(r==null)t=": Not greater than or equal to "+A.p(s)
else if(r>s)t=": Not in inclusive range "+A.p(s)+".."+A.p(r)
else t=r<s?": Valid value range is empty":": Only valid value is "+A.p(s)
return t}}
A.aI.prototype={
h(a){return"Unsupported operation: "+this.a}}
A.aH.prototype={
h(a){return"UnimplementedError: "+this.a}}
A.at.prototype={
h(a){return"Concurrent modification during iteration: "+A.av(this.a)+"."}}
A.N.prototype={
h(a){return"null"}}
A.h.prototype={$ih:1,
h(a){return"Instance of '"+A.am(this)+"'"},
gi(a){return A.d2(this)},
toString(){return this.h(this)}}
A.aD.prototype={
gu(){var t,s=this.b
if(s==null)s=$.aZ.$0()
t=s-this.a
if($.ba()===1e6)return t
return t*1000}}
A.aE.prototype={
h(a){var t=this.a
return t.charCodeAt(0)==0?t:t}};(function aliases(){var t=J.r.prototype
t.t=t.h})();(function installTearOffs(){var t=hunkHelpers._static_0
t(A,"cT","c_",0)})();(function inheritance(){var t=hunkHelpers.mixin,s=hunkHelpers.inherit,r=hunkHelpers.inheritMany
s(A.h,null)
r(A.h,[A.aY,J.a3,A.O,J.a0,A.au,A.ab,A.F,A.u,A.o,A.ao,A.aL,A.c,A.N,A.aD,A.aE])
r(J.a3,[J.a5,J.G,J.I,J.a9,J.aa,J.H,J.a8])
r(J.I,[J.r,J.n,A.A,A.L])
r(J.r,[J.al,J.P,J.v])
s(J.a4,A.O)
s(J.aw,J.n)
r(J.H,[J.a6,J.a7])
r(A.au,[A.ax,A.aB,A.aJ,A.aq,A.aG,A.a_,A.aI,A.aH,A.at])
r(A.u,[A.ar,A.as,A.aF,A.aT,A.aV])
s(A.ay,A.ar)
r(A.aF,[A.aC,A.a2])
s(A.aU,A.as)
r(A.L,[A.ac,A.B])
r(A.B,[A.Q,A.S])
s(A.R,A.Q)
s(A.J,A.R)
s(A.T,A.S)
s(A.K,A.T)
r(A.J,[A.ad,A.ae])
r(A.K,[A.af,A.ag,A.ah,A.ai,A.aj,A.M,A.ak])
s(A.ap,A.aJ)
s(A.aA,A.a_)
t(A.Q,A.c)
t(A.R,A.F)
t(A.S,A.c)
t(A.T,A.F)})()
var v={G:typeof self!="undefined"?self:globalThis,typeUniverse:{eC:new Map(),tR:{},eT:{},tPV:{},sEA:[]},mangledGlobalNames:{b:"int",l:"double",bI:"num",an:"String",bE:"bool",N:"Null",bZ:"List",h:"Object",dt:"Map",d:"JSObject"},mangledNames:{},types:["b()"],interceptorsByTag:null,leafTags:null,arrayRti:Symbol("$ti")}
A.cj(v.typeUniverse,JSON.parse('{"al":"r","P":"r","v":"r","du":"A","a5":{"a":[]},"G":{"a":[]},"I":{"d":[]},"r":{"d":[]},"n":{"d":[]},"a4":{"O":[]},"aw":{"n":["1"],"d":[]},"H":{"l":[]},"a6":{"l":[],"b":[],"a":[]},"a7":{"l":[],"a":[]},"a8":{"an":[],"a":[]},"A":{"d":[],"a":[]},"L":{"d":[]},"ac":{"d":[],"a":[]},"B":{"j":["1"],"d":[]},"J":{"c":["l"],"j":["l"],"d":[]},"K":{"c":["b"],"j":["b"],"d":[]},"ad":{"c":["l"],"j":["l"],"d":[],"a":[],"c.E":"l"},"ae":{"c":["l"],"j":["l"],"d":[],"a":[],"c.E":"l"},"af":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ag":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ah":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ai":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"aj":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"M":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"},"ak":{"c":["b"],"j":["b"],"d":[],"a":[],"c.E":"b"}}'))
A.ci(v.typeUniverse,JSON.parse('{"F":1,"B":1}'))
var u=(function rtii(){var t=A.b7
return{Z:t("dp"),s:t("n<an>"),b:t("n<@>"),T:t("G"),m:t("d"),g:t("v"),p:t("j<@>"),P:t("N"),K:t("h"),L:t("dv"),N:t("an"),R:t("a"),o:t("P"),y:t("bE"),i:t("l"),S:t("b"),O:t("bh<N>?"),z:t("d?"),X:t("h?"),v:t("an?"),u:t("bE?"),I:t("l?"),t:t("b?"),n:t("bI?"),H:t("bI")}})();(function constants(){B.m=J.a3.prototype
B.d=J.H.prototype
B.n=J.v.prototype
B.o=J.I.prototype
B.e=J.al.prototype
B.a=J.P.prototype
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

B.p=A.q("di")
B.q=A.q("dj")
B.r=A.q("dm")
B.t=A.q("dn")
B.u=A.q("dq")
B.v=A.q("dr")
B.w=A.q("ds")
B.x=A.q("dx")
B.y=A.q("dy")
B.z=A.q("dz")
B.A=A.q("dA")})();(function staticFields(){$.aK=null
$.aQ=A.aP([],A.b7("n<h>"))
$.az=0
$.aZ=A.cT()
$.bd=null
$.bc=null
$.bH=null
$.bD=null
$.bK=null
$.aR=null
$.aW=null
$.b8=null})();(function lazyInitializers(){var t=hunkHelpers.lazyFinal
t($,"dl","bO",()=>A.aS("_$dart_dartClosure"))
t($,"dk","bN",()=>A.aS("_$dart_dartClosure_dartJSInterop"))
t($,"dB","bP",()=>A.aP([new J.a4()],A.b7("n<O>")))
t($,"dw","ba",()=>{A.c0()
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
hunkHelpers.setOrUpdateInterceptorsByTag({ArrayBuffer:A.A,SharedArrayBuffer:A.A,ArrayBufferView:A.L,DataView:A.ac,Float32Array:A.ad,Float64Array:A.ae,Int16Array:A.af,Int32Array:A.ag,Int8Array:A.ah,Uint16Array:A.ai,Uint32Array:A.aj,Uint8ClampedArray:A.M,CanvasPixelArray:A.M,Uint8Array:A.ak})
hunkHelpers.setOrUpdateLeafTags({ArrayBuffer:true,SharedArrayBuffer:true,ArrayBufferView:false,DataView:true,Float32Array:true,Float64Array:true,Int16Array:true,Int32Array:true,Int8Array:true,Uint16Array:true,Uint32Array:true,Uint8ClampedArray:true,CanvasPixelArray:true,Uint8Array:false})
A.B.$nativeSuperclassTag="ArrayBufferView"
A.Q.$nativeSuperclassTag="ArrayBufferView"
A.R.$nativeSuperclassTag="ArrayBufferView"
A.J.$nativeSuperclassTag="ArrayBufferView"
A.S.$nativeSuperclassTag="ArrayBufferView"
A.T.$nativeSuperclassTag="ArrayBufferView"
A.K.$nativeSuperclassTag="ArrayBufferView"})()
Function.prototype.$0=function(){return this()}
Function.prototype.$1=function(a){return this(a)}
Function.prototype.$2=function(a,b){return this(a,b)}
convertAllToFastObject(w)
convertToFastObject($);(function(a){if(typeof document==="undefined"){a(null)
return}if(typeof document.currentScript!="undefined"){a(document.currentScript)
return}var t=document.scripts
function onLoad(b){for(var r=0;r<t.length;++r){t[r].removeEventListener("load",onLoad,false)}a(b.target)}for(var s=0;s<t.length;++s){t[s].addEventListener("load",onLoad,false)}})(function(a){v.currentScript=a
var t=A.db
if(typeof dartMainRunner==="function"){dartMainRunner(t,[])}else{t([])}})})()