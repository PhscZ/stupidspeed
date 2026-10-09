(function(){
'use strict';
var $fileLevelThis = this;
var $getOwnPropertyDescriptors = (Object.getOwnPropertyDescriptors || (() => {
  var ownKeysFun;
  if ((((typeof Reflect) !== "undefined") && Reflect.ownKeys)) {
    ownKeysFun = Reflect.ownKeys;
  } else {
    var getOwnPropertySymbols = (Object.getOwnPropertySymbols || ((o) => []));
    ownKeysFun = ((o) => Object.getOwnPropertyNames(o).concat(getOwnPropertySymbols(o)));
  }
  return ((o) => {
    var ownKeys = ownKeysFun(o);
    var descriptors = ({});
    var len = (ownKeys.length | 0);
    var i = 0;
    while ((i !== len)) {
      var key = ownKeys[i];
      Object.defineProperty(descriptors, key, ({
        "configurable": true,
        "enumerable": true,
        "writable": true,
        "value": Object.getOwnPropertyDescriptor(o, key)
      }));
      i = ((i + 1) | 0);
    }
    return descriptors;
  });
})());
function $Char(c) {
  this.c = c;
}
$Char.prototype.toString = (function() {
  return String.fromCharCode(this.c);
});
function $Long(lo, hi) {
  this.l = lo;
  this.h = hi;
}
$Long.prototype.toString = (function() {
  return $s_RTLong__toString__I__I__T(this.l, this.h);
});
function $valueDescription(arg0) {
  return (((typeof arg0) === "number") ? (((arg0 === 0) && ((1 / arg0) < 0)) ? "number(-0)" : (("number(" + arg0) + ")")) : ((arg0 instanceof $Long) ? "long" : ((arg0 instanceof $Char) ? "char" : ((!(!(arg0 && arg0.$classData))) ? arg0.$classData.name : (typeof arg0)))));
}
function $throwClassCastException(arg0, arg1) {
  throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_ClassCastException((($valueDescription(arg0) + " cannot be cast to ") + arg1)));
}
function $throwArrayCastException(arg0, arg1, arg2) {
  while ((--arg2)) {
    arg1 = ("[" + arg1);
  }
  $throwClassCastException(arg0, arg1);
}
function $throwArrayIndexOutOFBoundsException(arg0) {
  throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_ArrayIndexOutOfBoundsException(((arg0 === null) ? null : ("" + arg0))));
}
function $throwArrayStoreException(arg0) {
  throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_ArrayStoreException(((arg0 === null) ? null : $valueDescription(arg0))));
}
function $throwNegativeArraySizeException() {
  throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_NegativeArraySizeException());
}
function $throwNullPointerException() {
  throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_NullPointerException());
}
function $n(arg0) {
  if ((arg0 === null)) {
    $throwNullPointerException();
  }
  return arg0;
}
function $noIsInstance(arg0) {
  throw new TypeError("Cannot call isInstance() on a Class representing a JS trait/object");
}
function $objectClone(arg0) {
  return Object.create(Object.getPrototypeOf(arg0), $getOwnPropertyDescriptors(arg0));
}
function $objectOrArrayClone(arg0) {
  return (arg0.$classData.isArrayClass ? arg0.clone__O() : $objectClone(arg0));
}
function $aJCheckGet(arg0, arg1) {
  if (((arg1 >>> 0) >= (arg0.length >>> 1))) {
    $throwArrayIndexOutOFBoundsException(arg1);
  }
  return (arg1 << 1);
}
function $objectClassName(arg0) {
  switch ((typeof arg0)) {
    case "string": {
      return "java.lang.String";
    }
    case "number": {
      if ($isInt(arg0)) {
        if ((((arg0 << 24) >> 24) === arg0)) {
          return "java.lang.Byte";
        } else if ((((arg0 << 16) >> 16) === arg0)) {
          return "java.lang.Short";
        } else {
          return "java.lang.Integer";
        }
      } else if ($isFloat(arg0)) {
        return "java.lang.Float";
      } else {
        return "java.lang.Double";
      }
    }
    case "boolean": {
      return "java.lang.Boolean";
    }
    case "undefined": {
      return "java.lang.Void";
    }
    default: {
      if ((arg0 instanceof $Long)) {
        return "java.lang.Long";
      } else if ((arg0 instanceof $Char)) {
        return "java.lang.Character";
      } else if ((!(!(arg0 && arg0.$classData)))) {
        return arg0.$classData.name;
      } else {
        return $throwNullPointerException();
      }
    }
  }
}
function $dp_hashCode__I(instance) {
  switch ((typeof instance)) {
    case "string": {
      return $f_T__hashCode__I(instance);
    }
    case "number": {
      return $f_jl_Double__hashCode__I(instance);
    }
    case "boolean": {
      return $f_jl_Boolean__hashCode__I(instance);
    }
    case "undefined": {
      return $f_jl_Void__hashCode__I(instance);
    }
    default: {
      if (((!(!(instance && instance.$classData))) || (instance === null))) {
        return instance.hashCode__I();
      } else if ((instance instanceof $Long)) {
        return $f_jl_Long__hashCode__I(instance.l, instance.h);
      } else if ((instance instanceof $Char)) {
        return $f_jl_Character__hashCode__I(instance.c);
      } else {
        return $c_O.prototype.hashCode__I.call(instance);
      }
    }
  }
}
function $dp_toString__T(instance) {
  return ((instance === (void 0)) ? "undefined" : instance.toString());
}
function $checkIntDivisor(arg0) {
  if ((arg0 === 0)) {
    throw new $c_jl_ArithmeticException("/ by zero");
  } else {
    return arg0;
  }
}
function $doubleToInt(arg0) {
  return ((arg0 > 2147483647) ? 2147483647 : ((arg0 < (-2147483648)) ? (-2147483648) : (arg0 | 0)));
}
function $cToS(arg0) {
  return String.fromCharCode(arg0);
}
function $charAt(arg0, arg1) {
  var r = arg0.charCodeAt(arg1);
  if ((r !== r)) {
    throw new $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError(new $c_jl_StringIndexOutOfBoundsException(arg1));
  } else {
    return r;
  }
}
var $fpBitsDataView = new DataView(new ArrayBuffer(8));
function $floatToBits(arg0) {
  var dataView = $fpBitsDataView;
  dataView.setFloat32(0, arg0, true);
  return dataView.getInt32(0, true);
}
function $floatFromBits(arg0) {
  var dataView = $fpBitsDataView;
  dataView.setInt32(0, arg0, true);
  return dataView.getFloat32(0, true);
}
function $doubleToBits(arg0) {
  var dataView = $fpBitsDataView;
  return $s_RTLong__fromDoubleBits__D__O__J(arg0, dataView);
}
function $doubleFromBits(arg0) {
  var dataView = $fpBitsDataView;
  return $s_RTLong__bitsToDouble__I__I__O__D(arg0.l, arg0.h, dataView);
}
function $resolveSuperRef(arg0, arg1) {
  var getPrototypeOf = Object.getPrototyeOf;
  var getOwnPropertyDescriptor = Object.getOwnPropertyDescriptor;
  var superProto = arg0.prototype;
  while ((superProto !== null)) {
    var desc = getOwnPropertyDescriptor(superProto, arg1);
    if ((desc !== (void 0))) {
      return desc;
    }
    superProto = getPrototypeOf(superProto);
  }
}
function $superGet(arg0, arg1, arg2) {
  var desc = $resolveSuperRef(arg0, arg2);
  if ((desc !== (void 0))) {
    var getter = desc.get;
    return ((getter !== (void 0)) ? getter.call(arg1) : getter.value);
  }
}
function $superSet(arg0, arg1, arg2, arg3) {
  var desc = $resolveSuperRef(arg0, arg2);
  if ((desc !== (void 0))) {
    var setter = desc.set;
    if ((setter !== (void 0))) {
      setter.call(arg1, arg3);
      return (void 0);
    }
  }
  throw new TypeError((("super has no setter '" + arg2) + "'."));
}
function $arraycopyCheckBounds(arg0, arg1, arg2, arg3, arg4) {
  if ((((((arg1 | arg3) | arg4) < 0) || (arg1 > ((arg0 - arg4) | 0))) || (arg3 > ((arg2 - arg4) | 0)))) {
    $throwArrayIndexOutOFBoundsException(null);
  }
}
function $arraycopyGeneric(arg0, arg1, arg2, arg3, arg4) {
  $arraycopyCheckBounds(arg0.length, arg1, arg2.length, arg3, arg4);
  if (((arg0 !== arg2) || (((arg3 - arg1) >>> 0) > (arg4 >>> 0)))) {
    for (var i = 0; (i < arg4); i = ((i + 1) | 0)) {
      arg2[((arg3 + i) | 0)] = arg0[((arg1 + i) | 0)];
    }
  } else {
    for (var i = ((arg4 - 1) | 0); (i >= 0); i = ((i - 1) | 0)) {
      arg2[((arg3 + i) | 0)] = arg0[((arg1 + i) | 0)];
    }
  }
}
function $systemArraycopy(arg0, arg1, arg2, arg3, arg4) {
  arg0.copyTo(arg1, arg2, arg3, arg4);
}
function $systemArraycopyRefs(arg0, arg1, arg2, arg3, arg4) {
  if (arg2.$classData.isAssignableFrom(arg0.$classData)) {
    $arraycopyGeneric(arg0.u, arg1, arg2.u, arg3, arg4);
  } else {
    var srcArray = arg0.u;
    $arraycopyCheckBounds(srcArray.length, arg1, arg2.u.length, arg3, arg4);
    for (var i = 0; (i < arg4); i = ((i + 1) | 0)) {
      arg2.set(((arg3 + i) | 0), srcArray[((arg1 + i) | 0)]);
    }
  }
}
function $systemArraycopyFull(arg0, arg1, arg2, arg3, arg4) {
  var srcData = (arg0 && arg0.$classData);
  if ((srcData === (arg2 && arg2.$classData))) {
    if ((srcData && srcData.isArrayClass)) {
      $systemArraycopy(arg0, arg1, arg2, arg3, arg4);
    } else {
      $throwArrayStoreException(null);
    }
  } else if (((arg0 instanceof $ac_O) && (arg2 instanceof $ac_O))) {
    $systemArraycopyRefs(arg0, arg1, arg2, arg3, arg4);
  } else {
    $throwArrayStoreException(null);
  }
}
var $lastIDHash = 0;
var $idHashCodeMap = new WeakMap();
function $systemIdentityHashCode(obj) {
  switch ((typeof obj)) {
    case "string": {
      return $f_T__hashCode__I(obj);
    }
    case "number": {
      return $f_jl_Double__hashCode__I(obj);
    }
    case "bigint": {
      var biHash = 0;
      if ((obj < BigInt(0))) {
        obj = (~obj);
      }
      while ((obj !== BigInt(0))) {
        biHash = (biHash ^ Number(BigInt.asIntN(32, obj)));
        obj = (obj >> BigInt(32));
      }
      return biHash;
    }
    case "boolean": {
      return (obj ? 1231 : 1237);
    }
    case "undefined": {
      return 0;
    }
    case "symbol": {
      var description = obj.description;
      return ((description === (void 0)) ? 0 : $f_T__hashCode__I(description));
    }
    default: {
      if ((obj === null)) {
        return 0;
      } else {
        var hash = $idHashCodeMap.get(obj);
        if ((hash === (void 0))) {
          hash = (($lastIDHash + 1) | 0);
          $lastIDHash = hash;
          $idHashCodeMap.set(obj, hash);
        }
        return hash;
      }
    }
  }
}
function $isByte(arg0) {
  return ((((typeof arg0) === "number") && (((arg0 << 24) >> 24) === arg0)) && ((1 / arg0) !== (1 / (-0))));
}
function $isShort(arg0) {
  return ((((typeof arg0) === "number") && (((arg0 << 16) >> 16) === arg0)) && ((1 / arg0) !== (1 / (-0))));
}
function $isInt(arg0) {
  return ((((typeof arg0) === "number") && ((arg0 | 0) === arg0)) && ((1 / arg0) !== (1 / (-0))));
}
function $isFloat(arg0) {
  return (((typeof arg0) === "number") && ((arg0 !== arg0) || (Math.fround(arg0) === arg0)));
}
function $bC(arg0) {
  return new $Char(arg0);
}
var $bC0 = $bC(0);
function $bL(arg0, arg1) {
  return new $Long(arg0, arg1);
}
var $bL0 = $bL(0, 0);
function $uV(arg0) {
  return (((arg0 === (void 0)) || (arg0 === null)) ? (void 0) : $throwClassCastException(arg0, "java.lang.Void"));
}
function $uZ(arg0) {
  return ((((typeof arg0) === "boolean") || (arg0 === null)) ? (!(!arg0)) : $throwClassCastException(arg0, "java.lang.Boolean"));
}
function $uC(arg0) {
  return (((arg0 instanceof $Char) || (arg0 === null)) ? ((arg0 === null) ? 0 : arg0.c) : $throwClassCastException(arg0, "java.lang.Character"));
}
function $uB(arg0) {
  return (($isByte(arg0) || (arg0 === null)) ? (arg0 | 0) : $throwClassCastException(arg0, "java.lang.Byte"));
}
function $uS(arg0) {
  return (($isShort(arg0) || (arg0 === null)) ? (arg0 | 0) : $throwClassCastException(arg0, "java.lang.Short"));
}
function $uI(arg0) {
  return (($isInt(arg0) || (arg0 === null)) ? (arg0 | 0) : $throwClassCastException(arg0, "java.lang.Integer"));
}
function $uJ(arg0) {
  return (((arg0 instanceof $Long) || (arg0 === null)) ? ((arg0 === null) ? $bL0 : arg0) : $throwClassCastException(arg0, "java.lang.Long"));
}
function $uF(arg0) {
  return (($isFloat(arg0) || (arg0 === null)) ? (+arg0) : $throwClassCastException(arg0, "java.lang.Float"));
}
function $uD(arg0) {
  return ((((typeof arg0) === "number") || (arg0 === null)) ? (+arg0) : $throwClassCastException(arg0, "java.lang.Double"));
}
function $uT(arg0) {
  return ((((typeof arg0) === "string") || (arg0 === null)) ? ((arg0 === null) ? "" : arg0) : $throwClassCastException(arg0, "java.lang.String"));
}
/** @constructor */
function $c_O() {
}
$c_O.prototype.constructor = $c_O;
/** @constructor */
function $h_O() {
}
$h_O.prototype = $c_O.prototype;
$c_O.prototype.hashCode__I = (function() {
  return $systemIdentityHashCode(this);
});
$c_O.prototype.toString__T = (function() {
  var i = this.hashCode__I();
  return (($objectClassName(this) + "@") + $as_T((i >>> 0.0).toString(16)));
});
$c_O.prototype.toString = (function() {
  return this.toString__T();
});
function $ac_O(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Array(arg);
    for (var i = 0; (i < arg); (i++)) {
      this.u[i] = null;
    }
  } else {
    this.u = arg;
  }
}
$ac_O.prototype = new $h_O();
$ac_O.prototype.constructor = $ac_O;
$ac_O.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_O.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_O.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyGeneric(this.u, srcPos, dest.u, destPos, length);
});
$ac_O.prototype.clone__O = (function() {
  return new $ac_O(this.u.slice());
});
function $ah_O() {
}
$ah_O.prototype = $ac_O.prototype;
function $ac_Z(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Array(arg);
    for (var i = 0; (i < arg); (i++)) {
      this.u[i] = false;
    }
  } else {
    this.u = arg;
  }
}
$ac_Z.prototype = new $h_O();
$ac_Z.prototype.constructor = $ac_Z;
$ac_Z.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_Z.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_Z.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyGeneric(this.u, srcPos, dest.u, destPos, length);
});
$ac_Z.prototype.clone__O = (function() {
  return new $ac_Z(this.u.slice());
});
function $ac_C(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Uint16Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_C.prototype = new $h_O();
$ac_C.prototype.constructor = $ac_C;
$ac_C.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_C.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_C.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_C.prototype.clone__O = (function() {
  return new $ac_C(this.u.slice());
});
function $ac_B(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Int8Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_B.prototype = new $h_O();
$ac_B.prototype.constructor = $ac_B;
$ac_B.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_B.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_B.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_B.prototype.clone__O = (function() {
  return new $ac_B(this.u.slice());
});
function $ac_S(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Int16Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_S.prototype = new $h_O();
$ac_S.prototype.constructor = $ac_S;
$ac_S.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_S.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_S.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_S.prototype.clone__O = (function() {
  return new $ac_S(this.u.slice());
});
function $ac_I(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Int32Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_I.prototype = new $h_O();
$ac_I.prototype.constructor = $ac_I;
$ac_I.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_I.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_I.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_I.prototype.clone__O = (function() {
  return new $ac_I(this.u.slice());
});
function $ac_J(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    arg = (arg << 1);
    this.u = new Int32Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_J.prototype = new $h_O();
$ac_J.prototype.constructor = $ac_J;
$ac_J.prototype.set = (function(i, v, w) {
  if (((i >>> 0) >= (((this.u.length >>> 1) | 0) >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  i = (i << 1);
  this.u[i] = v;
  this.u[((i + 1) | 0)] = w;
});
$ac_J.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(((this.u.length >>> 1) | 0), srcPos, ((dest.u.length >>> 1) | 0), destPos, length);
  dest.u.set(this.u.subarray((srcPos << 1), (((srcPos + length) | 0) << 1)), (destPos << 1));
});
$ac_J.prototype.clone__O = (function() {
  return new $ac_J(this.u.slice());
});
function $ac_F(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Float32Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_F.prototype = new $h_O();
$ac_F.prototype.constructor = $ac_F;
$ac_F.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_F.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_F.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_F.prototype.clone__O = (function() {
  return new $ac_F(this.u.slice());
});
function $ac_D(arg) {
  if (((typeof arg) === "number")) {
    if ((arg < 0)) {
      $throwNegativeArraySizeException();
    }
    this.u = new Float64Array(arg);
  } else {
    this.u = arg;
  }
}
$ac_D.prototype = new $h_O();
$ac_D.prototype.constructor = $ac_D;
$ac_D.prototype.get = (function(i) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  return this.u[i];
});
$ac_D.prototype.set = (function(i, v) {
  if (((i >>> 0) >= (this.u.length >>> 0))) {
    $throwArrayIndexOutOFBoundsException(i);
  }
  this.u[i] = v;
});
$ac_D.prototype.copyTo = (function(srcPos, dest, destPos, length) {
  $arraycopyCheckBounds(this.u.length, srcPos, dest.u.length, destPos, length);
  dest.u.set(this.u.subarray(srcPos, ((srcPos + length) | 0)), destPos);
});
$ac_D.prototype.clone__O = (function() {
  return new $ac_D(this.u.slice());
});
function $TypeData() {
  this.constr = (void 0);
  this.ancestors = null;
  this.componentData = null;
  this.arrayBase = null;
  this.arrayDepth = 0;
  this.zero = null;
  this.arrayEncodedName = "";
  this._classOf = (void 0);
  this._arrayOf = (void 0);
  this.isAssignableFromFun = (void 0);
  this.wrapArray = (void 0);
  this.isJSType = false;
  this.name = "";
  this.isPrimitive = false;
  this.isInterface = false;
  this.isArrayClass = false;
  this.isInstance = (void 0);
}
$TypeData.prototype.initPrim = (function(zero, arrayEncodedName, displayName, arrayClass, typedArrayClass) {
  this.ancestors = ({});
  this.zero = zero;
  this.arrayEncodedName = arrayEncodedName;
  var self = this;
  this.isAssignableFromFun = ((that) => (that === self));
  this.name = displayName;
  this.isPrimitive = true;
  this.isInstance = ((obj) => false);
  if ((arrayClass !== (void 0))) {
    this._arrayOf = new $TypeData().initSpecializedArray(this, arrayClass, typedArrayClass, (arrayEncodedName === "J"));
  }
  return this;
});
$TypeData.prototype.initClass = (function(kindOrCtor, fullName, ancestors, isInstance) {
  var internalName = Object.getOwnPropertyNames(ancestors)[0];
  this.ancestors = ancestors;
  this.arrayEncodedName = (("L" + fullName) + ";");
  this.isAssignableFromFun = ((that) => (!(!that.ancestors[internalName])));
  this.isJSType = (kindOrCtor === 2);
  this.name = fullName;
  this.isInterface = (kindOrCtor === 1);
  this.isInstance = (isInstance || ((obj) => (!(!((obj && obj.$classData) && obj.$classData.ancestors[internalName])))));
  if (((typeof kindOrCtor) !== "number")) {
    kindOrCtor.prototype.$classData = this;
  }
  return this;
});
$TypeData.prototype.initSpecializedArray = (function(componentData, arrayClass, typedArrayClass, isLongArray, isAssignableFromFun) {
  arrayClass.prototype.$classData = this;
  var name = ("[" + componentData.arrayEncodedName);
  this.constr = arrayClass;
  this.ancestors = ({
    jl_Cloneable: 1,
    Ljava_io_Serializable: 1
  });
  this.componentData = componentData;
  this.arrayBase = componentData;
  this.arrayDepth = 1;
  this.arrayEncodedName = name;
  this.name = name;
  this.isArrayClass = true;
  var self = this;
  this.isAssignableFromFun = (isAssignableFromFun || ((that) => (self === that)));
  this.wrapArray = (isLongArray ? ((array) => {
    var len = (array.length | 0);
    var result = new arrayClass(len);
    var u = result.u;
    for (var i = 0; (i < len); i = ((i + 1) | 0)) {
      var srcElem = array[i];
      u[(i << 1)] = srcElem.l;
      u[(((i << 1) + 1) | 0)] = srcElem.h;
    }
    return result;
  }) : (typedArrayClass ? ((array) => new arrayClass(new typedArrayClass(array))) : ((array) => new arrayClass(array))));
  this.isInstance = ((obj) => (obj instanceof arrayClass));
  return this;
});
$TypeData.prototype.initArray = (function(componentData) {
  function ArrayClass(arg) {
    if (((typeof arg) === "number")) {
      if ((arg < 0)) {
        $throwNegativeArraySizeException();
      }
      this.u = new Array(arg);
      for (var i = 0; (i < arg); (i++)) {
        this.u[i] = null;
      }
    } else {
      this.u = arg;
    }
  }
  ArrayClass.prototype = new $ah_O();
  ArrayClass.prototype.constructor = ArrayClass;
  ArrayClass.prototype.set = (function(i, v) {
    if (((i >>> 0) >= (this.u.length >>> 0))) {
      $throwArrayIndexOutOFBoundsException(i);
    }
    if ((((v !== null) && (!componentData.isJSType)) && (!componentData.isInstance(v)))) {
      $throwArrayStoreException(v);
    }
    this.u[i] = v;
  });
  ArrayClass.prototype.copyTo = (function(srcPos, dest, destPos, length) {
    $arraycopyGeneric(this.u, srcPos, dest.u, destPos, length);
  });
  ArrayClass.prototype.clone__O = (function() {
    return new ArrayClass(this.u.slice());
  });
  ArrayClass.prototype.$classData = this;
  var arrayBase = (componentData.arrayBase || componentData);
  var arrayDepth = (componentData.arrayDepth + 1);
  var name = ("[" + componentData.arrayEncodedName);
  this.constr = ArrayClass;
  this.ancestors = ({
    jl_Cloneable: 1,
    Ljava_io_Serializable: 1
  });
  this.componentData = componentData;
  this.arrayBase = arrayBase;
  this.arrayDepth = arrayDepth;
  this.arrayEncodedName = name;
  this.name = name;
  this.isArrayClass = true;
  var isAssignableFromFun = ((that) => {
    var thatDepth = that.arrayDepth;
    return ((thatDepth === arrayDepth) ? arrayBase.isAssignableFromFun(that.arrayBase) : ((thatDepth > arrayDepth) && (arrayBase === $d_O)));
  });
  this.isAssignableFromFun = isAssignableFromFun;
  this.wrapArray = ((array) => new ArrayClass(array));
  var self = this;
  this.isInstance = ((obj) => {
    var data = (obj && obj.$classData);
    return ((!(!data)) && ((data === self) || isAssignableFromFun(data)));
  });
  return this;
});
$TypeData.prototype.getArrayOf = (function() {
  if ((!this._arrayOf)) {
    this._arrayOf = new $TypeData().initArray(this);
  }
  return this._arrayOf;
});
$TypeData.prototype.isAssignableFrom = (function(that) {
  return ((this === that) || this.isAssignableFromFun(that));
});
function $isArrayOf_O(obj, depth) {
  var data = (obj && obj.$classData);
  if ((!data)) {
    return false;
  } else {
    var arrayDepth = data.arrayDepth;
    return ((arrayDepth === depth) ? (!data.arrayBase.isPrimitive) : (arrayDepth > depth));
  }
}
function $isArrayOf_Z(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_Z))));
}
function $isArrayOf_C(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_C))));
}
function $isArrayOf_B(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_B))));
}
function $isArrayOf_S(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_S))));
}
function $isArrayOf_I(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_I))));
}
function $isArrayOf_J(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_J))));
}
function $isArrayOf_F(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_F))));
}
function $isArrayOf_D(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && (obj.$classData.arrayBase === $d_D))));
}
function $asArrayOf_O(obj, depth) {
  if (($isArrayOf_O(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "Ljava.lang.Object;", depth);
  }
}
function $asArrayOf_Z(obj, depth) {
  if (($isArrayOf_Z(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "Z", depth);
  }
}
function $asArrayOf_C(obj, depth) {
  if (($isArrayOf_C(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "C", depth);
  }
}
function $asArrayOf_B(obj, depth) {
  if (($isArrayOf_B(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "B", depth);
  }
}
function $asArrayOf_S(obj, depth) {
  if (($isArrayOf_S(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "S", depth);
  }
}
function $asArrayOf_I(obj, depth) {
  if (($isArrayOf_I(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "I", depth);
  }
}
function $asArrayOf_J(obj, depth) {
  if (($isArrayOf_J(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "J", depth);
  }
}
function $asArrayOf_F(obj, depth) {
  if (($isArrayOf_F(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "F", depth);
  }
}
function $asArrayOf_D(obj, depth) {
  if (($isArrayOf_D(obj, depth) || (obj === null))) {
    return obj;
  } else {
    $throwArrayCastException(obj, "D", depth);
  }
}
var $d_O = new $TypeData();
$d_O.ancestors = ({});
$d_O.arrayEncodedName = "Ljava.lang.Object;";
$d_O.isAssignableFromFun = ((that) => (!that.isPrimitive));
$d_O.name = "java.lang.Object";
$d_O.isInstance = ((obj) => (obj !== null));
$d_O._arrayOf = new $TypeData().initSpecializedArray($d_O, $ac_O, (void 0), false, ((that) => {
  var thatDepth = that.arrayDepth;
  return ((thatDepth === 1) ? (!that.arrayBase.isPrimitive) : (thatDepth > 1));
}));
$c_O.prototype.$classData = $d_O;
var $d_V = new $TypeData().initPrim((void 0), "V", "void", (void 0), (void 0));
var $d_Z = new $TypeData().initPrim(false, "Z", "boolean", $ac_Z, (void 0));
var $d_C = new $TypeData().initPrim(0, "C", "char", $ac_C, Uint16Array);
var $d_B = new $TypeData().initPrim(0, "B", "byte", $ac_B, Int8Array);
var $d_S = new $TypeData().initPrim(0, "S", "short", $ac_S, Int16Array);
var $d_I = new $TypeData().initPrim(0, "I", "int", $ac_I, Int32Array);
var $d_J = new $TypeData().initPrim($bL0, "J", "long", $ac_J, Int32Array);
var $d_F = new $TypeData().initPrim(0.0, "F", "float", $ac_F, Float32Array);
var $d_D = new $TypeData().initPrim(0.0, "D", "double", $ac_D, Float64Array);
var $typedArraysAreBigEndian = (new Int8Array(new Int32Array([1]).buffer)[0] === 0);
function $constArrayBuffer_B(len, encoded) {
  var buf = new ArrayBuffer(len);
  var view = new DataView(buf);
  var regularChunksEnd = ((encoded.length - 4) | 0);
  var i = 0;
  var j = 0;
  var chunk = 0;
  while (true) {
    chunk = (((encoded.charCodeAt(i) | (encoded.charCodeAt(((i + 1) | 0)) << 8)) | (encoded.charCodeAt(((i + 2) | 0)) << 16)) | (encoded.charCodeAt(((i + 3) | 0)) << 24));
    chunk = ((((chunk - 808464432) | 0) - ((chunk & 1616928864) >>> 3)) | 0);
    chunk = (((chunk & 1056980736) >>> 2) | (chunk & 4128831));
    chunk = (((chunk & 268369920) >>> 4) | (chunk & 4095));
    if ((i === regularChunksEnd)) {
      break;
    }
    view.setUint32(j, chunk, true);
    i = ((i + 4) | 0);
    j = ((j + 3) | 0);
  }
  var trailing = ((len - j) | 0);
  view.setUint8(j, chunk);
  if ((trailing !== 1)) {
    view.setUint8(((j + 1) | 0), (chunk >>> 8));
    if ((trailing === 3)) {
      view.setUint8(((j + 2) | 0), (chunk >>> 16));
    }
  }
  return buf;
}
function $constArrayBuffer_S(len, encoded) {
  var buf = $constArrayBuffer_B((len << 1), encoded);
  if ($typedArraysAreBigEndian) {
    var view = new DataView(buf);
    var i = 0;
    while ((i !== len)) {
      view.putInt16(i, view.getInt16(i, true), false);
      i = ((i + 2) | 0);
    }
  }
  return buf;
}
function $constArrayBuffer_I(len, encoded) {
  var buf = $constArrayBuffer_B((len << 2), encoded);
  if ($typedArraysAreBigEndian) {
    var view = new DataView(buf);
    var i = 0;
    while ((i !== len)) {
      view.putInt32(i, view.getInt32(i, true), false);
      i = ((i + 4) | 0);
    }
  }
  return buf;
}
function $constArrayBuffer_J(len, encoded) {
  return $constArrayBuffer_I((len << 1), encoded);
}
function $constTypedArrayU_I(len, encoded, prevMask) {
  var buf = new Int32Array(len);
  var inLen = (encoded.length | 0);
  var prev = 0;
  var i = 0;
  var j = 0;
  var v = 0;
  while ((i !== inLen)) {
    var c = encoded.charCodeAt(i);
    if ((c < 80)) {
      v = ((v | (c - 48)) << 5);
    } else {
      v = (v | (c - 93));
      prev = (((prev & prevMask) + v) | 0);
      buf[j] = prev;
      j = ((j + 1) | 0);
      v = 0;
    }
    i = ((i + 1) | 0);
  }
  return buf;
}
function $constTypedArrayS_I(len, encoded, prevMask) {
  var buf = new Int32Array(len);
  var inLen = (encoded.length | 0);
  var prev = 0;
  var i = 0;
  var j = 0;
  var v = 0;
  var first = true;
  while ((i !== inLen)) {
    var c = encoded.charCodeAt(i);
    if ((c < 80)) {
      if (first) {
        v = (((c - 48) << 27) >> 22);
        first = false;
      } else {
        v = ((v | (c - 48)) << 5);
      }
    } else {
      if (first) {
        v = (((c - 93) << 27) >> 27);
      } else {
        v = (v | (c - 93));
        first = true;
      }
      prev = (((prev & prevMask) + v) | 0);
      buf[j] = prev;
      j = ((j + 1) | 0);
    }
    i = ((i + 1) | 0);
  }
  return buf;
}
function $constArrRaw_B(len, encoded) {
  return new $ac_B(new Int8Array($constArrayBuffer_B(len, encoded)));
}
function $constArrRaw_S(len, encoded) {
  return new $ac_S(new Int16Array($constArrayBuffer_S(len, encoded)));
}
function $constArrRaw_C(len, encoded) {
  return new $ac_C(new Uint16Array($constArrayBuffer_S(len, encoded)));
}
function $constArrRaw_I(len, encoded) {
  return new $ac_I(new Int32Array($constArrayBuffer_I(len, encoded)));
}
function $constArrRaw_J(len, encoded) {
  return new $ac_J(new Int32Array($constArrayBuffer_J(len, encoded)));
}
function $constArrUVals_I(len, encoded) {
  return new $ac_I($constTypedArrayU_I(len, encoded, 0));
}
function $constArrUDiffs_I(len, encoded) {
  return new $ac_I($constTypedArrayU_I(len, encoded, (-1)));
}
function $constArrSVals_I(len, encoded) {
  return new $ac_I($constTypedArrayS_I(len, encoded, 0));
}
function $constArrSDiffs_I(len, encoded) {
  return new $ac_I($constTypedArrayS_I(len, encoded, (-1)));
}
function $constArrUVals_J(len, encoded) {
  return new $ac_J($constTypedArrayU_I((len << 1), encoded, 0));
}
function $constArrUDiffs_J(len, encoded) {
  return new $ac_J($constTypedArrayU_I((len << 1), encoded, (-1)));
}
function $constArrSVals_J(len, encoded) {
  return new $ac_J($constTypedArrayS_I((len << 1), encoded, 0));
}
function $constArrSDiffs_J(len, encoded) {
  return new $ac_J($constTypedArrayS_I((len << 1), encoded, (-1)));
}
function $s_LMain__main__AT__V(args) {
  $m_LMain$().main__AT__V(args);
}
function $p_LMain$__floorDiv__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger($thiz, a, b) {
  var q = $n(a).divide__Ljava_math_BigInteger__Ljava_math_BigInteger(b);
  var this$1 = $n(a);
  if ((this$1.Ljava_math_BigInteger__f_sign < 0)) {
    var this$2 = $n($n(a).remainder__Ljava_math_BigInteger__Ljava_math_BigInteger(b));
    var $x_1 = (this$2.Ljava_math_BigInteger__f_sign !== 0);
  } else {
    var $x_1 = false;
  }
  if ($x_1) {
    var this$3 = $n(q);
    var bi = $thiz.LMain$__f_One;
    return $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$3, bi);
  } else {
    return q;
  }
}
/** @constructor */
function $c_LMain$() {
  this.LMain$__f_Zero = null;
  this.LMain$__f_One = null;
  this.LMain$__f_Ten = null;
  $n_LMain$ = this;
  this.LMain$__f_Zero = $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO;
  this.LMain$__f_One = $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ONE;
  this.LMain$__f_Ten = $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_TEN;
}
$c_LMain$.prototype = new $h_O();
$c_LMain$.prototype.constructor = $c_LMain$;
/** @constructor */
function $h_LMain$() {
}
$h_LMain$.prototype = $c_LMain$.prototype;
$c_LMain$.prototype.main__AT__V = (function(args) {
  var value = (1000000.0 * $uD($m_jl_System$NanoTime$().jl_System$NanoTime$__f_highPrecisionTimer.now()));
  var $x_1 = $m_RTLong$().fromDouble__D__J(value);
  var _\uff3ft0_$_lo = $x_1.l;
  var _\uff3ft0_$_hi = $x_1.h;
  var q = this.LMain$__f_One;
  var r = this.LMain$__f_Zero;
  var t = this.LMain$__f_One;
  var k_$_lo = 1;
  var k_$_hi = 0;
  var n_$_lo = 3;
  var n_$_hi = 0;
  var l_$_lo = 3;
  var l_$_hi = 0;
  var digits = 0;
  var sum_$_lo = 0;
  var sum_$_hi = 0;
  while ((digits < 1000)) {
    var $x_2 = $n(t);
    var lVal_$_lo = n_$_lo;
    var lVal_$_hi = n_$_hi;
    var nTimesT = $x_2.multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(lVal_$_lo, lVal_$_hi));
    var this$2 = $n($n(q).shiftLeft__I__Ljava_math_BigInteger(2));
    var bi = r;
    var this$3 = $n($m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$2, bi));
    var bi$1 = t;
    if (($n($m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$3, bi$1)).compareTo__Ljava_math_BigInteger__I(nTimesT) < 0)) {
      var x_$_lo = sum_$_lo;
      var x_$_hi = sum_$_hi;
      var x$1_$_lo = n_$_lo;
      var x$1_$_hi = n_$_hi;
      var lo = ((x_$_lo + x$1_$_lo) | 0);
      var hi = ((((x_$_hi + x$1_$_hi) | 0) + (((lo >>> 0) < (x_$_lo >>> 0)) | 0)) | 0);
      sum_$_lo = lo;
      sum_$_hi = hi;
      digits = ((1 + digits) | 0);
      var this$5 = $n(r);
      var rNext = $n($m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$5, nTimesT)).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(this.LMain$__f_Ten);
      var this$6 = $n($n(q).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(3, 0)));
      var bi$2 = r;
      var this$8 = $n($p_LMain$__floorDiv__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this, $n($m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$6, bi$2)).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(this.LMain$__f_Ten), t));
      var x$2_$_lo = n_$_lo;
      var x$2_$_hi = n_$_hi;
      var b0 = (65535 & x$2_$_lo);
      var b1 = ((x$2_$_lo >>> 16) | 0);
      var a0b0 = Math.imul(10, b0);
      var a0b1 = Math.imul(10, b1);
      var lo$1 = ((a0b0 + (a0b1 << 16)) | 0);
      var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
      var hi$1 = ((Math.imul(10, x$2_$_hi) + ((c1part >>> 16) | 0)) | 0);
      var bi$3 = $m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(lo$1, hi$1);
      var nNext = $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$8, bi$3);
      q = $n(q).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(this.LMain$__f_Ten);
      r = rNext;
      var $x_3 = $n(nNext).longValueExact__J();
      n_$_lo = $x_3.l;
      n_$_hi = $x_3.h;
    } else {
      var lVal$1_$_lo = k_$_lo;
      var lVal$1_$_hi = k_$_hi;
      var kBig = $m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(lVal$1_$_lo, lVal$1_$_hi);
      var lVal$2_$_lo = l_$_lo;
      var lVal$2_$_hi = l_$_hi;
      var lBig = $m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(lVal$2_$_lo, lVal$2_$_hi);
      var this$9 = $n($n(q).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(2, 0)));
      var bi$4 = r;
      var rNext$2 = $n($m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$9, bi$4)).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(lBig);
      var tNext = $n(t).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(lBig);
      var $x_4 = q;
      var x$3_$_lo = k_$_lo;
      var x$3_$_hi = k_$_hi;
      var b0$1 = (65535 & x$3_$_lo);
      var b1$1 = ((x$3_$_lo >>> 16) | 0);
      var a0b0$1 = Math.imul(7, b0$1);
      var a0b1$1 = Math.imul(7, b1$1);
      var lo$2 = ((a0b0$1 + (a0b1$1 << 16)) | 0);
      var c1part$1 = ((((a0b0$1 >>> 16) | 0) + a0b1$1) | 0);
      var hi$2 = ((Math.imul(7, x$3_$_hi) + ((c1part$1 >>> 16) | 0)) | 0);
      var lo$3 = ((2 + lo$2) | 0);
      var hi$3 = ((hi$2 + (((lo$3 >>> 0) < 2) | 0)) | 0);
      var this$12 = $n($n($x_4).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(lo$3, hi$3)));
      var bi$5 = $n(r).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(lBig);
      var num = $m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$12, bi$5);
      var nNext$2 = $p_LMain$__floorDiv__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this, num, tNext);
      q = $n(q).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger(kBig);
      r = rNext$2;
      t = tNext;
      var x$4_$_lo = k_$_lo;
      var x$4_$_hi = k_$_hi;
      var lo$4 = ((1 + x$4_$_lo) | 0);
      var hi$4 = ((x$4_$_hi + ((lo$4 === 0) | 0)) | 0);
      k_$_lo = lo$4;
      k_$_hi = hi$4;
      var $x_5 = $n(nNext$2).longValueExact__J();
      n_$_lo = $x_5.l;
      n_$_hi = $x_5.h;
      var x$5_$_lo = l_$_lo;
      var x$5_$_hi = l_$_hi;
      var lo$5 = ((2 + x$5_$_lo) | 0);
      var hi$5 = ((x$5_$_hi + (((lo$5 >>> 0) < 2) | 0)) | 0);
      l_$_lo = lo$5;
      l_$_hi = hi$5;
    }
  }
  var $x_7 = $n($m_jl_System$Streams$().jl_System$Streams$__f_err);
  var value$1 = (1000000.0 * $uD($m_jl_System$NanoTime$().jl_System$NanoTime$__f_highPrecisionTimer.now()));
  var $x_6 = $m_RTLong$().fromDouble__D__J(value$1);
  var x$6_$_lo = $x_6.l;
  var x$6_$_hi = $x_6.h;
  var lo$6 = ((x$6_$_lo - _\uff3ft0_$_lo) | 0);
  var hi$6 = ((((x$6_$_hi - _\uff3ft0_$_hi) | 0) - (((lo$6 >>> 0) > (x$6_$_lo >>> 0)) | 0)) | 0);
  $x_7.println__T__V(("TIME_MS=" + (((4.294967296E9 * hi$6) + (lo$6 >>> 0.0)) / 1000000.0)));
  var x$7_$_lo = sum_$_lo;
  var x$7_$_hi = sum_$_hi;
  var this$20 = $m_s_Console$();
  var this$21 = $n(this$20.out__Ljava_io_PrintStream());
  this$21.java$lang$JSConsoleBasedPrintStream$$printString__T__V(($s_RTLong__toString__I__I__T(x$7_$_lo, x$7_$_hi) + "\n"));
});
var $d_LMain$ = new $TypeData().initClass($c_LMain$, "Main$", ({
  LMain$: 1
}));
var $n_LMain$;
function $m_LMain$() {
  if ((!$n_LMain$)) {
    $n_LMain$ = new $c_LMain$();
  }
  return $n_LMain$;
}
/** @constructor */
function $c_jl_System$NanoTime$() {
  this.jl_System$NanoTime$__f_highPrecisionTimer = null;
  $n_jl_System$NanoTime$ = this;
  if (($as_T((typeof performance)) !== "undefined")) {
    var x = performance.now;
    var $x_1 = (!(x === (void 0)));
  } else {
    var $x_1 = false;
  }
  this.jl_System$NanoTime$__f_highPrecisionTimer = ($x_1 ? performance : Date);
}
$c_jl_System$NanoTime$.prototype = new $h_O();
$c_jl_System$NanoTime$.prototype.constructor = $c_jl_System$NanoTime$;
/** @constructor */
function $h_jl_System$NanoTime$() {
}
$h_jl_System$NanoTime$.prototype = $c_jl_System$NanoTime$.prototype;
var $d_jl_System$NanoTime$ = new $TypeData().initClass($c_jl_System$NanoTime$, "java.lang.System$NanoTime$", ({
  jl_System$NanoTime$: 1
}));
var $n_jl_System$NanoTime$;
function $m_jl_System$NanoTime$() {
  if ((!$n_jl_System$NanoTime$)) {
    $n_jl_System$NanoTime$ = new $c_jl_System$NanoTime$();
  }
  return $n_jl_System$NanoTime$;
}
/** @constructor */
function $c_jl_System$Streams$() {
  this.jl_System$Streams$__f_out = null;
  this.jl_System$Streams$__f_err = null;
  $n_jl_System$Streams$ = this;
  this.jl_System$Streams$__f_out = new $c_jl_JSConsoleBasedPrintStream(false);
  this.jl_System$Streams$__f_err = new $c_jl_JSConsoleBasedPrintStream(true);
}
$c_jl_System$Streams$.prototype = new $h_O();
$c_jl_System$Streams$.prototype.constructor = $c_jl_System$Streams$;
/** @constructor */
function $h_jl_System$Streams$() {
}
$h_jl_System$Streams$.prototype = $c_jl_System$Streams$.prototype;
var $d_jl_System$Streams$ = new $TypeData().initClass($c_jl_System$Streams$, "java.lang.System$Streams$", ({
  jl_System$Streams$: 1
}));
var $n_jl_System$Streams$;
function $m_jl_System$Streams$() {
  if ((!$n_jl_System$Streams$)) {
    $n_jl_System$Streams$ = new $c_jl_System$Streams$();
  }
  return $n_jl_System$Streams$;
}
function $f_jl_Void__hashCode__I($thiz) {
  return 0;
}
function $f_jl_Void__toString__T($thiz) {
  return "undefined";
}
var $d_jl_Void = new $TypeData().initClass(0, "java.lang.Void", ({
  jl_Void: 1
}), ((x) => (x === (void 0))));
/** @constructor */
function $c_Ljava_math_BitLevel$() {
}
$c_Ljava_math_BitLevel$.prototype = new $h_O();
$c_Ljava_math_BitLevel$.prototype.constructor = $c_Ljava_math_BitLevel$;
/** @constructor */
function $h_Ljava_math_BitLevel$() {
}
$h_Ljava_math_BitLevel$.prototype = $c_Ljava_math_BitLevel$.prototype;
$c_Ljava_math_BitLevel$.prototype.bitLength__Ljava_math_BigInteger__I = (function(bi) {
  if (($n(bi).Ljava_math_BigInteger__f_sign === 0)) {
    return 0;
  } else {
    var bLength = ($n(bi).Ljava_math_BigInteger__f_numberLength << 5);
    var highDigit = $n($n(bi).Ljava_math_BigInteger__f_digits).get((($n(bi).Ljava_math_BigInteger__f_numberLength - 1) | 0));
    if (($n(bi).Ljava_math_BigInteger__f_sign < 0)) {
      var i = $n(bi).getFirstNonzeroDigit__I();
      if ((i === (($n(bi).Ljava_math_BigInteger__f_numberLength - 1) | 0))) {
        highDigit = ((highDigit - 1) | 0);
      }
    }
    var $x_1 = bLength;
    var i$1 = highDigit;
    bLength = (($x_1 - Math.clz32(i$1)) | 0);
    return bLength;
  }
});
$c_Ljava_math_BitLevel$.prototype.shiftLeft__Ljava_math_BigInteger__I__Ljava_math_BigInteger = (function(source, count) {
  var intCount = ((count >>> 5) | 0);
  var andCount = (31 & count);
  var offset = ((andCount !== 0) | 0);
  var resLength = (((($n(source).Ljava_math_BigInteger__f_numberLength + intCount) | 0) + offset) | 0);
  $m_Ljava_math_BigInteger$().checkRangeBasedOnIntArrayLength__I__V(resLength);
  var resDigits = new $ac_I(resLength);
  this.shiftLeft__AI__AI__I__I__V(resDigits, $n(source).Ljava_math_BigInteger__f_digits, intCount, andCount);
  var result = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), $n(source).Ljava_math_BigInteger__f_sign, resLength, resDigits);
  result.cutOffLeadingZeroes__V();
  return result;
});
$c_Ljava_math_BitLevel$.prototype.shiftLeft__AI__AI__I__I__V = (function(result, source, intCount, count) {
  if ((count === 0)) {
    var x4 = (($n(result).u.length - intCount) | 0);
    $systemArraycopy($n(source), 0, $n(result), intCount, x4);
  } else {
    var rightShiftCount = ((32 - count) | 0);
    $n(result).set((($n(result).u.length - 1) | 0), 0);
    var i = (($n(result).u.length - 1) | 0);
    while ((i > intCount)) {
      var ev$1 = i;
      $n(result).set(ev$1, ($n(result).get(ev$1) | (($n(source).get(((((i - intCount) | 0) - 1) | 0)) >>> rightShiftCount) | 0)));
      $n(result).set(((i - 1) | 0), ($n(source).get(((((i - intCount) | 0) - 1) | 0)) << count));
      i = ((i - 1) | 0);
    }
  }
  var i$1 = 0;
  while ((i$1 < intCount)) {
    var value = i$1;
    $n(result).set(value, 0);
    i$1 = ((1 + i$1) | 0);
  }
});
$c_Ljava_math_BitLevel$.prototype.shiftLeftOneBit__AI__AI__I__V = (function(result, source, srcLen) {
  var elem = 0;
  elem = 0;
  var i = 0;
  while ((i < srcLen)) {
    var value = i;
    var iVal = $n(source).get(value);
    $n(result).set(value, ((iVal << 1) | elem));
    elem = ((iVal >>> 31) | 0);
    i = ((1 + i) | 0);
  }
  if ((elem !== 0)) {
    $n(result).set(srcLen, elem);
  }
});
$c_Ljava_math_BitLevel$.prototype.shiftRight__Ljava_math_BigInteger__I__Ljava_math_BigInteger = (function(source, count) {
  var intCount = ((count >>> 5) | 0);
  var andCount = (31 & count);
  if ((intCount >= $n(source).Ljava_math_BigInteger__f_numberLength)) {
    return (($n(source).Ljava_math_BigInteger__f_sign < 0) ? $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_MINUS_ONE : $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO);
  } else {
    var resLength = (($n(source).Ljava_math_BigInteger__f_numberLength - intCount) | 0);
    var resDigits = new $ac_I(((1 + resLength) | 0));
    this.shiftRight__AI__I__AI__I__I__Z(resDigits, resLength, $n(source).Ljava_math_BigInteger__f_digits, intCount, andCount);
    if (($n(source).Ljava_math_BigInteger__f_sign < 0)) {
      var i = 0;
      while (((i < intCount) && ($n($n(source).Ljava_math_BigInteger__f_digits).get(i) === 0))) {
        i = ((1 + i) | 0);
      }
      var cmp = (($n($n(source).Ljava_math_BigInteger__f_digits).get(i) << ((-andCount) | 0)) !== 0);
      if (((i < intCount) || ((andCount > 0) && cmp))) {
        i = 0;
        while (((i < resLength) && (resDigits.get(i) === (-1)))) {
          resDigits.set(i, 0);
          i = ((1 + i) | 0);
        }
        if ((i === resLength)) {
          resLength = ((1 + resLength) | 0);
        }
        var ev$1 = i;
        resDigits.set(ev$1, ((1 + resDigits.get(ev$1)) | 0));
      }
    }
    var result = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), $n(source).Ljava_math_BigInteger__f_sign, resLength, resDigits);
    result.cutOffLeadingZeroes__V();
    return result;
  }
});
$c_Ljava_math_BitLevel$.prototype.shiftRight__AI__I__AI__I__I__Z = (function(result, resultLen, source, intCount, count) {
  var i = 0;
  var allZero = true;
  while ((i < intCount)) {
    allZero = (!(!(allZero & ($n(source).get(i) === 0))));
    i = ((1 + i) | 0);
  }
  if ((count === 0)) {
    $systemArraycopy($n(source), intCount, $n(result), 0, resultLen);
  } else {
    var leftShiftCount = ((32 - count) | 0);
    allZero = (!(!(allZero & (($n(source).get(i) << leftShiftCount) === 0))));
    i = 0;
    while ((i < ((resultLen - 1) | 0))) {
      $n(result).set(i, ((($n(source).get(((i + intCount) | 0)) >>> count) | 0) | ($n(source).get(((1 + ((i + intCount) | 0)) | 0)) << leftShiftCount)));
      i = ((1 + i) | 0);
    }
    $n(result).set(i, (($n(source).get(((i + intCount) | 0)) >>> count) | 0));
    i = ((1 + i) | 0);
  }
  return allZero;
});
var $d_Ljava_math_BitLevel$ = new $TypeData().initClass($c_Ljava_math_BitLevel$, "java.math.BitLevel$", ({
  Ljava_math_BitLevel$: 1
}));
var $n_Ljava_math_BitLevel$;
function $m_Ljava_math_BitLevel$() {
  if ((!$n_Ljava_math_BitLevel$)) {
    $n_Ljava_math_BitLevel$ = new $c_Ljava_math_BitLevel$();
  }
  return $n_Ljava_math_BitLevel$;
}
function $p_Ljava_math_Conversion$__dropLeadingZeros__T__T($thiz, s) {
  var zeroPrefixLength = 0;
  var this$1 = $n(s);
  var len = this$1.length;
  while (true) {
    if ((zeroPrefixLength < len)) {
      var this$2 = $n(s);
      var index = zeroPrefixLength;
      var $x_1 = ($charAt(this$2, index) === 48);
    } else {
      var $x_1 = false;
    }
    if ($x_1) {
      zeroPrefixLength = ((1 + zeroPrefixLength) | 0);
    } else {
      break;
    }
  }
  var this$3 = $n(s);
  var beginIndex = zeroPrefixLength;
  var length = this$3.length;
  if (((beginIndex >>> 0) > (length >>> 0))) {
    $charAt(this$3, beginIndex);
  }
  return $as_T(this$3.substring(beginIndex));
}
/** @constructor */
function $c_Ljava_math_Conversion$() {
}
$c_Ljava_math_Conversion$.prototype = new $h_O();
$c_Ljava_math_Conversion$.prototype.constructor = $c_Ljava_math_Conversion$;
/** @constructor */
function $h_Ljava_math_Conversion$() {
}
$h_Ljava_math_Conversion$.prototype = $c_Ljava_math_Conversion$.prototype;
$c_Ljava_math_Conversion$.prototype.toDecimalScaledString__Ljava_math_BigInteger__T = (function(bi) {
  var sign = $n(bi).Ljava_math_BigInteger__f_sign;
  var numberLength = $n(bi).Ljava_math_BigInteger__f_numberLength;
  var digits = $n(bi).Ljava_math_BigInteger__f_digits;
  if ((sign === 0)) {
    return "0";
  } else if ((numberLength === 1)) {
    var i = $n(digits).get(0);
    var absStr = $as_T((i >>> 0.0).toString(10));
    return ((sign < 0) ? ("-" + absStr) : absStr);
  } else {
    var result = "";
    var temp = new $ac_I(numberLength);
    var tempLen = numberLength;
    var x4 = tempLen;
    $systemArraycopy($n(digits), 0, temp, 0, x4);
    while (true) {
      var rem = 0;
      var i$1 = ((tempLen - 1) | 0);
      while ((i$1 >= 0)) {
        var value = rem;
        var value$1 = temp.get(i$1);
        var aHat = ((4.294967296E9 * (value >>> 0.0)) + (value$1 >>> 0.0));
        var x = (1.0000000000000017E-9 * aHat);
        var lo = (x | 0.0);
        var x$1 = (2.3283064365386963E-10 * x);
        var hi$2 = (x$1 | 0.0);
        var rHat = ((value$1 - Math.imul(1000000000, lo)) | 0);
        if ((rHat < 0)) {
          var lo$1 = ((lo - 1) | 0);
          var hi$3 = ((((hi$2 - 1) | 0) + ((lo$1 !== (-1)) | 0)) | 0);
          var x$2_$_lo = lo$1;
          var x$2_$_hi = hi$3;
        } else {
          var x$2_$_lo = lo;
          var x$2_$_hi = hi$2;
        }
        temp.set(i$1, x$2_$_lo);
        var b0 = (65535 & x$2_$_lo);
        var b1 = ((x$2_$_lo >>> 16) | 0);
        var a0b0 = Math.imul(51712, b0);
        var a1b0 = Math.imul(15258, b0);
        var a0b1 = Math.imul(51712, b1);
        var lo$2 = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
        var lo$3 = ((value$1 - lo$2) | 0);
        rem = lo$3;
        i$1 = ((i$1 - 1) | 0);
      }
      var this$22 = rem;
      var remStr = ("" + this$22);
      var beginIndex = remStr.length;
      if (((beginIndex >>> 0) > 9)) {
        $charAt("000000000", beginIndex);
      }
      var padding = $as_T("000000000".substring(beginIndex));
      result = ((padding + remStr) + result);
      while (((tempLen !== 0) && (temp.get(((tempLen - 1) | 0)) === 0))) {
        tempLen = ((tempLen - 1) | 0);
      }
      if ((tempLen !== 0)) {
      } else {
        break;
      }
    }
    result = $p_Ljava_math_Conversion$__dropLeadingZeros__T__T(this, result);
    return ((sign < 0) ? ("-" + result) : result);
  }
});
var $d_Ljava_math_Conversion$ = new $TypeData().initClass($c_Ljava_math_Conversion$, "java.math.Conversion$", ({
  Ljava_math_Conversion$: 1
}));
var $n_Ljava_math_Conversion$;
function $m_Ljava_math_Conversion$() {
  if ((!$n_Ljava_math_Conversion$)) {
    $n_Ljava_math_Conversion$ = new $c_Ljava_math_Conversion$();
  }
  return $n_Ljava_math_Conversion$;
}
/** @constructor */
function $c_Ljava_math_Division$() {
}
$c_Ljava_math_Division$.prototype = new $h_O();
$c_Ljava_math_Division$.prototype.constructor = $c_Ljava_math_Division$;
/** @constructor */
function $h_Ljava_math_Division$() {
}
$h_Ljava_math_Division$.prototype = $c_Ljava_math_Division$.prototype;
$c_Ljava_math_Division$.prototype.divide__AI__I__AI__I__AI__I__AI = (function(quot, quotLength, a, aLength, b, bLength) {
  var normA = new $ac_I(((1 + aLength) | 0));
  var normB = new $ac_I(((1 + bLength) | 0));
  var i = $n(b).get(((bLength - 1) | 0));
  var divisorShift = Math.clz32(i);
  if ((divisorShift !== 0)) {
    $m_Ljava_math_BitLevel$().shiftLeft__AI__AI__I__I__V(normB, b, 0, divisorShift);
    $m_Ljava_math_BitLevel$().shiftLeft__AI__AI__I__I__V(normA, a, 0, divisorShift);
  } else {
    $systemArraycopy($n(a), 0, normA, 0, aLength);
    $systemArraycopy($n(b), 0, normB, 0, bLength);
  }
  var firstDivisorDigit = normB.get(((bLength - 1) | 0));
  var i$1 = ((quotLength - 1) | 0);
  var elem = 0;
  elem = aLength;
  while ((i$1 >= 0)) {
    var elem$1 = 0;
    elem$1 = 0;
    if ((normA.get(elem) === firstDivisorDigit)) {
      elem$1 = (-1);
    } else {
      var value = normA.get(elem);
      var value$1 = normA.get(((elem - 1) | 0));
      var this$13 = $m_RTLong$();
      var $x_1 = this$13.divideUnsignedImpl__I__I__I__I__J(value$1, value, firstDivisorDigit, 0);
      var quotient_$_lo = $x_1.l;
      var quotient_$_hi = $x_1.h;
      elem$1 = quotient_$_lo;
      var a0 = (65535 & quotient_$_lo);
      var a1 = ((quotient_$_lo >>> 16) | 0);
      var b0 = (65535 & firstDivisorDigit);
      var b1 = ((firstDivisorDigit >>> 16) | 0);
      var a0b0 = Math.imul(a0, b0);
      var a1b0 = Math.imul(a1, b0);
      var a0b1 = Math.imul(a0, b1);
      var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
      var lo$1 = ((value$1 - lo) | 0);
      var elem$2 = 0;
      elem$2 = lo$1;
      if ((elem$1 !== 0)) {
        elem$1 = ((1 + elem$1) | 0);
        while (true) {
          elem$1 = ((elem$1 - 1) | 0);
          var value$2 = elem$1;
          var value$3 = normB.get(((bLength - 2) | 0));
          var a0$1 = (65535 & value$2);
          var a1$1 = ((value$2 >>> 16) | 0);
          var b0$1 = (65535 & value$3);
          var b1$1 = ((value$3 >>> 16) | 0);
          var a0b0$1 = Math.imul(a0$1, b0$1);
          var a1b0$1 = Math.imul(a1$1, b0$1);
          var a0b1$1 = Math.imul(a0$1, b1$1);
          var lo$2 = ((a0b0$1 + (((a1b0$1 + a0b1$1) | 0) << 16)) | 0);
          var c1part$1 = ((((a0b0$1 >>> 16) | 0) + a0b1$1) | 0);
          var hi$7 = ((((Math.imul(a1$1, b1$1) + ((c1part$1 >>> 16) | 0)) | 0) + (((((65535 & c1part$1) + a1b0$1) | 0) >>> 16) | 0)) | 0);
          var value$4 = elem$2;
          var value$5 = normA.get(((elem - 2) | 0));
          var value$6 = elem$2;
          var lo$3 = ((value$6 + firstDivisorDigit) | 0);
          var hi$12 = (((lo$3 >>> 0) < (value$6 >>> 0)) | 0);
          if ((hi$12 === 0)) {
            elem$2 = lo$3;
            if (((hi$7 === value$4) ? ((lo$2 >>> 0) > (value$5 >>> 0)) : ((hi$7 >>> 0) > (value$4 >>> 0)))) {
              continue;
            }
          }
          break;
        }
      }
    }
    if ((elem$1 !== 0)) {
      var borrow = $m_Ljava_math_Division$().multiplyAndSubtract__AI__I__AI__I__I__I(normA, ((elem - bLength) | 0), normB, bLength, elem$1);
      if ((borrow !== 0)) {
        elem$1 = ((elem$1 - 1) | 0);
        var elem$3_$_lo = 0;
        var elem$3_$_hi = 0;
        elem$3_$_lo = 0;
        elem$3_$_hi = 0;
        var i$2 = 0;
        while ((i$2 < bLength)) {
          var value$7 = i$2;
          var x_$_lo = elem$3_$_lo;
          var x_$_hi = elem$3_$_hi;
          var value$8 = normA.get(((((elem - bLength) | 0) + value$7) | 0));
          var value$9 = normB.get(value$7);
          var lo$4 = ((value$8 + value$9) | 0);
          var hi$15 = (((lo$4 >>> 0) < (value$8 >>> 0)) | 0);
          var lo$5 = ((x_$_lo + lo$4) | 0);
          var hi$16 = ((((x_$_hi + hi$15) | 0) + (((lo$5 >>> 0) < (x_$_lo >>> 0)) | 0)) | 0);
          elem$3_$_lo = lo$5;
          elem$3_$_hi = hi$16;
          var $x_2 = elem;
          var x$1_$_lo = elem$3_$_lo;
          var x$1_$_hi = elem$3_$_hi;
          normA.set((((($x_2 - bLength) | 0) + value$7) | 0), x$1_$_lo);
          var x$2_$_lo = elem$3_$_lo;
          var x$2_$_hi = elem$3_$_hi;
          elem$3_$_lo = x$2_$_hi;
          elem$3_$_hi = 0;
          i$2 = ((1 + i$2) | 0);
        }
      }
    }
    if ((quot !== null)) {
      $n(quot).set(i$1, elem$1);
    }
    elem = ((elem - 1) | 0);
    i$1 = ((i$1 - 1) | 0);
  }
  if ((divisorShift !== 0)) {
    $m_Ljava_math_BitLevel$().shiftRight__AI__I__AI__I__I__Z(normB, bLength, normA, 0, divisorShift);
    return normB;
  } else {
    $systemArraycopy(normA, 0, normB, 0, bLength);
    return normA;
  }
});
$c_Ljava_math_Division$.prototype.divideArrayByInt__AI__AI__I__I__I = (function(dest, src, srcLength, divisor) {
  var rem = 0;
  var i = ((srcLength - 1) | 0);
  while ((i >= 0)) {
    var value = rem;
    var value$1 = $n(src).get(i);
    var this$9 = $m_RTLong$();
    var $x_1 = this$9.divideUnsignedImpl__I__I__I__I__J(value$1, value, divisor, 0);
    var quot_$_lo = $x_1.l;
    var quot_$_hi = $x_1.h;
    var a0 = (65535 & quot_$_lo);
    var a1 = ((quot_$_lo >>> 16) | 0);
    var b0 = (65535 & divisor);
    var b1 = ((divisor >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var lo$1 = ((value$1 - lo) | 0);
    rem = lo$1;
    $n(dest).set(i, quot_$_lo);
    i = ((i - 1) | 0);
  }
  return rem;
});
$c_Ljava_math_Division$.prototype.multiplyAndSubtract__AI__I__AI__I__I__I = (function(a, start, b, bLen, c) {
  var elem = 0;
  elem = 0;
  var elem$1 = 0;
  elem$1 = 0;
  var i = 0;
  while ((i < bLen)) {
    var value = i;
    $m_Ljava_math_Multiplication$();
    var a$1 = $n(b).get(value);
    var c$1 = elem;
    var a0 = (65535 & a$1);
    var a1 = ((a$1 >>> 16) | 0);
    var b0 = (65535 & c);
    var b1 = ((c >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$2 = ((((Math.imul(a1, b1) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$1 = ((lo + c$1) | 0);
    var hi$4 = ((hi$2 + (((lo$1 >>> 0) < (lo >>> 0)) | 0)) | 0);
    var value$1 = $n(a).get(((start + value) | 0));
    var lo$2 = ((value$1 - lo$1) | 0);
    var hi$6 = ((-(((lo$2 >>> 0) > (value$1 >>> 0)) | 0)) | 0);
    var value$2 = elem$1;
    var hi$7 = (value$2 >> 31);
    var lo$3 = ((lo$2 + value$2) | 0);
    var hi$8 = ((((hi$6 + hi$7) | 0) + (((lo$3 >>> 0) < (lo$2 >>> 0)) | 0)) | 0);
    $n(a).set(((start + value) | 0), lo$3);
    elem$1 = hi$8;
    elem = hi$4;
    i = ((1 + i) | 0);
  }
  var value$3 = $n(a).get(((start + bLen) | 0));
  var value$4 = elem;
  var lo$4 = ((value$3 - value$4) | 0);
  var hi$13 = ((-(((lo$4 >>> 0) > (value$3 >>> 0)) | 0)) | 0);
  var value$5 = elem$1;
  var hi$14 = (value$5 >> 31);
  var lo$5 = ((lo$4 + value$5) | 0);
  var hi$15 = ((((hi$13 + hi$14) | 0) + (((lo$5 >>> 0) < (lo$4 >>> 0)) | 0)) | 0);
  $n(a).set(((start + bLen) | 0), lo$5);
  return hi$15;
});
$c_Ljava_math_Division$.prototype.remainderArrayByInt__AI__I__I__I = (function(src, srcLength, divisor) {
  var result = 0;
  var i = ((srcLength - 1) | 0);
  while ((i >= 0)) {
    var value = result;
    var value$1 = $n(src).get(i);
    var this$9 = $m_RTLong$();
    var $x_1 = this$9.remainderUnsignedImpl__I__I__I__I__J(value$1, value, divisor, 0);
    var x_$_lo = $x_1.l;
    var x_$_hi = $x_1.h;
    result = x_$_lo;
    i = ((i - 1) | 0);
  }
  return result;
});
var $d_Ljava_math_Division$ = new $TypeData().initClass($c_Ljava_math_Division$, "java.math.Division$", ({
  Ljava_math_Division$: 1
}));
var $n_Ljava_math_Division$;
function $m_Ljava_math_Division$() {
  if ((!$n_Ljava_math_Division$)) {
    $n_Ljava_math_Division$ = new $c_Ljava_math_Division$();
  }
  return $n_Ljava_math_Division$;
}
function $p_Ljava_math_Elementary$__add__AI__I__AI__I__AI($thiz, a, aSize, b, bSize) {
  var res = new $ac_I(((1 + aSize) | 0));
  $p_Ljava_math_Elementary$__add__AI__AI__I__AI__I__V($thiz, res, a, aSize, b, bSize);
  return res;
}
function $p_Ljava_math_Elementary$__add__AI__AI__I__AI__I__V($thiz, res, a, aSize, b, bSize) {
  var i = 1;
  var value = $n(a).get(0);
  var value$1 = $n(b).get(0);
  var lo = ((value + value$1) | 0);
  var hi$2 = (((lo >>> 0) < (value >>> 0)) | 0);
  $n(res).set(0, lo);
  var carry = hi$2;
  if ((aSize >= bSize)) {
    while ((i < bSize)) {
      var value$2 = $n(a).get(i);
      var value$3 = $n(b).get(i);
      var lo$1 = ((value$2 + value$3) | 0);
      var hi$6 = (((lo$1 >>> 0) < (value$2 >>> 0)) | 0);
      var value$4 = carry;
      var lo$2 = ((lo$1 + value$4) | 0);
      var hi$8 = ((hi$6 + (((lo$2 >>> 0) < (lo$1 >>> 0)) | 0)) | 0);
      $n(res).set(i, lo$2);
      carry = hi$8;
      i = ((1 + i) | 0);
    }
    while ((i < aSize)) {
      var value$5 = $n(a).get(i);
      var value$6 = carry;
      var lo$3 = ((value$5 + value$6) | 0);
      var hi$12 = (((lo$3 >>> 0) < (value$5 >>> 0)) | 0);
      $n(res).set(i, lo$3);
      carry = hi$12;
      i = ((1 + i) | 0);
    }
  } else {
    while ((i < aSize)) {
      var value$7 = $n(a).get(i);
      var value$8 = $n(b).get(i);
      var lo$4 = ((value$7 + value$8) | 0);
      var hi$16 = (((lo$4 >>> 0) < (value$7 >>> 0)) | 0);
      var value$9 = carry;
      var lo$5 = ((lo$4 + value$9) | 0);
      var hi$18 = ((hi$16 + (((lo$5 >>> 0) < (lo$4 >>> 0)) | 0)) | 0);
      $n(res).set(i, lo$5);
      carry = hi$18;
      i = ((1 + i) | 0);
    }
    while ((i < bSize)) {
      var value$10 = $n(b).get(i);
      var value$11 = carry;
      var lo$6 = ((value$10 + value$11) | 0);
      var hi$22 = (((lo$6 >>> 0) < (value$10 >>> 0)) | 0);
      $n(res).set(i, lo$6);
      carry = hi$22;
      i = ((1 + i) | 0);
    }
  }
  if ((carry !== 0)) {
    $n(res).set(i, carry);
  }
}
function $p_Ljava_math_Elementary$__subtract__AI__I__AI__I__AI($thiz, a, aSize, b, bSize) {
  var res = new $ac_I(aSize);
  $p_Ljava_math_Elementary$__subtract__AI__AI__I__AI__I__V($thiz, res, a, aSize, b, bSize);
  return res;
}
function $p_Ljava_math_Elementary$__subtract__AI__AI__I__AI__I__V($thiz, res, a, aSize, b, bSize) {
  var i = 0;
  var borrow = 0;
  while ((i < bSize)) {
    var value = $n(a).get(i);
    var value$1 = $n(b).get(i);
    var lo = ((value - value$1) | 0);
    var hi$2 = ((-(((lo >>> 0) > (value >>> 0)) | 0)) | 0);
    var value$2 = borrow;
    var hi$3 = (value$2 >> 31);
    var lo$1 = ((lo + value$2) | 0);
    var hi$4 = ((((hi$2 + hi$3) | 0) + (((lo$1 >>> 0) < (lo >>> 0)) | 0)) | 0);
    $n(res).set(i, lo$1);
    borrow = hi$4;
    i = ((1 + i) | 0);
  }
  while ((i < aSize)) {
    var value$3 = $n(a).get(i);
    var value$4 = borrow;
    var hi$7 = (value$4 >> 31);
    var lo$2 = ((value$3 + value$4) | 0);
    var hi$8 = ((hi$7 + (((lo$2 >>> 0) < (value$3 >>> 0)) | 0)) | 0);
    $n(res).set(i, lo$2);
    borrow = hi$8;
    i = ((1 + i) | 0);
  }
}
/** @constructor */
function $c_Ljava_math_Elementary$() {
}
$c_Ljava_math_Elementary$.prototype = new $h_O();
$c_Ljava_math_Elementary$.prototype.constructor = $c_Ljava_math_Elementary$;
/** @constructor */
function $h_Ljava_math_Elementary$() {
}
$h_Ljava_math_Elementary$.prototype = $c_Ljava_math_Elementary$.prototype;
$c_Ljava_math_Elementary$.prototype.add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(op1, op2) {
  var op1Sign = $n(op1).Ljava_math_BigInteger__f_sign;
  var op2Sign = $n(op2).Ljava_math_BigInteger__f_sign;
  var op1Len = $n(op1).Ljava_math_BigInteger__f_numberLength;
  var op2Len = $n(op2).Ljava_math_BigInteger__f_numberLength;
  if ((op1Sign === 0)) {
    return op2;
  } else if ((op2Sign === 0)) {
    return op1;
  } else if ((((op1Len + op2Len) | 0) === 2)) {
    var value = $n($n(op1).Ljava_math_BigInteger__f_digits).get(0);
    var value$1 = $n($n(op2).Ljava_math_BigInteger__f_digits).get(0);
    if ((op1Sign === op2Sign)) {
      var lo = ((value + value$1) | 0);
      var hi$2 = (((lo >>> 0) < (value >>> 0)) | 0);
      return ((hi$2 === 0) ? $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), op1Sign, lo) : $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), op1Sign, 2, new $ac_I(new Int32Array([lo, hi$2]))));
    } else {
      var $x_2 = $m_Ljava_math_BigInteger$();
      if ((op1Sign < 0)) {
        var lo$1 = ((value$1 - value) | 0);
        var hi$3 = ((-(((lo$1 >>> 0) > (value$1 >>> 0)) | 0)) | 0);
        var $x_1_$_lo = lo$1;
        var $x_1_$_hi = hi$3;
      } else {
        var lo$2 = ((value - value$1) | 0);
        var hi$4 = ((-(((lo$2 >>> 0) > (value >>> 0)) | 0)) | 0);
        var $x_1_$_lo = lo$2;
        var $x_1_$_hi = hi$4;
      }
      return $x_2.valueOf__J__Ljava_math_BigInteger($x_1_$_lo, $x_1_$_hi);
    }
  } else {
    if ((op1Sign === op2Sign)) {
      var res$2 = ((op1Len >= op2Len) ? $p_Ljava_math_Elementary$__add__AI__I__AI__I__AI(this, $n(op1).Ljava_math_BigInteger__f_digits, op1Len, $n(op2).Ljava_math_BigInteger__f_digits, op2Len) : $p_Ljava_math_Elementary$__add__AI__I__AI__I__AI(this, $n(op2).Ljava_math_BigInteger__f_digits, op2Len, $n(op1).Ljava_math_BigInteger__f_digits, op1Len));
      var x1___1 = op1Sign;
      var x1___2 = res$2;
    } else {
      var cmp = ((op1Len !== op2Len) ? ((op1Len > op2Len) ? 1 : (-1)) : this.compareArrays__AI__AI__I__I($n(op1).Ljava_math_BigInteger__f_digits, $n(op2).Ljava_math_BigInteger__f_digits, op1Len));
      if ((cmp === 0)) {
        return $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO;
      }
      if ((cmp === 1)) {
        var _2 = $p_Ljava_math_Elementary$__subtract__AI__I__AI__I__AI(this, $n(op1).Ljava_math_BigInteger__f_digits, op1Len, $n(op2).Ljava_math_BigInteger__f_digits, op2Len);
        var x1___1 = op1Sign;
        var x1___2 = _2;
      } else {
        var _2$1 = $p_Ljava_math_Elementary$__subtract__AI__I__AI__I__AI(this, $n(op2).Ljava_math_BigInteger__f_digits, op2Len, $n(op1).Ljava_math_BigInteger__f_digits, op1Len);
        var x1___1 = op2Sign;
        var x1___2 = _2$1;
      }
    }
    var resSign = $uI(x1___1);
    var resDigits = $asArrayOf_I(x1___2, 1);
    var res$3 = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), resSign, $n(resDigits).u.length, resDigits);
    res$3.cutOffLeadingZeroes__V();
    return res$3;
  }
});
$c_Ljava_math_Elementary$.prototype.compareArrays__AI__AI__I__I = (function(a, b, size) {
  var i = ((size - 1) | 0);
  while (((i >= 0) && ($n(a).get(i) === $n(b).get(i)))) {
    i = ((i - 1) | 0);
  }
  if ((i < 0)) {
    return 0;
  } else {
    var value = $n(a).get(i);
    var value$1 = $n(b).get(i);
    if (((value >>> 0) < (value$1 >>> 0))) {
      return (-1);
    } else {
      return 1;
    }
  }
});
$c_Ljava_math_Elementary$.prototype.subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(op1, op2) {
  var op1Sign = $n(op1).Ljava_math_BigInteger__f_sign;
  var op2Sign = $n(op2).Ljava_math_BigInteger__f_sign;
  var op1Len = $n(op1).Ljava_math_BigInteger__f_numberLength;
  var op2Len = $n(op2).Ljava_math_BigInteger__f_numberLength;
  if ((op2Sign === 0)) {
    return op1;
  } else if ((op1Sign === 0)) {
    return $n(op2).negate__Ljava_math_BigInteger();
  } else if ((((op1Len + op2Len) | 0) === 2)) {
    var value = $n($n(op1).Ljava_math_BigInteger__f_digits).get(0);
    var a_$_lo = value;
    var a_$_hi = 0;
    var value$1 = $n($n(op2).Ljava_math_BigInteger__f_digits).get(0);
    var b_$_lo = value$1;
    var b_$_hi = 0;
    if ((op1Sign < 0)) {
      var x_$_lo = a_$_lo;
      var x_$_hi = a_$_hi;
      var lo = ((-x_$_lo) | 0);
      var hi$2 = ((((-x_$_hi) | 0) - ((lo !== 0) | 0)) | 0);
      a_$_lo = lo;
      a_$_hi = hi$2;
    }
    if ((op2Sign < 0)) {
      var x$1_$_lo = b_$_lo;
      var x$1_$_hi = b_$_hi;
      var lo$1 = ((-x$1_$_lo) | 0);
      var hi$3 = ((((-x$1_$_hi) | 0) - ((lo$1 !== 0) | 0)) | 0);
      b_$_lo = lo$1;
      b_$_hi = hi$3;
    }
    var $x_1 = $m_Ljava_math_BigInteger$();
    var x$2_$_lo = a_$_lo;
    var x$2_$_hi = a_$_hi;
    var x$3_$_lo = b_$_lo;
    var x$3_$_hi = b_$_hi;
    var lo$2 = ((x$2_$_lo - x$3_$_lo) | 0);
    var hi$4 = ((((x$2_$_hi - x$3_$_hi) | 0) - (((lo$2 >>> 0) > (x$2_$_lo >>> 0)) | 0)) | 0);
    return $x_1.valueOf__J__Ljava_math_BigInteger(lo$2, hi$4);
  } else {
    var cmp = ((op1Len !== op2Len) ? ((op1Len > op2Len) ? 1 : (-1)) : $m_Ljava_math_Elementary$().compareArrays__AI__AI__I__I($n(op1).Ljava_math_BigInteger__f_digits, $n(op2).Ljava_math_BigInteger__f_digits, op1Len));
    if ((((op1Sign ^ op2Sign) | cmp) === 0)) {
      return $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO;
    }
    if ((cmp === (-1))) {
      var res = ((op1Sign === op2Sign) ? $p_Ljava_math_Elementary$__subtract__AI__I__AI__I__AI(this, $n(op2).Ljava_math_BigInteger__f_digits, op2Len, $n(op1).Ljava_math_BigInteger__f_digits, op1Len) : $p_Ljava_math_Elementary$__add__AI__I__AI__I__AI(this, $n(op2).Ljava_math_BigInteger__f_digits, op2Len, $n(op1).Ljava_math_BigInteger__f_digits, op1Len));
      var _1 = ((-op2Sign) | 0);
      var x1___1 = _1;
      var x1___2 = res;
    } else if ((op1Sign === op2Sign)) {
      var _2 = $p_Ljava_math_Elementary$__subtract__AI__I__AI__I__AI(this, $n(op1).Ljava_math_BigInteger__f_digits, op1Len, $n(op2).Ljava_math_BigInteger__f_digits, op2Len);
      var x1___1 = op1Sign;
      var x1___2 = _2;
    } else {
      var _2$1 = $p_Ljava_math_Elementary$__add__AI__I__AI__I__AI(this, $n(op1).Ljava_math_BigInteger__f_digits, op1Len, $n(op2).Ljava_math_BigInteger__f_digits, op2Len);
      var x1___1 = op1Sign;
      var x1___2 = _2$1;
    }
    var resSign = $uI(x1___1);
    var resDigits = $asArrayOf_I(x1___2, 1);
    var res$2 = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), resSign, $n(resDigits).u.length, resDigits);
    res$2.cutOffLeadingZeroes__V();
    return res$2;
  }
});
var $d_Ljava_math_Elementary$ = new $TypeData().initClass($c_Ljava_math_Elementary$, "java.math.Elementary$", ({
  Ljava_math_Elementary$: 1
}));
var $n_Ljava_math_Elementary$;
function $m_Ljava_math_Elementary$() {
  if ((!$n_Ljava_math_Elementary$)) {
    $n_Ljava_math_Elementary$ = new $c_Ljava_math_Elementary$();
  }
  return $n_Ljava_math_Elementary$;
}
function $p_Ljava_math_Multiplication$__initialiseArrays__V($thiz) {
  var elem_$_lo = 0;
  var elem_$_hi = 0;
  elem_$_lo = 1;
  elem_$_hi = 0;
  var i = 0;
  while ((i < 32)) {
    var value = i;
    if ((value <= 18)) {
      $n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigFivePows).set(value, $m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(elem_$_lo, elem_$_hi));
      var $x_2 = $n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigTenPows);
      var $x_1 = $m_Ljava_math_BigInteger$();
      var x_$_lo = elem_$_lo;
      var x_$_hi = elem_$_hi;
      var lo = (((32 & value) === 0) ? (x_$_lo << value) : 0);
      var hi = (((32 & value) === 0) ? (((((x_$_lo >>> 1) | 0) >>> (~value)) | 0) | (x_$_hi << value)) : (x_$_lo << value));
      $x_2.set(value, $x_1.valueOf__J__Ljava_math_BigInteger(lo, hi));
      var x$1_$_lo = elem_$_lo;
      var x$1_$_hi = elem_$_hi;
      var b0 = (65535 & x$1_$_lo);
      var b1 = ((x$1_$_lo >>> 16) | 0);
      var a0b0 = Math.imul(5, b0);
      var a0b1 = Math.imul(5, b1);
      var lo$1 = ((a0b0 + (a0b1 << 16)) | 0);
      var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
      var hi$1 = ((Math.imul(5, x$1_$_hi) + ((c1part >>> 16) | 0)) | 0);
      elem_$_lo = lo$1;
      elem_$_hi = hi$1;
    } else {
      $n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigFivePows).set(value, $n($n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigFivePows).get(((value - 1) | 0))).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigFivePows).get(1)));
      $n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigTenPows).set(value, $n($n($m_Ljava_math_Multiplication$().Ljava_math_Multiplication$__f_BigTenPows).get(((value - 1) | 0))).multiply__Ljava_math_BigInteger__Ljava_math_BigInteger($m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_TEN));
    }
    i = ((1 + i) | 0);
  }
}
function $p_Ljava_math_Multiplication$__multiplyByInt__AI__AI__I__I__I($thiz, res, a, aSize, factor) {
  var elem = 0;
  elem = 0;
  var i = 0;
  while ((i < aSize)) {
    var value = i;
    $m_Ljava_math_Multiplication$();
    var a$1 = $n(a).get(value);
    var c = elem;
    var a0 = (65535 & a$1);
    var a1 = ((a$1 >>> 16) | 0);
    var b0 = (65535 & factor);
    var b1 = ((factor >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$2 = ((((Math.imul(a1, b1) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$1 = ((lo + c) | 0);
    var hi$4 = ((hi$2 + (((lo$1 >>> 0) < (lo >>> 0)) | 0)) | 0);
    $n(res).set(value, lo$1);
    elem = hi$4;
    i = ((1 + i) | 0);
  }
  return elem;
}
function $p_Ljava_math_Multiplication$__multPAP__AI__AI__AI__I__I__V($thiz, a, b, t, aLen, bLen) {
  if (((a === b) && (aLen === bLen))) {
    $thiz.square__AI__I__AI__AI(a, aLen, t);
  } else {
    var i = 0;
    while ((i < aLen)) {
      var value = i;
      var elem = 0;
      elem = 0;
      var aI = $n(a).get(value);
      var i$1 = 0;
      while ((i$1 < bLen)) {
        var value$1 = i$1;
        $m_Ljava_math_Multiplication$();
        var b$1 = $n(b).get(value$1);
        var c = $n(t).get(((value + value$1) | 0));
        var d = elem;
        var a0 = (65535 & aI);
        var a1 = ((aI >>> 16) | 0);
        var b0 = (65535 & b$1);
        var b1 = ((b$1 >>> 16) | 0);
        var a0b0 = Math.imul(a0, b0);
        var a1b0 = Math.imul(a1, b0);
        var a0b1 = Math.imul(a0, b1);
        var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
        var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
        var hi$2 = ((((Math.imul(a1, b1) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
        var lo$1 = ((lo + c) | 0);
        var hi$4 = ((hi$2 + (((lo$1 >>> 0) < (lo >>> 0)) | 0)) | 0);
        var lo$2 = ((lo$1 + d) | 0);
        var hi$6 = ((hi$4 + (((lo$2 >>> 0) < (lo$1 >>> 0)) | 0)) | 0);
        $n(t).set(((value + value$1) | 0), lo$2);
        elem = hi$6;
        i$1 = ((1 + i$1) | 0);
      }
      $n(t).set(((value + bLen) | 0), elem);
      i = ((1 + i) | 0);
    }
  }
}
function $p_Ljava_math_Multiplication$__newArrayOfPows__I__I__AI($thiz, len, pow) {
  var result = new $ac_I(len);
  result.set(0, 1);
  var i = 1;
  while ((i < len)) {
    var value = i;
    result.set(value, Math.imul(result.get(((value - 1) | 0)), pow));
    i = ((1 + i) | 0);
  }
  return result;
}
/** @constructor */
function $c_Ljava_math_Multiplication$() {
  this.Ljava_math_Multiplication$__f_BigTenPows = null;
  this.Ljava_math_Multiplication$__f_BigFivePows = null;
  $n_Ljava_math_Multiplication$ = this;
  $p_Ljava_math_Multiplication$__newArrayOfPows__I__I__AI(this, 10, 10);
  $p_Ljava_math_Multiplication$__newArrayOfPows__I__I__AI(this, 14, 5);
  this.Ljava_math_Multiplication$__f_BigTenPows = new ($d_Ljava_math_BigInteger.getArrayOf().constr)(32);
  this.Ljava_math_Multiplication$__f_BigFivePows = new ($d_Ljava_math_BigInteger.getArrayOf().constr)(32);
  $p_Ljava_math_Multiplication$__initialiseArrays__V(this);
}
$c_Ljava_math_Multiplication$.prototype = new $h_O();
$c_Ljava_math_Multiplication$.prototype.constructor = $c_Ljava_math_Multiplication$;
/** @constructor */
function $h_Ljava_math_Multiplication$() {
}
$h_Ljava_math_Multiplication$.prototype = $c_Ljava_math_Multiplication$.prototype;
$c_Ljava_math_Multiplication$.prototype.square__AI__I__AI__AI = (function(a, aLen, res) {
  var elem = 0;
  elem = 0;
  var i = 0;
  while ((i < aLen)) {
    var value = i;
    elem = 0;
    var _\uff3fself = ((1 + value) | 0);
    var i$1 = _\uff3fself;
    while ((i$1 < aLen)) {
      var value$1 = i$1;
      $m_Ljava_math_Multiplication$();
      var a$1 = $n(a).get(value);
      var b = $n(a).get(value$1);
      var c = $n(res).get(((value + value$1) | 0));
      var d = elem;
      var a0 = (65535 & a$1);
      var a1 = ((a$1 >>> 16) | 0);
      var b0 = (65535 & b);
      var b1 = ((b >>> 16) | 0);
      var a0b0 = Math.imul(a0, b0);
      var a1b0 = Math.imul(a1, b0);
      var a0b1 = Math.imul(a0, b1);
      var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
      var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
      var hi$2 = ((((Math.imul(a1, b1) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
      var lo$1 = ((lo + c) | 0);
      var hi$4 = ((hi$2 + (((lo$1 >>> 0) < (lo >>> 0)) | 0)) | 0);
      var lo$2 = ((lo$1 + d) | 0);
      var hi$6 = ((hi$4 + (((lo$2 >>> 0) < (lo$1 >>> 0)) | 0)) | 0);
      $n(res).set(((value + value$1) | 0), lo$2);
      elem = hi$6;
      i$1 = ((1 + i$1) | 0);
    }
    $n(res).set(((value + aLen) | 0), elem);
    i = ((1 + i) | 0);
  }
  $m_Ljava_math_BitLevel$().shiftLeftOneBit__AI__AI__I__V(res, res, (aLen << 1));
  elem = 0;
  var i$2 = 0;
  var index = 0;
  while ((i$2 < aLen)) {
    var a$2 = $n(a).get(i$2);
    var b$1 = $n(a).get(i$2);
    var c$1 = $n(res).get(index);
    var d$1 = elem;
    var a0$1 = (65535 & a$2);
    var a1$1 = ((a$2 >>> 16) | 0);
    var b0$1 = (65535 & b$1);
    var b1$1 = ((b$1 >>> 16) | 0);
    var a0b0$1 = Math.imul(a0$1, b0$1);
    var a1b0$1 = Math.imul(a1$1, b0$1);
    var a0b1$1 = Math.imul(a0$1, b1$1);
    var lo$3 = ((a0b0$1 + (((a1b0$1 + a0b1$1) | 0) << 16)) | 0);
    var c1part$1 = ((((a0b0$1 >>> 16) | 0) + a0b1$1) | 0);
    var hi$9 = ((((Math.imul(a1$1, b1$1) + ((c1part$1 >>> 16) | 0)) | 0) + (((((65535 & c1part$1) + a1b0$1) | 0) >>> 16) | 0)) | 0);
    var lo$4 = ((lo$3 + c$1) | 0);
    var hi$11 = ((hi$9 + (((lo$4 >>> 0) < (lo$3 >>> 0)) | 0)) | 0);
    var lo$5 = ((lo$4 + d$1) | 0);
    var hi$13 = ((hi$11 + (((lo$5 >>> 0) < (lo$4 >>> 0)) | 0)) | 0);
    $n(res).set(index, lo$5);
    index = ((1 + index) | 0);
    var value$2 = $n(res).get(index);
    var lo$6 = ((hi$13 + value$2) | 0);
    var hi$15 = (((lo$6 >>> 0) < (hi$13 >>> 0)) | 0);
    $n(res).set(index, lo$6);
    elem = hi$15;
    i$2 = ((1 + i$2) | 0);
    index = ((1 + index) | 0);
  }
  return res;
});
$c_Ljava_math_Multiplication$.prototype.karatsuba__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(val1, val2) {
  if (($n(val2).Ljava_math_BigInteger__f_numberLength > $n(val1).Ljava_math_BigInteger__f_numberLength)) {
    var x1___1 = val2;
    var x1___2 = val1;
  } else {
    var x1___1 = val1;
    var x1___2 = val2;
  }
  var op1 = $as_Ljava_math_BigInteger(x1___1);
  var op2 = $as_Ljava_math_BigInteger(x1___2);
  if (($n(op2).Ljava_math_BigInteger__f_numberLength < 63)) {
    return this.multiplyPAP__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(op1, op2);
  } else {
    var ndiv2 = (((-2) & $n(op1).Ljava_math_BigInteger__f_numberLength) << 4);
    var upperOp1 = $n(op1).shiftRight__I__Ljava_math_BigInteger(ndiv2);
    var upperOp2 = $n(op2).shiftRight__I__Ljava_math_BigInteger(ndiv2);
    var this$1 = $n(op1);
    var bi = $n(upperOp1).shiftLeft__I__Ljava_math_BigInteger(ndiv2);
    var lowerOp1 = $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$1, bi);
    var this$2 = $n(op2);
    var bi$1 = $n(upperOp2).shiftLeft__I__Ljava_math_BigInteger(ndiv2);
    var lowerOp2 = $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$2, bi$1);
    var upper = this.karatsuba__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(upperOp1, upperOp2);
    var lower = this.karatsuba__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(lowerOp1, lowerOp2);
    var this$3 = $n(upperOp1);
    var $x_1 = $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$3, lowerOp1);
    var this$4 = $n(lowerOp2);
    var middle = this.karatsuba__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger($x_1, $m_Ljava_math_Elementary$().subtract__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$4, upperOp2));
    var this$5 = $n(middle);
    var bi$2 = upper;
    var this$6 = $n($m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$5, bi$2));
    middle = $m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$6, lower);
    middle = $n(middle).shiftLeft__I__Ljava_math_BigInteger(ndiv2);
    upper = $n(upper).shiftLeft__I__Ljava_math_BigInteger((ndiv2 << 1));
    var this$7 = $n(upper);
    var bi$3 = middle;
    var this$8 = $n($m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$7, bi$3));
    return $m_Ljava_math_Elementary$().add__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this$8, lower);
  }
});
$c_Ljava_math_Multiplication$.prototype.multArraysPAP__AI__I__AI__I__AI__V = (function(aDigits, aLen, bDigits, bLen, resDigits) {
  if ((!((aLen === 0) || (bLen === 0)))) {
    if ((aLen === 1)) {
      $n(resDigits).set(bLen, $p_Ljava_math_Multiplication$__multiplyByInt__AI__AI__I__I__I(this, resDigits, bDigits, bLen, $n(aDigits).get(0)));
    } else if ((bLen === 1)) {
      $n(resDigits).set(aLen, $p_Ljava_math_Multiplication$__multiplyByInt__AI__AI__I__I__I(this, resDigits, aDigits, aLen, $n(bDigits).get(0)));
    } else {
      $p_Ljava_math_Multiplication$__multPAP__AI__AI__AI__I__I__V(this, aDigits, bDigits, resDigits, aLen, bLen);
    }
  }
});
$c_Ljava_math_Multiplication$.prototype.multiplyPAP__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(a, b) {
  var aLen = $n(a).Ljava_math_BigInteger__f_numberLength;
  var bLen = $n(b).Ljava_math_BigInteger__f_numberLength;
  var resLength = ((aLen + bLen) | 0);
  var resSign = (($n(a).Ljava_math_BigInteger__f_sign !== $n(b).Ljava_math_BigInteger__f_sign) ? (-1) : 1);
  if ((resLength === 2)) {
    var a$1 = $n($n(a).Ljava_math_BigInteger__f_digits).get(0);
    var b$1 = $n($n(b).Ljava_math_BigInteger__f_digits).get(0);
    var a0 = (65535 & a$1);
    var a1 = ((a$1 >>> 16) | 0);
    var b0 = (65535 & b$1);
    var b1 = ((b$1 >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$2 = ((((Math.imul(a1, b1) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    return ((hi$2 === 0) ? $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), resSign, lo) : $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), resSign, 2, new $ac_I(new Int32Array([lo, hi$2]))));
  } else {
    var aDigits = $n(a).Ljava_math_BigInteger__f_digits;
    var bDigits = $n(b).Ljava_math_BigInteger__f_digits;
    var resDigits = new $ac_I(resLength);
    this.multArraysPAP__AI__I__AI__I__AI__V(aDigits, aLen, bDigits, bLen, resDigits);
    var result = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), resSign, resLength, resDigits);
    result.cutOffLeadingZeroes__V();
    return result;
  }
});
var $d_Ljava_math_Multiplication$ = new $TypeData().initClass($c_Ljava_math_Multiplication$, "java.math.Multiplication$", ({
  Ljava_math_Multiplication$: 1
}));
var $n_Ljava_math_Multiplication$;
function $m_Ljava_math_Multiplication$() {
  if ((!$n_Ljava_math_Multiplication$)) {
    $n_Ljava_math_Multiplication$ = new $c_Ljava_math_Multiplication$();
  }
  return $n_Ljava_math_Multiplication$;
}
function $s_RTLong__remainderUnsigned__I__I__I__I__J(alo, ahi, blo, bhi) {
  var this$1 = $m_RTLong$();
  return this$1.remainderUnsignedImpl__I__I__I__I__J(alo, ahi, blo, bhi);
}
function $s_RTLong__remainder__I__I__I__I__J(alo, ahi, blo, bhi) {
  return $m_RTLong$().remainder__I__I__I__I__J(alo, ahi, blo, bhi);
}
function $s_RTLong__divideUnsigned__I__I__I__I__J(alo, ahi, blo, bhi) {
  var this$1 = $m_RTLong$();
  return this$1.divideUnsignedImpl__I__I__I__I__J(alo, ahi, blo, bhi);
}
function $s_RTLong__divide__I__I__I__I__J(alo, ahi, blo, bhi) {
  return $m_RTLong$().divide__I__I__I__I__J(alo, ahi, blo, bhi);
}
function $s_RTLong__fromDoubleBits__D__O__J(value, fpBitsDataView) {
  fpBitsDataView.setFloat64(0, value, true);
  var lo = $uI(fpBitsDataView.getInt32(0, true));
  var hi = $uI(fpBitsDataView.getInt32(4, true));
  return $bL(lo, hi);
}
function $s_RTLong__fromDouble__D__J(value) {
  return $m_RTLong$().fromDouble__D__J(value);
}
function $s_RTLong__fromUnsignedInt__I__J(value) {
  return $bL(value, 0);
}
function $s_RTLong__fromInt__I__J(value) {
  var hi = (value >> 31);
  return $bL(value, hi);
}
function $s_RTLong__clz__I__I__I(lo, hi) {
  return ((hi !== 0) ? Math.clz32(hi) : ((32 + Math.clz32(lo)) | 0));
}
function $s_RTLong__toFloat__I__I__F(lo, hi) {
  var compressedLo = (((((-2097152) & (hi ^ (hi >> 10))) === 0) || ((65535 & lo) === 0)) ? lo : (32768 | ((-32768) & lo)));
  return Math.fround(((4.294967296E9 * hi) + (compressedLo >>> 0.0)));
}
function $s_RTLong__toDouble__I__I__D(lo, hi) {
  return ((4.294967296E9 * hi) + (lo >>> 0.0));
}
function $s_RTLong__toInt__I__I__I(lo, hi) {
  return lo;
}
function $s_RTLong__toString__I__I__T(lo, hi) {
  return $m_RTLong$().toString__I__I__T(lo, hi);
}
function $s_RTLong__bitsToDouble__I__I__O__D(lo, hi, fpBitsDataView) {
  fpBitsDataView.setInt32(0, lo, true);
  fpBitsDataView.setInt32(4, hi, true);
  return $uD(fpBitsDataView.getFloat64(0, true));
}
function $s_RTLong__mul__I__I__I__I__J(alo, ahi, blo, bhi) {
  var a0 = (65535 & alo);
  var a1 = ((alo >>> 16) | 0);
  var b0 = (65535 & blo);
  var b1 = ((blo >>> 16) | 0);
  var a0b0 = Math.imul(a0, b0);
  var a1b0 = Math.imul(a1, b0);
  var a0b1 = Math.imul(a0, b1);
  var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
  var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
  var hi = ((((((((Math.imul(alo, bhi) + Math.imul(ahi, blo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
  return $bL(lo, hi);
}
function $s_RTLong__sub__I__I__I__I__J(alo, ahi, blo, bhi) {
  var lo = ((alo - blo) | 0);
  var hi = ((((ahi - bhi) | 0) - (((lo >>> 0) > (alo >>> 0)) | 0)) | 0);
  return $bL(lo, hi);
}
function $s_RTLong__add__I__I__I__I__J(alo, ahi, blo, bhi) {
  var lo = ((alo + blo) | 0);
  var hi = ((((ahi + bhi) | 0) + (((lo >>> 0) < (alo >>> 0)) | 0)) | 0);
  return $bL(lo, hi);
}
function $s_RTLong__sar__I__I__I__J(lo, hi, n) {
  var lo$1 = (((32 & n) === 0) ? (((lo >>> n) | 0) | ((hi << 1) << (~n))) : (hi >> n));
  var hi$1 = (((32 & n) === 0) ? (hi >> n) : (hi >> 31));
  return $bL(lo$1, hi$1);
}
function $s_RTLong__shr__I__I__I__J(lo, hi, n) {
  var lo$1 = (((32 & n) === 0) ? (((lo >>> n) | 0) | ((hi << 1) << (~n))) : ((hi >>> n) | 0));
  var hi$1 = (((32 & n) === 0) ? ((hi >>> n) | 0) : 0);
  return $bL(lo$1, hi$1);
}
function $s_RTLong__shl__I__I__I__J(lo, hi, n) {
  var lo$1 = (((32 & n) === 0) ? (lo << n) : 0);
  var hi$1 = (((32 & n) === 0) ? (((((lo >>> 1) | 0) >>> (~n)) | 0) | (hi << n)) : (lo << n));
  return $bL(lo$1, hi$1);
}
function $s_RTLong__xor__I__I__I__I__J(alo, ahi, blo, bhi) {
  var lo = (alo ^ blo);
  var hi = (ahi ^ bhi);
  return $bL(lo, hi);
}
function $s_RTLong__and__I__I__I__I__J(alo, ahi, blo, bhi) {
  var lo = (alo & blo);
  var hi = (ahi & bhi);
  return $bL(lo, hi);
}
function $s_RTLong__or__I__I__I__I__J(alo, ahi, blo, bhi) {
  var lo = (alo | blo);
  var hi = (ahi | bhi);
  return $bL(lo, hi);
}
function $s_RTLong__geu__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) >= (blo >>> 0)) : ((ahi >>> 0) > (bhi >>> 0)));
}
function $s_RTLong__gtu__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) > (blo >>> 0)) : ((ahi >>> 0) > (bhi >>> 0)));
}
function $s_RTLong__leu__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) <= (blo >>> 0)) : ((ahi >>> 0) < (bhi >>> 0)));
}
function $s_RTLong__ltu__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) < (blo >>> 0)) : ((ahi >>> 0) < (bhi >>> 0)));
}
function $s_RTLong__ge__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) >= (blo >>> 0)) : (ahi > bhi));
}
function $s_RTLong__gt__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) > (blo >>> 0)) : (ahi > bhi));
}
function $s_RTLong__le__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) <= (blo >>> 0)) : (ahi < bhi));
}
function $s_RTLong__lt__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return ((ahi === bhi) ? ((alo >>> 0) < (blo >>> 0)) : (ahi < bhi));
}
function $s_RTLong__notEquals__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return (((alo ^ blo) | (ahi ^ bhi)) !== 0);
}
function $s_RTLong__equals__I__I__I__I__Z(alo, ahi, blo, bhi) {
  return (((alo ^ blo) | (ahi ^ bhi)) === 0);
}
/** @constructor */
function $c_RTLong$() {
}
$c_RTLong$.prototype = new $h_O();
$c_RTLong$.prototype.constructor = $c_RTLong$;
/** @constructor */
function $h_RTLong$() {
}
$h_RTLong$.prototype = $c_RTLong$.prototype;
$c_RTLong$.prototype.toString__I__I__T = (function(lo, hi) {
  if ((hi === (lo >> 31))) {
    return ("" + lo);
  } else if ((((-2097152) & (hi ^ (hi >> 10))) === 0)) {
    var this$2 = ((4.294967296E9 * hi) + (lo >>> 0.0));
    return ("" + this$2);
  } else {
    var sign = (hi >> 31);
    var xlo = (lo ^ sign);
    var rlo = ((xlo - sign) | 0);
    var rhi = (((hi ^ sign) + (((rlo >>> 0) < (xlo >>> 0)) | 0)) | 0);
    var aHat = ((4.294967296E9 * (rhi >>> 0.0)) + (rlo >>> 0.0));
    var qHat = $uD(Math.floor((1.0000000000000265E-9 * aHat)));
    var x = qHat;
    var rHat = ((rlo - Math.imul(1000000000, (x | 0.0))) | 0);
    if ((rHat < 0)) {
      qHat = (qHat - 1.0);
      rHat = ((1000000000 + rHat) | 0);
    }
    var this$7 = rHat;
    var remStr = ("" + this$7);
    var this$9 = qHat;
    var start = remStr.length;
    var s = ((("" + this$9) + $as_T("000000000".substring(start))) + remStr);
    return ((hi < 0) ? ("-" + s) : s);
  }
});
$c_RTLong$.prototype.fromDouble__D__J = (function(value) {
  if ((value < (-9.223372036854776E18))) {
    return $bL(0, (-2147483648));
  } else if ((value >= 9.223372036854776E18)) {
    return $bL((-1), 2147483647);
  } else {
    var rawLo = (value | 0.0);
    var x = (2.3283064365386963E-10 * value);
    var rawHi = (x | 0.0);
    var hi = (((value < 0.0) && (rawLo !== 0)) ? ((rawHi - 1) | 0) : rawHi);
    return $bL(rawLo, hi);
  }
});
$c_RTLong$.prototype.divide__I__I__I__I__J = (function(alo, ahi, blo, bhi) {
  var sign = (ahi >> 31);
  var xlo = (alo ^ sign);
  var rlo = ((xlo - sign) | 0);
  var rhi = (((ahi ^ sign) + (((rlo >>> 0) < (xlo >>> 0)) | 0)) | 0);
  var sign$1 = (bhi >> 31);
  var xlo$1 = (blo ^ sign$1);
  var rlo$1 = ((xlo$1 - sign$1) | 0);
  var rhi$1 = (((bhi ^ sign$1) + (((rlo$1 >>> 0) < (xlo$1 >>> 0)) | 0)) | 0);
  var b = ((-2097152) & rlo$1);
  if (((rhi$1 | b) === 0)) {
    var quotHi = (((rhi >>> 0) / ($checkIntDivisor(rlo$1) >>> 0)) | 0);
    var k = ((rhi - Math.imul(rlo$1, quotHi)) | 0);
    var x = (((4.294967296E9 * k) + (rlo >>> 0.0)) / rlo$1);
    var quotLo = (x | 0.0);
    var absR_$_lo = quotLo;
    var absR_$_hi = quotHi;
  } else {
    var aHat = ((4.294967296E9 * (rhi >>> 0.0)) + (rlo >>> 0.0));
    var bHat = ((4.294967296E9 * (rhi$1 >>> 0.0)) + (rlo$1 >>> 0.0));
    var x$1 = ((aHat / bHat) + 0.00390625);
    var lo = (x$1 | 0.0);
    var x$2 = (2.3283064365386963E-10 * x$1);
    var hi = (x$2 | 0.0);
    var a0 = (65535 & rlo$1);
    var a1 = ((rlo$1 >>> 16) | 0);
    var b0 = (65535 & lo);
    var b1 = ((lo >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo$1 = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$1 = ((((((((Math.imul(rlo$1, hi) + Math.imul(rhi$1, lo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$2 = ((rlo - lo$1) | 0);
    var hi$2 = ((((rhi - hi$1) | 0) - (((lo$2 >>> 0) > (rlo >>> 0)) | 0)) | 0);
    if ((hi$2 < 0)) {
      var lo$3 = ((lo - 1) | 0);
      var hi$3 = ((((hi - 1) | 0) + ((lo$3 !== (-1)) | 0)) | 0);
      var absR_$_lo = lo$3;
      var absR_$_hi = hi$3;
    } else {
      var absR_$_lo = lo;
      var absR_$_hi = hi;
    }
  }
  if (((ahi ^ bhi) >= 0)) {
    return $bL(absR_$_lo, absR_$_hi);
  } else {
    var lo$4 = ((-absR_$_lo) | 0);
    var hi$4 = ((((-absR_$_hi) | 0) - ((lo$4 !== 0) | 0)) | 0);
    return $bL(lo$4, hi$4);
  }
});
$c_RTLong$.prototype.divideUnsignedImpl__I__I__I__I__J = (function(alo, ahi, blo, bhi) {
  var b = ((-2097152) & blo);
  if (((bhi | b) === 0)) {
    var quotHi = (((ahi >>> 0) / ($checkIntDivisor(blo) >>> 0)) | 0);
    var k = ((ahi - Math.imul(blo, quotHi)) | 0);
    var x = (((4.294967296E9 * k) + (alo >>> 0.0)) / blo);
    var quotLo = (x | 0.0);
    return $bL(quotLo, quotHi);
  } else if ((bhi >= 0)) {
    var aHat = ((4.294967296E9 * (ahi >>> 0.0)) + (alo >>> 0.0));
    var bHat = ((4.294967296E9 * (bhi >>> 0.0)) + (blo >>> 0.0));
    var x$1 = ((aHat / bHat) + 0.00390625);
    var lo = (x$1 | 0.0);
    var x$2 = (2.3283064365386963E-10 * x$1);
    var hi = (x$2 | 0.0);
    var a0 = (65535 & blo);
    var a1 = ((blo >>> 16) | 0);
    var b0 = (65535 & lo);
    var b1 = ((lo >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo$1 = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$1 = ((((((((Math.imul(blo, hi) + Math.imul(bhi, lo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$2 = ((alo - lo$1) | 0);
    var hi$2 = ((((ahi - hi$1) | 0) - (((lo$2 >>> 0) > (alo >>> 0)) | 0)) | 0);
    if ((hi$2 < 0)) {
      var lo$3 = ((lo - 1) | 0);
      var hi$3 = ((((hi - 1) | 0) + ((lo$3 !== (-1)) | 0)) | 0);
      return $bL(lo$3, hi$3);
    } else {
      return $bL(lo, hi);
    }
  } else if (((ahi === bhi) ? ((alo >>> 0) < (blo >>> 0)) : ((ahi >>> 0) < (bhi >>> 0)))) {
    return $bL(0, 0);
  } else {
    return $bL(1, 0);
  }
});
$c_RTLong$.prototype.remainder__I__I__I__I__J = (function(alo, ahi, blo, bhi) {
  var sign = (ahi >> 31);
  var xlo = (alo ^ sign);
  var rlo = ((xlo - sign) | 0);
  var rhi = (((ahi ^ sign) + (((rlo >>> 0) < (xlo >>> 0)) | 0)) | 0);
  var sign$1 = (bhi >> 31);
  var xlo$1 = (blo ^ sign$1);
  var rlo$1 = ((xlo$1 - sign$1) | 0);
  var rhi$1 = (((bhi ^ sign$1) + (((rlo$1 >>> 0) < (xlo$1 >>> 0)) | 0)) | 0);
  var b = ((-2097152) & rlo$1);
  if (((rhi$1 | b) === 0)) {
    var k$2 = (((rhi >>> 0) % ($checkIntDivisor(rlo$1) >>> 0)) | 0);
    var x = (((4.294967296E9 * k$2) + (rlo >>> 0.0)) / rlo$1);
    var quotLo$2 = (x | 0.0);
    var remLo = ((rlo - Math.imul(rlo$1, quotLo$2)) | 0);
    var absR_$_lo = remLo;
    var absR_$_hi = 0;
  } else {
    var aHat = ((4.294967296E9 * (rhi >>> 0.0)) + (rlo >>> 0.0));
    var bHat = ((4.294967296E9 * (rhi$1 >>> 0.0)) + (rlo$1 >>> 0.0));
    var x$1 = ((aHat / bHat) + 0.00390625);
    var lo = (x$1 | 0.0);
    var x$2 = (2.3283064365386963E-10 * x$1);
    var hi = (x$2 | 0.0);
    var a0 = (65535 & rlo$1);
    var a1 = ((rlo$1 >>> 16) | 0);
    var b0 = (65535 & lo);
    var b1 = ((lo >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo$1 = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$1 = ((((((((Math.imul(rlo$1, hi) + Math.imul(rhi$1, lo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$2 = ((rlo - lo$1) | 0);
    var hi$2 = ((((rhi - hi$1) | 0) - (((lo$2 >>> 0) > (rlo >>> 0)) | 0)) | 0);
    if ((hi$2 < 0)) {
      var lo$3 = ((lo$2 + rlo$1) | 0);
      var hi$3 = ((((hi$2 + rhi$1) | 0) + (((lo$3 >>> 0) < (lo$2 >>> 0)) | 0)) | 0);
      var absR_$_lo = lo$3;
      var absR_$_hi = hi$3;
    } else {
      var absR_$_lo = lo$2;
      var absR_$_hi = hi$2;
    }
  }
  if ((ahi < 0)) {
    var lo$4 = ((-absR_$_lo) | 0);
    var hi$4 = ((((-absR_$_hi) | 0) - ((lo$4 !== 0) | 0)) | 0);
    return $bL(lo$4, hi$4);
  } else {
    return $bL(absR_$_lo, absR_$_hi);
  }
});
$c_RTLong$.prototype.remainderUnsignedImpl__I__I__I__I__J = (function(alo, ahi, blo, bhi) {
  var b = ((-2097152) & blo);
  if (((bhi | b) === 0)) {
    var k$2 = (((ahi >>> 0) % ($checkIntDivisor(blo) >>> 0)) | 0);
    var x = (((4.294967296E9 * k$2) + (alo >>> 0.0)) / blo);
    var quotLo$2 = (x | 0.0);
    var remLo = ((alo - Math.imul(blo, quotLo$2)) | 0);
    return $bL(remLo, 0);
  } else if ((bhi >= 0)) {
    var aHat = ((4.294967296E9 * (ahi >>> 0.0)) + (alo >>> 0.0));
    var bHat = ((4.294967296E9 * (bhi >>> 0.0)) + (blo >>> 0.0));
    var x$1 = ((aHat / bHat) + 0.00390625);
    var lo = (x$1 | 0.0);
    var x$2 = (2.3283064365386963E-10 * x$1);
    var hi = (x$2 | 0.0);
    var a0 = (65535 & blo);
    var a1 = ((blo >>> 16) | 0);
    var b0 = (65535 & lo);
    var b1 = ((lo >>> 16) | 0);
    var a0b0 = Math.imul(a0, b0);
    var a1b0 = Math.imul(a1, b0);
    var a0b1 = Math.imul(a0, b1);
    var lo$1 = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
    var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
    var hi$1 = ((((((((Math.imul(blo, hi) + Math.imul(bhi, lo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
    var lo$2 = ((alo - lo$1) | 0);
    var hi$2 = ((((ahi - hi$1) | 0) - (((lo$2 >>> 0) > (alo >>> 0)) | 0)) | 0);
    if ((hi$2 < 0)) {
      var lo$3 = ((lo$2 + blo) | 0);
      var hi$3 = ((((hi$2 + bhi) | 0) + (((lo$3 >>> 0) < (lo$2 >>> 0)) | 0)) | 0);
      return $bL(lo$3, hi$3);
    } else {
      return $bL(lo$2, hi$2);
    }
  } else if (((ahi === bhi) ? ((alo >>> 0) < (blo >>> 0)) : ((ahi >>> 0) < (bhi >>> 0)))) {
    return $bL(alo, ahi);
  } else {
    var lo$4 = ((alo - blo) | 0);
    var hi$4 = ((((ahi - bhi) | 0) - (((lo$4 >>> 0) > (alo >>> 0)) | 0)) | 0);
    return $bL(lo$4, hi$4);
  }
});
var $d_RTLong$ = new $TypeData().initClass($c_RTLong$, "org.scalajs.linker.runtime.RuntimeLong$", ({
  RTLong$: 1
}));
var $n_RTLong$;
function $m_RTLong$() {
  if ((!$n_RTLong$)) {
    $n_RTLong$ = new $c_RTLong$();
  }
  return $n_RTLong$;
}
/** @constructor */
function $c_s_util_DynamicVariable(init) {
  this.s_util_DynamicVariable__f_v = null;
  this.s_util_DynamicVariable__f_v = init;
}
$c_s_util_DynamicVariable.prototype = new $h_O();
$c_s_util_DynamicVariable.prototype.constructor = $c_s_util_DynamicVariable;
/** @constructor */
function $h_s_util_DynamicVariable() {
}
$h_s_util_DynamicVariable.prototype = $c_s_util_DynamicVariable.prototype;
$c_s_util_DynamicVariable.prototype.toString__T = (function() {
  return (("DynamicVariable(" + this.s_util_DynamicVariable__f_v) + ")");
});
var $d_s_util_DynamicVariable = new $TypeData().initClass($c_s_util_DynamicVariable, "scala.util.DynamicVariable", ({
  s_util_DynamicVariable: 1
}));
/** @constructor */
function $c_jl_Number() {
}
$c_jl_Number.prototype = new $h_O();
$c_jl_Number.prototype.constructor = $c_jl_Number;
/** @constructor */
function $h_jl_Number() {
}
$h_jl_Number.prototype = $c_jl_Number.prototype;
function $ct_jl_Throwable__T__jl_Throwable__Z__Z__($thiz, s, e, enableSuppression, writableStackTrace) {
  $thiz.jl_Throwable__f_s = s;
  if (writableStackTrace) {
    $thiz.fillInStackTrace__jl_Throwable();
  }
  return $thiz;
}
class $c_jl_Throwable extends Error {
  constructor() {
    super();
    this.jl_Throwable__f_s = null;
  }
  getMessage__T() {
    return this.jl_Throwable__f_s;
  }
  fillInStackTrace__jl_Throwable() {
    var reference = (false ? this.sjs_js_JavaScriptException__f_exception : this);
    var identifyingString = Object.prototype.toString.call(reference);
    if ((identifyingString !== "[object Error]")) {
      if (((Error.captureStackTrace === (void 0)) || $uZ(Object.isSealed(this)))) {
        new Error();
      } else {
        Error.captureStackTrace(this);
      }
    }
    return this;
  }
  toString__T() {
    var className = $objectClassName(this);
    var message = this.getMessage__T();
    return ((message === null) ? className : ((className + ": ") + message));
  }
  hashCode__I() {
    return $c_O.prototype.hashCode__I.call(this);
  }
  get "message"() {
    var m = this.getMessage__T();
    return ((m === null) ? "" : m);
  }
  get "name"() {
    return $objectClassName(this);
  }
  "toString"() {
    return this.toString__T();
  }
}
/** @constructor */
function $c_Ljava_math_BigInteger$() {
  this.Ljava_math_BigInteger$__f_ONE = null;
  this.Ljava_math_BigInteger$__f_TEN = null;
  this.Ljava_math_BigInteger$__f_ZERO = null;
  this.Ljava_math_BigInteger$__f_MINUS_ONE = null;
  this.Ljava_math_BigInteger$__f_SMALL_VALUES = null;
  $n_Ljava_math_BigInteger$ = this;
  this.Ljava_math_BigInteger$__f_ONE = $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 1);
  this.Ljava_math_BigInteger$__f_TEN = $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 10);
  this.Ljava_math_BigInteger$__f_ZERO = $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 0, 0);
  this.Ljava_math_BigInteger$__f_MINUS_ONE = $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), (-1), 1);
  this.Ljava_math_BigInteger$__f_SMALL_VALUES = new ($d_Ljava_math_BigInteger.getArrayOf().constr)([this.Ljava_math_BigInteger$__f_ZERO, this.Ljava_math_BigInteger$__f_ONE, $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 2), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 3), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 4), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 5), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 6), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 7), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 8), $ct_Ljava_math_BigInteger__I__I__(new $c_Ljava_math_BigInteger(), 1, 9), this.Ljava_math_BigInteger$__f_TEN]);
  var result = new ($d_Ljava_math_BigInteger.getArrayOf().constr)(32);
  var i = 0;
  while ((i < 32)) {
    var value = i;
    var $x_1 = $m_Ljava_math_BigInteger$();
    var lo = (((32 & value) === 0) ? (1 << value) : 0);
    var hi = (((32 & value) === 0) ? 0 : (1 << value));
    result.set(value, $x_1.valueOf__J__Ljava_math_BigInteger(lo, hi));
    i = ((1 + i) | 0);
  }
}
$c_Ljava_math_BigInteger$.prototype = new $h_O();
$c_Ljava_math_BigInteger$.prototype.constructor = $c_Ljava_math_BigInteger$;
/** @constructor */
function $h_Ljava_math_BigInteger$() {
}
$h_Ljava_math_BigInteger$.prototype = $c_Ljava_math_BigInteger$.prototype;
$c_Ljava_math_BigInteger$.prototype.valueOf__J__Ljava_math_BigInteger = (function(lVal_$_lo, lVal_$_hi) {
  if ((lVal_$_hi < 0)) {
    if ((((~lVal_$_lo) | (~lVal_$_hi)) !== 0)) {
      var lo = ((-lVal_$_lo) | 0);
      var hi = ((((-lVal_$_hi) | 0) - ((lo !== 0) | 0)) | 0);
      return $ct_Ljava_math_BigInteger__I__J__(new $c_Ljava_math_BigInteger(), (-1), lo, hi);
    } else {
      return this.Ljava_math_BigInteger$__f_MINUS_ONE;
    }
  } else {
    return (((lVal_$_hi === 0) ? ((lVal_$_lo >>> 0) <= 10) : (lVal_$_hi < 0)) ? $n(this.Ljava_math_BigInteger$__f_SMALL_VALUES).get(lVal_$_lo) : $ct_Ljava_math_BigInteger__I__J__(new $c_Ljava_math_BigInteger(), 1, lVal_$_lo, lVal_$_hi));
  }
});
$c_Ljava_math_BigInteger$.prototype.checkRangeBasedOnIntArrayLength__I__V = (function(byteLength) {
  if (((byteLength >>> 0) > 67108863)) {
    throw new $c_jl_ArithmeticException("BigInteger would overflow supported range");
  }
});
var $d_Ljava_math_BigInteger$ = new $TypeData().initClass($c_Ljava_math_BigInteger$, "java.math.BigInteger$", ({
  Ljava_math_BigInteger$: 1,
  Ljava_io_Serializable: 1
}));
var $n_Ljava_math_BigInteger$;
function $m_Ljava_math_BigInteger$() {
  if ((!$n_Ljava_math_BigInteger$)) {
    $n_Ljava_math_BigInteger$ = new $c_Ljava_math_BigInteger$();
  }
  return $n_Ljava_math_BigInteger$;
}
/** @constructor */
function $c_s_Console$() {
  this.s_Console$__f_outVar = null;
  $n_s_Console$ = this;
  this.s_Console$__f_outVar = new $c_s_util_DynamicVariable($m_jl_System$Streams$().jl_System$Streams$__f_out);
}
$c_s_Console$.prototype = new $h_O();
$c_s_Console$.prototype.constructor = $c_s_Console$;
/** @constructor */
function $h_s_Console$() {
}
$h_s_Console$.prototype = $c_s_Console$.prototype;
$c_s_Console$.prototype.out__Ljava_io_PrintStream = (function() {
  return $as_Ljava_io_PrintStream($n(this.s_Console$__f_outVar).s_util_DynamicVariable__f_v);
});
var $d_s_Console$ = new $TypeData().initClass($c_s_Console$, "scala.Console$", ({
  s_Console$: 1,
  s_io_AnsiColor: 1
}));
var $n_s_Console$;
function $m_s_Console$() {
  if ((!$n_s_Console$)) {
    $n_s_Console$ = new $c_s_Console$();
  }
  return $n_s_Console$;
}
class $c_jl_Error extends $c_jl_Throwable {
}
class $c_jl_Exception extends $c_jl_Throwable {
}
/** @constructor */
function $c_Ljava_io_OutputStream() {
}
$c_Ljava_io_OutputStream.prototype = new $h_O();
$c_Ljava_io_OutputStream.prototype.constructor = $c_Ljava_io_OutputStream;
/** @constructor */
function $h_Ljava_io_OutputStream() {
}
$h_Ljava_io_OutputStream.prototype = $c_Ljava_io_OutputStream.prototype;
function $f_jl_Boolean__hashCode__I($thiz) {
  return ($thiz ? 1231 : 1237);
}
function $f_jl_Boolean__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Boolean = new $TypeData().initClass(0, "java.lang.Boolean", ({
  jl_Boolean: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1
}), ((x) => ((typeof x) === "boolean")));
function $f_jl_Character__hashCode__I($thiz) {
  return $thiz;
}
function $f_jl_Character__toString__T($thiz) {
  return ("" + $cToS($thiz));
}
var $d_jl_Character = new $TypeData().initClass(0, "java.lang.Character", ({
  jl_Character: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1
}), ((x) => (x instanceof $Char)));
class $c_jl_RuntimeException extends $c_jl_Exception {
}
class $c_jl_VirtualMachineError extends $c_jl_Error {
}
function $ct_Ljava_math_BigInteger__($thiz) {
  $thiz.Ljava_math_BigInteger__f_java$math$BigInteger$$firstNonzeroDigit = (-2);
  $thiz.Ljava_math_BigInteger__f__hashCode = 0;
  return $thiz;
}
function $ct_Ljava_math_BigInteger__I__I__($thiz, sign, value) {
  $ct_Ljava_math_BigInteger__($thiz);
  $thiz.Ljava_math_BigInteger__f_sign = sign;
  $thiz.Ljava_math_BigInteger__f_numberLength = 1;
  $thiz.Ljava_math_BigInteger__f_digits = new $ac_I(new Int32Array([value]));
  return $thiz;
}
function $ct_Ljava_math_BigInteger__I__I__AI__($thiz, sign, numberLength, digits) {
  $ct_Ljava_math_BigInteger__($thiz);
  $thiz.Ljava_math_BigInteger__f_sign = sign;
  $thiz.Ljava_math_BigInteger__f_numberLength = numberLength;
  $thiz.Ljava_math_BigInteger__f_digits = digits;
  return $thiz;
}
function $ct_Ljava_math_BigInteger__I__J__($thiz, sign, lVal_$_lo, lVal_$_hi) {
  $ct_Ljava_math_BigInteger__($thiz);
  $thiz.Ljava_math_BigInteger__f_sign = sign;
  if ((lVal_$_hi === 0)) {
    $thiz.Ljava_math_BigInteger__f_numberLength = 1;
    $thiz.Ljava_math_BigInteger__f_digits = new $ac_I(new Int32Array([lVal_$_lo]));
  } else {
    $thiz.Ljava_math_BigInteger__f_numberLength = 2;
    $thiz.Ljava_math_BigInteger__f_digits = new $ac_I(new Int32Array([lVal_$_lo, lVal_$_hi]));
  }
  return $thiz;
}
/** @constructor */
function $c_Ljava_math_BigInteger() {
  this.Ljava_math_BigInteger__f_digits = null;
  this.Ljava_math_BigInteger__f_numberLength = 0;
  this.Ljava_math_BigInteger__f_sign = 0;
  this.Ljava_math_BigInteger__f_java$math$BigInteger$$firstNonzeroDigit = 0;
  this.Ljava_math_BigInteger__f__hashCode = 0;
}
$c_Ljava_math_BigInteger.prototype = new $h_jl_Number();
$c_Ljava_math_BigInteger.prototype.constructor = $c_Ljava_math_BigInteger;
/** @constructor */
function $h_Ljava_math_BigInteger() {
}
$h_Ljava_math_BigInteger.prototype = $c_Ljava_math_BigInteger.prototype;
$c_Ljava_math_BigInteger.prototype.compareTo__Ljava_math_BigInteger__I = (function(bi) {
  return ((this.Ljava_math_BigInteger__f_sign > $n(bi).Ljava_math_BigInteger__f_sign) ? 1 : ((this.Ljava_math_BigInteger__f_sign < $n(bi).Ljava_math_BigInteger__f_sign) ? (-1) : ((this.Ljava_math_BigInteger__f_numberLength > $n(bi).Ljava_math_BigInteger__f_numberLength) ? this.Ljava_math_BigInteger__f_sign : ((this.Ljava_math_BigInteger__f_numberLength < $n(bi).Ljava_math_BigInteger__f_numberLength) ? ((-$n(bi).Ljava_math_BigInteger__f_sign) | 0) : Math.imul(this.Ljava_math_BigInteger__f_sign, $m_Ljava_math_Elementary$().compareArrays__AI__AI__I__I(this.Ljava_math_BigInteger__f_digits, $n(bi).Ljava_math_BigInteger__f_digits, this.Ljava_math_BigInteger__f_numberLength))))));
});
$c_Ljava_math_BigInteger.prototype.divide__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(divisor) {
  if (($n(divisor).Ljava_math_BigInteger__f_sign === 0)) {
    throw new $c_jl_ArithmeticException("BigInteger divide by zero");
  }
  var divisorSign = $n(divisor).Ljava_math_BigInteger__f_sign;
  if ($n(divisor).isOne__Z()) {
    return (($n(divisor).Ljava_math_BigInteger__f_sign > 0) ? this : this.negate__Ljava_math_BigInteger());
  } else {
    var thisSign = this.Ljava_math_BigInteger__f_sign;
    var thisLen = this.Ljava_math_BigInteger__f_numberLength;
    var divisorLen = $n(divisor).Ljava_math_BigInteger__f_numberLength;
    if ((((thisLen + divisorLen) | 0) === 2)) {
      var dividend = $n(this.Ljava_math_BigInteger__f_digits).get(0);
      var divisor$1 = $n($n(divisor).Ljava_math_BigInteger__f_digits).get(0);
      var x = (((dividend >>> 0) / ($checkIntDivisor(divisor$1) >>> 0)) | 0);
      if ((thisSign !== divisorSign)) {
        var lo = ((-x) | 0);
        var hi = ((-((lo !== 0) | 0)) | 0);
        var bi_$_lo = lo;
        var bi_$_hi = hi;
      } else {
        var bi_$_lo = x;
        var bi_$_hi = 0;
      }
      return $m_Ljava_math_BigInteger$().valueOf__J__Ljava_math_BigInteger(bi_$_lo, bi_$_hi);
    } else {
      var cmp = ((thisLen !== divisorLen) ? ((thisLen > divisorLen) ? 1 : (-1)) : $m_Ljava_math_Elementary$().compareArrays__AI__AI__I__I(this.Ljava_math_BigInteger__f_digits, $n(divisor).Ljava_math_BigInteger__f_digits, thisLen));
      if ((cmp === 0)) {
        return ((thisSign === divisorSign) ? $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ONE : $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_MINUS_ONE);
      } else if ((cmp === (-1))) {
        return $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO;
      } else {
        var resLength = ((1 + ((thisLen - divisorLen) | 0)) | 0);
        var resDigits = new $ac_I(resLength);
        var resSign = ((thisSign === divisorSign) ? 1 : (-1));
        if ((divisorLen === 1)) {
          $m_Ljava_math_Division$().divideArrayByInt__AI__AI__I__I__I(resDigits, this.Ljava_math_BigInteger__f_digits, thisLen, $n($n(divisor).Ljava_math_BigInteger__f_digits).get(0));
        } else {
          $m_Ljava_math_Division$().divide__AI__I__AI__I__AI__I__AI(resDigits, resLength, this.Ljava_math_BigInteger__f_digits, thisLen, $n(divisor).Ljava_math_BigInteger__f_digits, divisorLen);
        }
        var result = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), resSign, resLength, resDigits);
        result.cutOffLeadingZeroes__V();
        return result;
      }
    }
  }
});
$c_Ljava_math_BigInteger.prototype.hashCode__I = (function() {
  if ((this.Ljava_math_BigInteger__f__hashCode !== 0)) {
    return this.Ljava_math_BigInteger__f__hashCode;
  } else {
    var end = this.Ljava_math_BigInteger__f_numberLength;
    var i = 0;
    while ((i < end)) {
      var value = i;
      this.Ljava_math_BigInteger__f__hashCode = ((Math.imul(33, this.Ljava_math_BigInteger__f__hashCode) + $n(this.Ljava_math_BigInteger__f_digits).get(value)) | 0);
      i = ((1 + i) | 0);
    }
    this.Ljava_math_BigInteger__f__hashCode = Math.imul(this.Ljava_math_BigInteger__f__hashCode, this.Ljava_math_BigInteger__f_sign);
    return this.Ljava_math_BigInteger__f__hashCode;
  }
});
$c_Ljava_math_BigInteger.prototype.longValue__J = (function() {
  if ((this.Ljava_math_BigInteger__f_numberLength > 1)) {
    var value = $n(this.Ljava_math_BigInteger__f_digits).get(1);
    var value$1 = $n(this.Ljava_math_BigInteger__f_digits).get(0);
    var value$3_$_lo = value$1;
    var value$3_$_hi = value;
  } else {
    var value$2 = $n(this.Ljava_math_BigInteger__f_digits).get(0);
    var value$3_$_lo = value$2;
    var value$3_$_hi = 0;
  }
  var value$4 = this.Ljava_math_BigInteger__f_sign;
  var hi$3 = (value$4 >> 31);
  var a0 = (65535 & value$4);
  var a1 = ((value$4 >>> 16) | 0);
  var b0 = (65535 & value$3_$_lo);
  var b1 = ((value$3_$_lo >>> 16) | 0);
  var a0b0 = Math.imul(a0, b0);
  var a1b0 = Math.imul(a1, b0);
  var a0b1 = Math.imul(a0, b1);
  var lo = ((a0b0 + (((a1b0 + a0b1) | 0) << 16)) | 0);
  var c1part = ((((a0b0 >>> 16) | 0) + a0b1) | 0);
  var hi$4 = ((((((((Math.imul(value$4, value$3_$_hi) + Math.imul(hi$3, value$3_$_lo)) | 0) + Math.imul(a1, b1)) | 0) + ((c1part >>> 16) | 0)) | 0) + (((((65535 & c1part) + a1b0) | 0) >>> 16) | 0)) | 0);
  return $bL(lo, hi$4);
});
$c_Ljava_math_BigInteger.prototype.longValueExact__J = (function() {
  if (((this.Ljava_math_BigInteger__f_numberLength <= 2) && ($m_Ljava_math_BitLevel$().bitLength__Ljava_math_BigInteger__I(this) < 64))) {
    return this.longValue__J();
  } else {
    throw new $c_jl_ArithmeticException("BigInteger out of long range");
  }
});
$c_Ljava_math_BigInteger.prototype.multiply__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(bi) {
  if ((($n(bi).Ljava_math_BigInteger__f_sign === 0) || (this.Ljava_math_BigInteger__f_sign === 0))) {
    return $m_Ljava_math_BigInteger$().Ljava_math_BigInteger$__f_ZERO;
  } else {
    var this$1 = $m_Ljava_math_Multiplication$();
    return this$1.karatsuba__Ljava_math_BigInteger__Ljava_math_BigInteger__Ljava_math_BigInteger(this, bi);
  }
});
$c_Ljava_math_BigInteger.prototype.negate__Ljava_math_BigInteger = (function() {
  return ((this.Ljava_math_BigInteger__f_sign === 0) ? this : $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), ((-this.Ljava_math_BigInteger__f_sign) | 0), this.Ljava_math_BigInteger__f_numberLength, this.Ljava_math_BigInteger__f_digits));
});
$c_Ljava_math_BigInteger.prototype.remainder__Ljava_math_BigInteger__Ljava_math_BigInteger = (function(divisor) {
  if (($n(divisor).Ljava_math_BigInteger__f_sign === 0)) {
    throw new $c_jl_ArithmeticException("BigInteger divide by zero");
  }
  var thisLen = this.Ljava_math_BigInteger__f_numberLength;
  var divisorLen = $n(divisor).Ljava_math_BigInteger__f_numberLength;
  var cmp = ((thisLen !== divisorLen) ? ((thisLen > divisorLen) ? 1 : (-1)) : $m_Ljava_math_Elementary$().compareArrays__AI__AI__I__I(this.Ljava_math_BigInteger__f_digits, $n(divisor).Ljava_math_BigInteger__f_digits, thisLen));
  if ((cmp === (-1))) {
    return this;
  } else {
    var resDigits = new $ac_I(divisorLen);
    if ((divisorLen === 1)) {
      $n(resDigits).set(0, $m_Ljava_math_Division$().remainderArrayByInt__AI__I__I__I(this.Ljava_math_BigInteger__f_digits, thisLen, $n($n(divisor).Ljava_math_BigInteger__f_digits).get(0)));
    } else {
      var qLen = ((1 + ((thisLen - divisorLen) | 0)) | 0);
      resDigits = $m_Ljava_math_Division$().divide__AI__I__AI__I__AI__I__AI(null, qLen, this.Ljava_math_BigInteger__f_digits, thisLen, $n(divisor).Ljava_math_BigInteger__f_digits, divisorLen);
    }
    var result = $ct_Ljava_math_BigInteger__I__I__AI__(new $c_Ljava_math_BigInteger(), this.Ljava_math_BigInteger__f_sign, divisorLen, resDigits);
    result.cutOffLeadingZeroes__V();
    return result;
  }
});
$c_Ljava_math_BigInteger.prototype.shiftLeft__I__Ljava_math_BigInteger = (function(n) {
  return (((n === 0) || (this.Ljava_math_BigInteger__f_sign === 0)) ? this : ((n > 0) ? $m_Ljava_math_BitLevel$().shiftLeft__Ljava_math_BigInteger__I__Ljava_math_BigInteger(this, n) : $m_Ljava_math_BitLevel$().shiftRight__Ljava_math_BigInteger__I__Ljava_math_BigInteger(this, ((-n) | 0))));
});
$c_Ljava_math_BigInteger.prototype.shiftRight__I__Ljava_math_BigInteger = (function(n) {
  return (((n === 0) || (this.Ljava_math_BigInteger__f_sign === 0)) ? this : ((n > 0) ? $m_Ljava_math_BitLevel$().shiftRight__Ljava_math_BigInteger__I__Ljava_math_BigInteger(this, n) : $m_Ljava_math_BitLevel$().shiftLeft__Ljava_math_BigInteger__I__Ljava_math_BigInteger(this, ((-n) | 0))));
});
$c_Ljava_math_BigInteger.prototype.toString__T = (function() {
  return $m_Ljava_math_Conversion$().toDecimalScaledString__Ljava_math_BigInteger__T(this);
});
$c_Ljava_math_BigInteger.prototype.cutOffLeadingZeroes__V = (function() {
  while (true) {
    if ((this.Ljava_math_BigInteger__f_numberLength > 0)) {
      this.Ljava_math_BigInteger__f_numberLength = ((this.Ljava_math_BigInteger__f_numberLength - 1) | 0);
      if (($n(this.Ljava_math_BigInteger__f_digits).get(this.Ljava_math_BigInteger__f_numberLength) === 0)) {
        continue;
      }
    }
    break;
  }
  if (($n(this.Ljava_math_BigInteger__f_digits).get(this.Ljava_math_BigInteger__f_numberLength) === 0)) {
    this.Ljava_math_BigInteger__f_sign = 0;
  }
  this.Ljava_math_BigInteger__f_numberLength = ((1 + this.Ljava_math_BigInteger__f_numberLength) | 0);
});
$c_Ljava_math_BigInteger.prototype.getFirstNonzeroDigit__I = (function() {
  if ((this.Ljava_math_BigInteger__f_java$math$BigInteger$$firstNonzeroDigit === (-2))) {
    if ((this.Ljava_math_BigInteger__f_sign === 0)) {
      var $x_1 = (-1);
    } else {
      var i = 0;
      while (($n(this.Ljava_math_BigInteger__f_digits).get(i) === 0)) {
        i = ((1 + i) | 0);
      }
      var $x_1 = i;
    }
    this.Ljava_math_BigInteger__f_java$math$BigInteger$$firstNonzeroDigit = $x_1;
  }
  return this.Ljava_math_BigInteger__f_java$math$BigInteger$$firstNonzeroDigit;
});
$c_Ljava_math_BigInteger.prototype.isOne__Z = (function() {
  return ((this.Ljava_math_BigInteger__f_numberLength === 1) && ($n(this.Ljava_math_BigInteger__f_digits).get(0) === 1));
});
function $as_Ljava_math_BigInteger(obj) {
  return (((obj instanceof $c_Ljava_math_BigInteger) || (obj === null)) ? obj : $throwClassCastException(obj, "java.math.BigInteger"));
}
function $isArrayOf_Ljava_math_BigInteger(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && obj.$classData.arrayBase.ancestors.Ljava_math_BigInteger)));
}
function $asArrayOf_Ljava_math_BigInteger(obj, depth) {
  return (($isArrayOf_Ljava_math_BigInteger(obj, depth) || (obj === null)) ? obj : $throwArrayCastException(obj, "Ljava.math.BigInteger;", depth));
}
var $d_Ljava_math_BigInteger = new $TypeData().initClass($c_Ljava_math_BigInteger, "java.math.BigInteger", ({
  Ljava_math_BigInteger: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1
}));
function $ct_Ljava_io_FilterOutputStream__Ljava_io_OutputStream__($thiz, out) {
  return $thiz;
}
/** @constructor */
function $c_Ljava_io_FilterOutputStream() {
}
$c_Ljava_io_FilterOutputStream.prototype = new $h_Ljava_io_OutputStream();
$c_Ljava_io_FilterOutputStream.prototype.constructor = $c_Ljava_io_FilterOutputStream;
/** @constructor */
function $h_Ljava_io_FilterOutputStream() {
}
$h_Ljava_io_FilterOutputStream.prototype = $c_Ljava_io_FilterOutputStream.prototype;
class $c_jl_ArithmeticException extends $c_jl_RuntimeException {
  constructor(s) {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, s, null, true, true);
  }
}
var $d_jl_ArithmeticException = new $TypeData().initClass($c_jl_ArithmeticException, "java.lang.ArithmeticException", ({
  jl_ArithmeticException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
class $c_jl_ArrayStoreException extends $c_jl_RuntimeException {
  constructor(s) {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, s, null, true, true);
  }
}
var $d_jl_ArrayStoreException = new $TypeData().initClass($c_jl_ArrayStoreException, "java.lang.ArrayStoreException", ({
  jl_ArrayStoreException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
function $f_jl_Byte__hashCode__I($thiz) {
  return $thiz;
}
function $f_jl_Byte__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Byte = new $TypeData().initClass(0, "java.lang.Byte", ({
  jl_Byte: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1
}), ((x) => $isByte(x)));
class $c_jl_ClassCastException extends $c_jl_RuntimeException {
  constructor(s) {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, s, null, true, true);
  }
}
var $d_jl_ClassCastException = new $TypeData().initClass($c_jl_ClassCastException, "java.lang.ClassCastException", ({
  jl_ClassCastException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
class $c_jl_IndexOutOfBoundsException extends $c_jl_RuntimeException {
}
/** @constructor */
function $c_jl_JSConsoleBasedPrintStream$DummyOutputStream() {
}
$c_jl_JSConsoleBasedPrintStream$DummyOutputStream.prototype = new $h_Ljava_io_OutputStream();
$c_jl_JSConsoleBasedPrintStream$DummyOutputStream.prototype.constructor = $c_jl_JSConsoleBasedPrintStream$DummyOutputStream;
/** @constructor */
function $h_jl_JSConsoleBasedPrintStream$DummyOutputStream() {
}
$h_jl_JSConsoleBasedPrintStream$DummyOutputStream.prototype = $c_jl_JSConsoleBasedPrintStream$DummyOutputStream.prototype;
var $d_jl_JSConsoleBasedPrintStream$DummyOutputStream = new $TypeData().initClass($c_jl_JSConsoleBasedPrintStream$DummyOutputStream, "java.lang.JSConsoleBasedPrintStream$DummyOutputStream", ({
  jl_JSConsoleBasedPrintStream$DummyOutputStream: 1,
  Ljava_io_OutputStream: 1,
  Ljava_io_Closeable: 1,
  jl_AutoCloseable: 1,
  Ljava_io_Flushable: 1
}));
class $c_jl_NegativeArraySizeException extends $c_jl_RuntimeException {
  constructor() {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, null, null, true, true);
  }
}
var $d_jl_NegativeArraySizeException = new $TypeData().initClass($c_jl_NegativeArraySizeException, "java.lang.NegativeArraySizeException", ({
  jl_NegativeArraySizeException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
class $c_jl_NullPointerException extends $c_jl_RuntimeException {
  constructor() {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, null, null, true, true);
  }
}
var $d_jl_NullPointerException = new $TypeData().initClass($c_jl_NullPointerException, "java.lang.NullPointerException", ({
  jl_NullPointerException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
function $f_jl_Short__hashCode__I($thiz) {
  return $thiz;
}
function $f_jl_Short__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Short = new $TypeData().initClass(0, "java.lang.Short", ({
  jl_Short: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1
}), ((x) => $isShort(x)));
class $c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError extends $c_jl_VirtualMachineError {
  constructor(cause) {
    super();
    var message = ((cause === null) ? null : $n(cause).toString__T());
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, message, cause, true, true);
  }
}
var $d_Lorg_scalajs_linker_runtime_UndefinedBehaviorError = new $TypeData().initClass($c_Lorg_scalajs_linker_runtime_UndefinedBehaviorError, "org.scalajs.linker.runtime.UndefinedBehaviorError", ({
  Lorg_scalajs_linker_runtime_UndefinedBehaviorError: 1,
  jl_VirtualMachineError: 1,
  jl_Error: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
class $c_jl_ArrayIndexOutOfBoundsException extends $c_jl_IndexOutOfBoundsException {
  constructor(s) {
    super();
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, s, null, true, true);
  }
}
var $d_jl_ArrayIndexOutOfBoundsException = new $TypeData().initClass($c_jl_ArrayIndexOutOfBoundsException, "java.lang.ArrayIndexOutOfBoundsException", ({
  jl_ArrayIndexOutOfBoundsException: 1,
  jl_IndexOutOfBoundsException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
function $f_jl_Double__hashCode__I($thiz) {
  var valueInt = ($thiz | 0);
  if (((valueInt === $thiz) && ((1.0 / $thiz) !== (-Infinity)))) {
    return valueInt;
  } else if (($thiz !== $thiz)) {
    return 2146959360;
  } else {
    var fpBitsDataView = $fpBitsDataView;
    fpBitsDataView.setFloat64(0, $thiz, true);
    var lo = $uI(fpBitsDataView.getInt32(0, true));
    var hi = $uI(fpBitsDataView.getInt32(4, true));
    return (lo ^ hi);
  }
}
function $f_jl_Double__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Double = new $TypeData().initClass(0, "java.lang.Double", ({
  jl_Double: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1,
  jl_constant_ConstantDesc: 1
}), ((x) => ((typeof x) === "number")));
function $f_jl_Float__hashCode__I($thiz) {
  var value = $thiz;
  var valueInt = (value | 0);
  if (((valueInt === value) && ((1.0 / value) !== (-Infinity)))) {
    return valueInt;
  } else if ((value !== value)) {
    return 2146959360;
  } else {
    var fpBitsDataView = $fpBitsDataView;
    fpBitsDataView.setFloat64(0, value, true);
    var lo = $uI(fpBitsDataView.getInt32(0, true));
    var hi = $uI(fpBitsDataView.getInt32(4, true));
    return (lo ^ hi);
  }
}
function $f_jl_Float__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Float = new $TypeData().initClass(0, "java.lang.Float", ({
  jl_Float: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1,
  jl_constant_ConstantDesc: 1
}), ((x) => $isFloat(x)));
function $f_jl_Integer__hashCode__I($thiz) {
  return $thiz;
}
function $f_jl_Integer__toString__T($thiz) {
  return ("" + $thiz);
}
var $d_jl_Integer = new $TypeData().initClass(0, "java.lang.Integer", ({
  jl_Integer: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1,
  jl_constant_ConstantDesc: 1
}), ((x) => $isInt(x)));
function $f_jl_Long__hashCode__I($thiz, $thizhi) {
  return ($thiz ^ $thizhi);
}
function $f_jl_Long__toString__T($thiz, $thizhi) {
  return $m_RTLong$().toString__I__I__T($thiz, $thizhi);
}
var $d_jl_Long = new $TypeData().initClass(0, "java.lang.Long", ({
  jl_Long: 1,
  jl_Number: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_constant_Constable: 1,
  jl_constant_ConstantDesc: 1
}), ((x) => (x instanceof $Long)));
function $f_T__hashCode__I($thiz) {
  var n = $thiz.length;
  var h = 0;
  var i = 0;
  while ((i !== n)) {
    var $x_2 = h;
    var $x_1 = h;
    var index = i;
    h = ((((($x_2 << 5) - $x_1) | 0) + $charAt($thiz, index)) | 0);
    i = ((1 + i) | 0);
  }
  return h;
}
function $f_T__toString__T($thiz) {
  return $thiz;
}
function $as_T(obj) {
  return ((((typeof obj) === "string") || (obj === null)) ? obj : $throwClassCastException(obj, "java.lang.String"));
}
function $isArrayOf_T(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && obj.$classData.arrayBase.ancestors.T)));
}
function $asArrayOf_T(obj, depth) {
  return (($isArrayOf_T(obj, depth) || (obj === null)) ? obj : $throwArrayCastException(obj, "Ljava.lang.String;", depth));
}
var $d_T = new $TypeData().initClass(0, "java.lang.String", ({
  T: 1,
  Ljava_io_Serializable: 1,
  jl_Comparable: 1,
  jl_CharSequence: 1,
  jl_constant_Constable: 1,
  jl_constant_ConstantDesc: 1
}), ((x) => ((typeof x) === "string")));
class $c_jl_StringIndexOutOfBoundsException extends $c_jl_IndexOutOfBoundsException {
  constructor(index) {
    super();
    var s = ("String index out of range: " + index);
    $ct_jl_Throwable__T__jl_Throwable__Z__Z__(this, s, null, true, true);
  }
}
var $d_jl_StringIndexOutOfBoundsException = new $TypeData().initClass($c_jl_StringIndexOutOfBoundsException, "java.lang.StringIndexOutOfBoundsException", ({
  jl_StringIndexOutOfBoundsException: 1,
  jl_IndexOutOfBoundsException: 1,
  jl_RuntimeException: 1,
  jl_Exception: 1,
  jl_Throwable: 1,
  Ljava_io_Serializable: 1
}));
function $ct_Ljava_io_PrintStream__Ljava_io_OutputStream__Z__Ljava_nio_charset_Charset__($thiz, _out, autoFlush, charset) {
  $ct_Ljava_io_FilterOutputStream__Ljava_io_OutputStream__($thiz, _out);
  return $thiz;
}
/** @constructor */
function $c_Ljava_io_PrintStream() {
}
$c_Ljava_io_PrintStream.prototype = new $h_Ljava_io_FilterOutputStream();
$c_Ljava_io_PrintStream.prototype.constructor = $c_Ljava_io_PrintStream;
/** @constructor */
function $h_Ljava_io_PrintStream() {
}
$h_Ljava_io_PrintStream.prototype = $c_Ljava_io_PrintStream.prototype;
$c_Ljava_io_PrintStream.prototype.println__T__V = (function(s) {
  this.print__T__V(s);
  this.java$lang$JSConsoleBasedPrintStream$$printString__T__V("\n");
});
function $as_Ljava_io_PrintStream(obj) {
  return (((obj instanceof $c_Ljava_io_PrintStream) || (obj === null)) ? obj : $throwClassCastException(obj, "java.io.PrintStream"));
}
function $isArrayOf_Ljava_io_PrintStream(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && obj.$classData.arrayBase.ancestors.Ljava_io_PrintStream)));
}
function $asArrayOf_Ljava_io_PrintStream(obj, depth) {
  return (($isArrayOf_Ljava_io_PrintStream(obj, depth) || (obj === null)) ? obj : $throwArrayCastException(obj, "Ljava.io.PrintStream;", depth));
}
function $as_sjs_js_JavaScriptException(obj) {
  return ((false || (obj === null)) ? obj : $throwClassCastException(obj, "scala.scalajs.js.JavaScriptException"));
}
function $isArrayOf_sjs_js_JavaScriptException(obj, depth) {
  return (!(!(((obj && obj.$classData) && (obj.$classData.arrayDepth === depth)) && obj.$classData.arrayBase.ancestors.sjs_js_JavaScriptException)));
}
function $asArrayOf_sjs_js_JavaScriptException(obj, depth) {
  return (($isArrayOf_sjs_js_JavaScriptException(obj, depth) || (obj === null)) ? obj : $throwArrayCastException(obj, "Lscala.scalajs.js.JavaScriptException;", depth));
}
function $p_jl_JSConsoleBasedPrintStream__doWriteLine__T__V($thiz, line) {
  if (($as_T((typeof console)) !== "undefined")) {
    if (($thiz.jl_JSConsoleBasedPrintStream__f_isErr && $uZ((!(!console.error))))) {
      console.error(line);
    } else {
      console.log(line);
    }
  }
}
/** @constructor */
function $c_jl_JSConsoleBasedPrintStream(isErr) {
  this.jl_JSConsoleBasedPrintStream__f_isErr = false;
  this.jl_JSConsoleBasedPrintStream__f_buffer = null;
  this.jl_JSConsoleBasedPrintStream__f_isErr = isErr;
  var out = new $c_jl_JSConsoleBasedPrintStream$DummyOutputStream();
  $ct_Ljava_io_PrintStream__Ljava_io_OutputStream__Z__Ljava_nio_charset_Charset__(this, out, false, null);
  this.jl_JSConsoleBasedPrintStream__f_buffer = "";
}
$c_jl_JSConsoleBasedPrintStream.prototype = new $h_Ljava_io_PrintStream();
$c_jl_JSConsoleBasedPrintStream.prototype.constructor = $c_jl_JSConsoleBasedPrintStream;
/** @constructor */
function $h_jl_JSConsoleBasedPrintStream() {
}
$h_jl_JSConsoleBasedPrintStream.prototype = $c_jl_JSConsoleBasedPrintStream.prototype;
$c_jl_JSConsoleBasedPrintStream.prototype.print__T__V = (function(s) {
  this.java$lang$JSConsoleBasedPrintStream$$printString__T__V(((s === null) ? "null" : s));
});
$c_jl_JSConsoleBasedPrintStream.prototype.java$lang$JSConsoleBasedPrintStream$$printString__T__V = (function(s) {
  var rest = s;
  while ((rest !== "")) {
    var this$1 = $n(rest);
    var nlPos = $uI(this$1.indexOf("\n"));
    if ((nlPos < 0)) {
      this.jl_JSConsoleBasedPrintStream__f_buffer = (("" + this.jl_JSConsoleBasedPrintStream__f_buffer) + rest);
      rest = "";
    } else {
      var $x_1 = this.jl_JSConsoleBasedPrintStream__f_buffer;
      var this$2 = $n(rest);
      var length = this$2.length;
      if ((((nlPos | nlPos) | ((length - nlPos) | 0)) < 0)) {
        if ((nlPos < 0)) {
          $charAt(this$2, (-1));
        }
        $charAt(this$2, nlPos);
      }
      $p_jl_JSConsoleBasedPrintStream__doWriteLine__T__V(this, (("" + $x_1) + $as_T(this$2.substring(0, nlPos))));
      this.jl_JSConsoleBasedPrintStream__f_buffer = "";
      var this$4 = $n(rest);
      var beginIndex = ((1 + nlPos) | 0);
      var length$1 = this$4.length;
      if (((beginIndex >>> 0) > (length$1 >>> 0))) {
        $charAt(this$4, beginIndex);
      }
      rest = $as_T(this$4.substring(beginIndex));
    }
  }
});
var $d_jl_JSConsoleBasedPrintStream = new $TypeData().initClass($c_jl_JSConsoleBasedPrintStream, "java.lang.JSConsoleBasedPrintStream", ({
  jl_JSConsoleBasedPrintStream: 1,
  Ljava_io_PrintStream: 1,
  Ljava_io_FilterOutputStream: 1,
  Ljava_io_OutputStream: 1,
  Ljava_io_Closeable: 1,
  jl_AutoCloseable: 1,
  Ljava_io_Flushable: 1,
  jl_Appendable: 1
}));
$s_LMain__main__AT__V(new ($d_T.getArrayOf().constr)([]));
}).call(this);
