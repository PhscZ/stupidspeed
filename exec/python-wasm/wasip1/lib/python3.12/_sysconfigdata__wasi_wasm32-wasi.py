# system configuration generated and used by the sysconfig module
build_time_vars = {'ABIFLAGS': '',
 'ALIGNOF_LONG': 4,
 'AR': 'C:/stupidspeed/tools/wasi-sdk/bin/llvm-ar',
 'ARFLAGS': 'rcs',
 'BASECFLAGS': '-fno-strict-overflow',
 'BASECPPFLAGS': '',
 'BASEMODLIBS': '',
 'BINDIR': '//bin',
 'BINLIBDEST': '//lib/python3.12',
 'BLDLIBRARY': 'libpython3.12.a',
 'BLDSHARED': 'C:/stupidspeed/tools/wasi-sdk/bin/wasm-ld',
 'BOOTSTRAP_HEADERS': '\\',
 'BUILDEXE': '.wasm',
 'BUILDPYTHON': 'python.wasm',
 'BUILD_GNU_TYPE': 'x86_64-pc-mingw64',
 'BUILD_SCRIPTS_DIR': 'build/scripts-3.12',
 'BYTESTR_DEPS': '\\',
 'CC': 'ccache C:/stupidspeed/tools/wasi-sdk/bin/clang '
       '--sysroot=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot',
 'CCSHARED': '',
 'CFLAGS': '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
           'wasm32-wasip1-threads -pthread',
 'CFLAGSFORSHARED': '',
 'CFLAGS_ALIASING': '-fno-strict-aliasing',
 'CFLAGS_NODIST': '',
 'CODECS_COMMON_HEADERS': './Modules/cjkcodecs/multibytecodec.h '
                          './Modules/cjkcodecs/cjkcodecs.h',
 'COMPILEALL_OPTS': '-j0',
 'COMPILER': '"[lcc-win32]"',
 'CONFIGFILES': 'configure configure.ac acconfig.h pyconfig.h.in '
                'Makefile.pre.in',
 'CONFIGURE_CFLAGS': '-target wasm32-wasip1-threads -pthread',
 'CONFIGURE_CFLAGS_NODIST': '-target wasm32-wasip1-threads -pthread -std=c11 '
                            '-Wno-int-conversion '
                            '-Werror=implicit-function-declaration '
                            '-fvisibility=hidden',
 'CONFIGURE_CPPFLAGS': '',
 'CONFIGURE_LDFLAGS': '',
 'CONFIGURE_LDFLAGS_NODIST': '-target wasm32-wasip1-threads -pthread '
                             '-Wl,--import-memory -Wl,--export-memory '
                             '-Wl,--max-memory=1073741824 -z stack-size=524288 '
                             '-Wl,--stack-first -Wl,--initial-memory=10485760',
 'CONFIGURE_LDFLAGS_NOLTO': '',
 'CONFIG_ARGS': "'-C' '--host=wasm32-unknown-wasi' '--build=x86_64-pc-mingw64' "
                "'--enable-wasm-pthreads' "
                "'--with-build-python=C:/stupidspeed/temp/cpython-wasm/py312/python.exe' "
                "'--prefix=/' 'CONFIG_SITE=Tools/wasm/config.site-wasm32-wasi' "
                "'build_alias=x86_64-pc-mingw64' "
                "'host_alias=wasm32-unknown-wasi' 'PKG_CONFIG_PATH=' "
                "'PKG_CONFIG_LIBDIR=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot/lib/pkgconfig:C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot/share/pkgconfig' "
                "'CC=ccache C:/stupidspeed/tools/wasi-sdk/bin/clang "
                "--sysroot=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot' "
                "'CPP=ccache C:/stupidspeed/tools/wasi-sdk/bin/clang-cpp "
                "--sysroot=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot'",
 'CONFINCLUDEDIR': '//include',
 'CONFINCLUDEPY': '//include/python3.12',
 'COREPYTHONPATH': '',
 'COVERAGE_INFO': 'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2/coverage.info',
 'COVERAGE_LCOV_OPTIONS': '--rc lcov_branch_coverage=1',
 'COVERAGE_REPORT': 'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2/lcov-report',
 'COVERAGE_REPORT_OPTIONS': '--rc lcov_branch_coverage=1 --branch-coverage '
                            '--title "CPython 3.12 LCOV report [commit $(shell '
                            ')]"',
 'CPPFLAGS': '-I. -I./Include',
 'CXX': 'ccache C:/stupidspeed/tools/wasi-sdk/bin/clang++ '
        '--sysroot=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot',
 'DEEPFREEZE_C': 'Python/deepfreeze/deepfreeze.c',
 'DEEPFREEZE_DEPS': './Tools/build/deepfreeze.py ./Programs/_freeze_module.py '
                    '\\',
 'DEEPFREEZE_OBJS': 'Python/deepfreeze/deepfreeze.o',
 'DESTDIRS': '/ //lib //lib/python3.12 //lib/python3.12/lib-dynload',
 'DESTLIB': '//lib/python3.12',
 'DESTPATH': '',
 'DESTSHARED': '//lib/python3.12/lib-dynload',
 'DFLAGS': '',
 'DIRMODE': 755,
 'DIST': 'README.rst ChangeLog configure configure.ac acconfig.h pyconfig.h.in '
         'Makefile.pre.in Include Lib Misc Ext-dummy',
 'DISTDIRS': 'Include Lib Misc Ext-dummy',
 'DISTFILES': 'README.rst ChangeLog configure configure.ac acconfig.h '
              'pyconfig.h.in Makefile.pre.in',
 'DLINCLDIR': '.',
 'DLLLIBRARY': '',
 'DOUBLE_IS_LITTLE_ENDIAN_IEEE754': 1,
 'DSYMUTIL': '',
 'DSYMUTIL_PATH': '',
 'DTRACE': '',
 'DTRACE_DEPS': '\\',
 'DTRACE_HEADERS': '',
 'DTRACE_OBJS': '',
 'DYNLOADFILE': 'dynload_shlib.o',
 'ENSUREPIP': 'no',
 'EXE': '.wasm',
 'EXEMODE': 755,
 'EXENAME': '//bin/python3.12.wasm',
 'EXPORTSFROM': '',
 'EXPORTSYMS': '',
 'EXTRATESTOPTS': '',
 'EXTRA_CFLAGS': '',
 'EXT_SUFFIX': '.cpython-312-wasm32-wasi.so',
 'FILEMODE': 644,
 'FREEZE_MODULE': 'C:/stupidspeed/temp/cpython-wasm/py312/python.exe '
                  './Programs/_freeze_module.py',
 'FREEZE_MODULE_BOOTSTRAP': 'C:/stupidspeed/temp/cpython-wasm/py312/python.exe '
                            './Programs/_freeze_module.py',
 'FREEZE_MODULE_BOOTSTRAP_DEPS': './Programs/_freeze_module.py',
 'FREEZE_MODULE_DEPS': './Programs/_freeze_module.py',
 'FROZEN_FILES_IN': '\\',
 'FROZEN_FILES_OUT': '\\',
 'GETGROUPS_T': 0,
 'GETPGRP_HAVE_ARGS': 0,
 'GITBRANCH': '',
 'GITTAG': '',
 'GITVERSION': '',
 'GNULD': 'yes',
 'HAVE_ACCEPT': 1,
 'HAVE_BIND': 1,
 'HAVE_CONIO_H': 1,
 'HAVE_CONNECT': 1,
 'HAVE_DECL_TZNAME': 1,
 'HAVE_DIRECT_H': 1,
 'HAVE_DLFCN_H': 0,
 'HAVE_DUP': 1,
 'HAVE_ERF': 1,
 'HAVE_ERFC': 1,
 'HAVE_ERRNO_H': 1,
 'HAVE_FCNTL_H': 1,
 'HAVE_GETHOSTBYADDR': 1,
 'HAVE_GETHOSTBYNAME': 1,
 'HAVE_GETHOSTNAME': 1,
 'HAVE_GETPGRP': 0,
 'HAVE_GETPROTOBYNAME': 1,
 'HAVE_GETSERVBYNAME': 1,
 'HAVE_GETSERVBYPORT': 1,
 'HAVE_GETSOCKNAME': 1,
 'HAVE_GETTIMEOFDAY': 0,
 'HAVE_GETWD': 0,
 'HAVE_INET_NTOA': 1,
 'HAVE_INET_PTON': 1,
 'HAVE_INTPTR_T': 1,
 'HAVE_LIBDL': 0,
 'HAVE_LIBMPC': 0,
 'HAVE_LIBNSL': 1,
 'HAVE_LIBSEQ': 0,
 'HAVE_LIBSOCKET': 1,
 'HAVE_LIBSUN': 0,
 'HAVE_LIBTERMCAP': 0,
 'HAVE_LIBTERMLIB': 0,
 'HAVE_LIBTHREAD': 0,
 'HAVE_LISTEN': 1,
 'HAVE_LSTAT': 0,
 'HAVE_NICE': 0,
 'HAVE_PROCESS_H': 1,
 'HAVE_PY_SSIZE_T': 1,
 'HAVE_READLINK': 0,
 'HAVE_RECVFROM': 1,
 'HAVE_SENDTO': 1,
 'HAVE_SETPGID': 0,
 'HAVE_SETPGRP': 0,
 'HAVE_SETSID': 0,
 'HAVE_SETSOCKOPT': 1,
 'HAVE_SHUTDOWN': 1,
 'HAVE_SIGINTERRUPT': 0,
 'HAVE_SIGNAL_H': 1,
 'HAVE_SOCKET': 1,
 'HAVE_STDDEF_H': 1,
 'HAVE_SYMLINK': 0,
 'HAVE_SYS_AUDIOIO_H': 0,
 'HAVE_SYS_STAT_H': 1,
 'HAVE_SYS_TYPES_H': 1,
 'HAVE_TCGETPGRP': 0,
 'HAVE_TCSETPGRP': 0,
 'HAVE_TIMES': 0,
 'HAVE_TM_ZONE': 0,
 'HAVE_UINTPTR_T': 1,
 'HAVE_UMASK': 1,
 'HAVE_UNAME': 0,
 'HAVE_WAITPID': 0,
 'HAVE_WCHAR_H': 1,
 'HAVE_WCSCOLL': 1,
 'HAVE_WCSFTIME': 1,
 'HAVE_WCSXFRM': 1,
 'HAVE_WINDOWS_CONSOLE_IO': 1,
 'HAVE_X509_VERIFY_PARAM_SET1_HOST': 1,
 'HAVE_ZLIB_COPY': 1,
 'HOSTRUNNER': 'wasmtime run --env PYTHONPATH=/$(shell realpath --relative-to '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2)/$(shell cat '
               'pybuilddir.txt):/Lib --mapdir /::. --',
 'HOST_GNU_TYPE': 'wasm32-unknown-wasi',
 'INCLDIRSTOMAKE': '//include //include //include/python3.12 '
                   '//include/python3.12',
 'INCLUDEDIR': '//include',
 'INCLUDEPY': '//include/python3.12',
 'INSTALL': '/usr/bin/install -c',
 'INSTALL_DATA': '/usr/bin/install -c -m 644',
 'INSTALL_PROGRAM': '/usr/bin/install -c',
 'INSTALL_SCRIPT': '/usr/bin/install -c',
 'INSTALL_SHARED': '/usr/bin/install -c -m 755',
 'INSTSONAME': 'libpython3.12.a',
 'IO_H': 'Modules/_io/_iomodule.h',
 'IO_OBJS': '\\',
 'LDCXXSHARED': 'C:/stupidspeed/tools/wasi-sdk/bin/wasm-ld',
 'LDFLAGS': '',
 'LDFLAGS_NODIST': '',
 'LDLIBRARY': 'libpython3.12.a',
 'LDLIBRARYDIR': '',
 'LDSHARED': 'C:/stupidspeed/tools/wasi-sdk/bin/wasm-ld',
 'LDVERSION': '3.12',
 'LIBC': '',
 'LIBDEST': '//lib/python3.12',
 'LIBDIR': '//lib',
 'LIBEXPAT_A': 'Modules/expat/libexpat.a',
 'LIBEXPAT_CFLAGS': '-I./Modules/expat -fno-strict-overflow -DNDEBUG -g -O3 '
                    '-Wall -target wasm32-wasip1-threads -pthread -target '
                    'wasm32-wasip1-threads -pthread -std=c11 '
                    '-Wno-int-conversion -Werror=implicit-function-declaration '
                    '-fvisibility=hidden  -I./Include/internal -I. -I./Include',
 'LIBEXPAT_HEADERS': '\\',
 'LIBEXPAT_OBJS': '\\',
 'LIBHACL_CFLAGS': '-I./Modules/_hacl/include -D_BSD_SOURCE -D_DEFAULT_SOURCE '
                   '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
                   'wasm32-wasip1-threads -pthread -target '
                   'wasm32-wasip1-threads -pthread -std=c11 '
                   '-Wno-int-conversion -Werror=implicit-function-declaration '
                   '-fvisibility=hidden  -I./Include/internal -I. -I./Include',
 'LIBHACL_HEADERS': '\\',
 'LIBHACL_SHA2_A': 'Modules/_hacl/libHacl_Hash_SHA2.a',
 'LIBHACL_SHA2_HEADERS': '\\',
 'LIBHACL_SHA2_OBJS': '\\',
 'LIBM': '-lm',
 'LIBMPDEC_A': 'Modules/_decimal/libmpdec/libmpdec.a',
 'LIBMPDEC_CFLAGS': '-I./Modules/_decimal/libmpdec -DCONFIG_32=1 -DANSI=1 '
                    '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
                    'wasm32-wasip1-threads -pthread -target '
                    'wasm32-wasip1-threads -pthread -std=c11 '
                    '-Wno-int-conversion -Werror=implicit-function-declaration '
                    '-fvisibility=hidden  -I./Include/internal -I. -I./Include',
 'LIBMPDEC_HEADERS': '\\',
 'LIBMPDEC_OBJS': '\\',
 'LIBOBJDIR': 'Python/',
 'LIBOBJS': '',
 'LIBPC': '//lib/pkgconfig',
 'LIBPL': '//lib/python3.12/config-3.12-wasm32-wasi',
 'LIBPYTHON': '',
 'LIBRARY': 'libpython3.12.a',
 'LIBRARY_DEPS': 'libpython3.12.a',
 'LIBRARY_OBJS': '\\',
 'LIBRARY_OBJS_OMIT_FROZEN': '\\',
 'LIBS': '-ldl  -lwasi-emulated-signal -lwasi-emulated-getpid '
         '-lwasi-emulated-process-clocks -lpthread',
 'LIBSUBDIRS': 'asyncio \\',
 'LINKCC': 'ccache C:/stupidspeed/tools/wasi-sdk/bin/clang '
           '--sysroot=C:/stupidspeed/tools/wasi-sdk/share/wasi-sysroot',
 'LINKFORSHARED': '',
 'LINK_PYTHON_DEPS': 'libpython3.12.a',
 'LINK_PYTHON_OBJS': '\\',
 'LIPO_32BIT_FLAGS': '',
 'LIPO_INTEL64_FLAGS': '',
 'LLVM_PROF_ERR': 'yes',
 'LLVM_PROF_FILE': 'LLVM_PROFILE_FILE="code-%p.profclangr"',
 'LLVM_PROF_MERGER': "'' merge -output=code.profclangd *.profclangr",
 'LN': 'ln',
 'LOCALMODLIBS': '-lm -lm -lm -lm -lm -lm '
                 'Modules/_decimal/libmpdec/libmpdec.a     '
                 'Modules/_hacl/libHacl_Hash_SHA2.a   -lm '
                 'Modules/expat/libexpat.a',
 'LONG_BIT': 32,
 'MACHDEP': 'wasi',
 'MACHDEP_OBJS': '',
 'MACHDESTLIB': '//lib/python3.12',
 'MACOSX_DEPLOYMENT_TARGET': '',
 'MAKESETUP': './Modules/makesetup',
 'MANDIR': '//share/man',
 'MKDIR_P': '/usr/bin/mkdir -p',
 'MODBUILT_NAMES': 'array  _asyncio  _bisect  _contextvars  _csv  _heapq  '
                   '_json  _lsprof  _opcode  _pickle  _queue  _random  '
                   '_struct  _zoneinfo  audioop  math  cmath  _statistics  '
                   '_datetime  _decimal  binascii  _md5  _sha1  _sha2  _sha3  '
                   '_blake2  pyexpat  _elementtree  _codecs_cn  _codecs_hk  '
                   '_codecs_iso2022  _codecs_jp  _codecs_kr  _codecs_tw  '
                   '_multibytecodec  unicodedata  _crypt  select  _socket  '
                   'xxsubtype  _xxtestfuzz  _testbuffer  _testinternalcapi  '
                   '_testcapi  _testclinic  _testimportmultiple  '
                   '_testmultiphase  _testsinglephase  xxlimited  '
                   'xxlimited_35  atexit  faulthandler  posix  _signal  '
                   '_tracemalloc  _codecs  _collections  errno  _io  '
                   'itertools  _sre  _thread  time  _typing  _weakref  _abc  '
                   '_functools  _locale  _operator  _stat  _symtable',
 'MODDISABLED_NAMES': '',
 'MODLIBS': '-lm -lm -lm -lm -lm -lm Modules/_decimal/libmpdec/libmpdec.a     '
            'Modules/_hacl/libHacl_Hash_SHA2.a   -lm Modules/expat/libexpat.a',
 'MODOBJS': 'Modules/arraymodule.o  Modules/_asynciomodule.o  '
            'Modules/_bisectmodule.o  Modules/_contextvarsmodule.o  '
            'Modules/_csv.o  Modules/_heapqmodule.o  Modules/_json.o  '
            'Modules/_lsprof.o Modules/rotatingtree.o  Modules/_opcode.o  '
            'Modules/_pickle.o  Modules/_queuemodule.o  '
            'Modules/_randommodule.o  Modules/_struct.o  Modules/_zoneinfo.o  '
            'Modules/audioop.o  Modules/mathmodule.o  Modules/cmathmodule.o  '
            'Modules/_statisticsmodule.o  Modules/_datetimemodule.o  '
            'Modules/_decimal/_decimal.o  Modules/binascii.o  '
            'Modules/md5module.o Modules/_hacl/Hacl_Hash_MD5.o  '
            'Modules/sha1module.o Modules/_hacl/Hacl_Hash_SHA1.o  '
            'Modules/sha2module.o  Modules/sha3module.o '
            'Modules/_hacl/Hacl_Hash_SHA3.o  Modules/_blake2/blake2module.o '
            'Modules/_blake2/blake2b_impl.o Modules/_blake2/blake2s_impl.o  '
            'Modules/pyexpat.o  Modules/_elementtree.o  '
            'Modules/cjkcodecs/_codecs_cn.o  Modules/cjkcodecs/_codecs_hk.o  '
            'Modules/cjkcodecs/_codecs_iso2022.o  '
            'Modules/cjkcodecs/_codecs_jp.o  Modules/cjkcodecs/_codecs_kr.o  '
            'Modules/cjkcodecs/_codecs_tw.o  '
            'Modules/cjkcodecs/multibytecodec.o  Modules/unicodedata.o  '
            'Modules/_cryptmodule.o  Modules/selectmodule.o  '
            'Modules/socketmodule.o  Modules/xxsubtype.o  '
            'Modules/_xxtestfuzz/_xxtestfuzz.o Modules/_xxtestfuzz/fuzzer.o  '
            'Modules/_testbuffer.o  Modules/_testinternalcapi.o  '
            'Modules/_testcapimodule.o Modules/_testcapi/vectorcall.o '
            'Modules/_testcapi/vectorcall_limited.o '
            'Modules/_testcapi/heaptype.o Modules/_testcapi/abstract.o '
            'Modules/_testcapi/bytearray.o Modules/_testcapi/bytes.o '
            'Modules/_testcapi/unicode.o Modules/_testcapi/dict.o '
            'Modules/_testcapi/set.o Modules/_testcapi/list.o '
            'Modules/_testcapi/tuple.o Modules/_testcapi/getargs.o '
            'Modules/_testcapi/pytime.o Modules/_testcapi/datetime.o '
            'Modules/_testcapi/docstring.o Modules/_testcapi/mem.o '
            'Modules/_testcapi/watchers.o Modules/_testcapi/long.o '
            'Modules/_testcapi/float.o Modules/_testcapi/complex.o '
            'Modules/_testcapi/numbers.o Modules/_testcapi/structmember.o '
            'Modules/_testcapi/exceptions.o Modules/_testcapi/code.o '
            'Modules/_testcapi/buffer.o Modules/_testcapi/pyos.o '
            'Modules/_testcapi/file.o Modules/_testcapi/codec.o '
            'Modules/_testcapi/immortal.o '
            'Modules/_testcapi/heaptype_relative.o Modules/_testcapi/gc.o '
            'Modules/_testcapi/sys.o  Modules/_testclinic.o  '
            'Modules/atexitmodule.o  Modules/faulthandler.o  '
            'Modules/posixmodule.o  Modules/signalmodule.o  '
            'Modules/_tracemalloc.o  Modules/_codecsmodule.o  '
            'Modules/_collectionsmodule.o  Modules/errnomodule.o  '
            'Modules/_io/_iomodule.o Modules/_io/iobase.o Modules/_io/fileio.o '
            'Modules/_io/bytesio.o Modules/_io/bufferedio.o '
            'Modules/_io/textio.o Modules/_io/stringio.o  '
            'Modules/itertoolsmodule.o  Modules/_sre/sre.o  '
            'Modules/_threadmodule.o  Modules/timemodule.o  '
            'Modules/_typingmodule.o  Modules/_weakref.o  Modules/_abc.o  '
            'Modules/_functoolsmodule.o  Modules/_localemodule.o  '
            'Modules/_operator.o  Modules/_stat.o  Modules/symtablemodule.o',
 'MODSHARED_NAMES': '_testimportmultiple _testmultiphase _testsinglephase '
                    'xxlimited xxlimited_35',
 'MODULE_ARRAY_LDFLAGS': '',
 'MODULE_ARRAY_STATE': 'yes',
 'MODULE_ATEXIT_LDFLAGS': '',
 'MODULE_AUDIOOP_LDFLAGS': '-lm',
 'MODULE_AUDIOOP_STATE': 'yes',
 'MODULE_BINASCII_CFLAGS': '',
 'MODULE_BINASCII_LDFLAGS': '',
 'MODULE_BINASCII_STATE': 'yes',
 'MODULE_CMATH_DEPS': './Modules/_math.h',
 'MODULE_CMATH_LDFLAGS': '-lm',
 'MODULE_CMATH_STATE': 'yes',
 'MODULE_DEPS_SHARED': 'Modules/config.c',
 'MODULE_DEPS_STATIC': 'Modules/config.c',
 'MODULE_ERRNO_LDFLAGS': '',
 'MODULE_FAULTHANDLER_LDFLAGS': '',
 'MODULE_FCNTL_STATE': 'n/a',
 'MODULE_GRP_STATE': 'n/a',
 'MODULE_ITERTOOLS_LDFLAGS': '',
 'MODULE_MATH_DEPS': './Modules/_math.h',
 'MODULE_MATH_LDFLAGS': '-lm',
 'MODULE_MATH_STATE': 'yes',
 'MODULE_MMAP_STATE': 'n/a',
 'MODULE_NIS_STATE': 'n/a',
 'MODULE_OBJS': '\\',
 'MODULE_OSSAUDIODEV_STATE': 'n/a',
 'MODULE_POSIX_LDFLAGS': '',
 'MODULE_PWD_STATE': 'n/a',
 'MODULE_PYEXPAT_CFLAGS': '-I./Modules/expat',
 'MODULE_PYEXPAT_DEPS': '\\ Modules/expat/libexpat.a',
 'MODULE_PYEXPAT_LDFLAGS': '-lm Modules/expat/libexpat.a',
 'MODULE_PYEXPAT_STATE': 'yes',
 'MODULE_READLINE_STATE': 'missing',
 'MODULE_RESOURCE_STATE': 'n/a',
 'MODULE_SELECT_LDFLAGS': '',
 'MODULE_SELECT_STATE': 'yes',
 'MODULE_SPWD_STATE': 'n/a',
 'MODULE_SYSLOG_STATE': 'n/a',
 'MODULE_TERMIOS_STATE': 'n/a',
 'MODULE_TIME_LDFLAGS': '',
 'MODULE_TIME_STATE': 'yes',
 'MODULE_UNICODEDATA_DEPS': './Modules/unicodedata_db.h '
                            './Modules/unicodename_db.h',
 'MODULE_UNICODEDATA_LDFLAGS': '',
 'MODULE_UNICODEDATA_STATE': 'yes',
 'MODULE_XXLIMITED_35_STATE': 'yes',
 'MODULE_XXLIMITED_STATE': 'yes',
 'MODULE_XXSUBTYPE_LDFLAGS': '',
 'MODULE_XXSUBTYPE_STATE': 'yes',
 'MODULE_ZLIB_STATE': 'missing',
 'MODULE__ABC_LDFLAGS': '',
 'MODULE__ASYNCIO_LDFLAGS': '',
 'MODULE__ASYNCIO_STATE': 'yes',
 'MODULE__BISECT_LDFLAGS': '',
 'MODULE__BISECT_STATE': 'yes',
 'MODULE__BLAKE2_CFLAGS': '',
 'MODULE__BLAKE2_DEPS': './Modules/_blake2/impl/blake2-config.h '
                        './Modules/_blake2/impl/blake2-impl.h '
                        './Modules/_blake2/impl/blake2.h '
                        './Modules/_blake2/impl/blake2b-load-sse2.h '
                        './Modules/_blake2/impl/blake2b-load-sse41.h '
                        './Modules/_blake2/impl/blake2b-ref.c '
                        './Modules/_blake2/impl/blake2b-round.h '
                        './Modules/_blake2/impl/blake2b.c '
                        './Modules/_blake2/impl/blake2s-load-sse2.h '
                        './Modules/_blake2/impl/blake2s-load-sse41.h '
                        './Modules/_blake2/impl/blake2s-load-xop.h '
                        './Modules/_blake2/impl/blake2s-ref.c '
                        './Modules/_blake2/impl/blake2s-round.h '
                        './Modules/_blake2/impl/blake2s.c '
                        './Modules/_blake2/blake2module.h ./Modules/hashlib.h',
 'MODULE__BLAKE2_LDFLAGS': '',
 'MODULE__BLAKE2_STATE': 'yes',
 'MODULE__BZ2_STATE': 'missing',
 'MODULE__CODECS_CN_DEPS': './Modules/cjkcodecs/mappings_cn.h '
                           './Modules/cjkcodecs/multibytecodec.h '
                           './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_CN_LDFLAGS': '',
 'MODULE__CODECS_CN_STATE': 'yes',
 'MODULE__CODECS_HK_DEPS': './Modules/cjkcodecs/mappings_hk.h  '
                           './Modules/cjkcodecs/multibytecodec.h '
                           './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_HK_LDFLAGS': '',
 'MODULE__CODECS_HK_STATE': 'yes',
 'MODULE__CODECS_ISO2022_DEPS': './Modules/cjkcodecs/mappings_jisx0213_pair.h '
                                './Modules/cjkcodecs/alg_jisx0201.h '
                                './Modules/cjkcodecs/emu_jisx0213_2000.h '
                                './Modules/cjkcodecs/multibytecodec.h '
                                './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_ISO2022_LDFLAGS': '',
 'MODULE__CODECS_ISO2022_STATE': 'yes',
 'MODULE__CODECS_JP_DEPS': './Modules/cjkcodecs/mappings_jisx0213_pair.h '
                           './Modules/cjkcodecs/alg_jisx0201.h '
                           './Modules/cjkcodecs/emu_jisx0213_2000.h '
                           './Modules/cjkcodecs/mappings_jp.h '
                           './Modules/cjkcodecs/multibytecodec.h '
                           './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_JP_LDFLAGS': '',
 'MODULE__CODECS_JP_STATE': 'yes',
 'MODULE__CODECS_KR_DEPS': './Modules/cjkcodecs/mappings_kr.h '
                           './Modules/cjkcodecs/multibytecodec.h '
                           './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_KR_LDFLAGS': '',
 'MODULE__CODECS_KR_STATE': 'yes',
 'MODULE__CODECS_LDFLAGS': '',
 'MODULE__CODECS_TW_DEPS': './Modules/cjkcodecs/mappings_tw.h '
                           './Modules/cjkcodecs/multibytecodec.h '
                           './Modules/cjkcodecs/cjkcodecs.h',
 'MODULE__CODECS_TW_LDFLAGS': '',
 'MODULE__CODECS_TW_STATE': 'yes',
 'MODULE__COLLECTIONS_LDFLAGS': '',
 'MODULE__CONTEXTVARS_LDFLAGS': '',
 'MODULE__CONTEXTVARS_STATE': 'yes',
 'MODULE__CRYPT_CFLAGS': '',
 'MODULE__CRYPT_LDFLAGS': '',
 'MODULE__CRYPT_STATE': 'yes',
 'MODULE__CSV_LDFLAGS': '',
 'MODULE__CSV_STATE': 'yes',
 'MODULE__CTYPES_DEPS': './Modules/_ctypes/ctypes.h',
 'MODULE__CTYPES_MALLOC_CLOSURE': '',
 'MODULE__CTYPES_STATE': 'missing',
 'MODULE__CTYPES_TEST_STATE': 'n/a',
 'MODULE__CURSES_PANEL_STATE': 'n/a',
 'MODULE__CURSES_STATE': 'n/a',
 'MODULE__DATETIME_LDFLAGS': '-lm',
 'MODULE__DATETIME_STATE': 'yes',
 'MODULE__DBM_STATE': 'n/a',
 'MODULE__DECIMAL_CFLAGS': '-I./Modules/_decimal/libmpdec -DCONFIG_32=1 '
                           '-DANSI=1',
 'MODULE__DECIMAL_DEPS': './Modules/_decimal/docstrings.h \\ '
                         'Modules/_decimal/libmpdec/libmpdec.a',
 'MODULE__DECIMAL_LDFLAGS': '-lm Modules/_decimal/libmpdec/libmpdec.a',
 'MODULE__DECIMAL_STATE': 'yes',
 'MODULE__ELEMENTTREE_CFLAGS': '-I./Modules/expat',
 'MODULE__ELEMENTTREE_DEPS': './Modules/pyexpat.c \\ Modules/expat/libexpat.a',
 'MODULE__ELEMENTTREE_LDFLAGS': '',
 'MODULE__ELEMENTTREE_STATE': 'yes',
 'MODULE__FUNCTOOLS_LDFLAGS': '',
 'MODULE__GDBM_STATE': 'n/a',
 'MODULE__HASHLIB_DEPS': './Modules/hashlib.h',
 'MODULE__HASHLIB_STATE': 'missing',
 'MODULE__HEAPQ_LDFLAGS': '',
 'MODULE__HEAPQ_STATE': 'yes',
 'MODULE__IO_CFLAGS': '-I./Modules/_io',
 'MODULE__IO_DEPS': './Modules/_io/_iomodule.h',
 'MODULE__IO_LDFLAGS': '',
 'MODULE__IO_STATE': 'yes',
 'MODULE__JSON_LDFLAGS': '',
 'MODULE__JSON_STATE': 'yes',
 'MODULE__LOCALE_LDFLAGS': '',
 'MODULE__LSPROF_LDFLAGS': '',
 'MODULE__LSPROF_STATE': 'yes',
 'MODULE__LZMA_STATE': 'missing',
 'MODULE__MD5_CFLAGS': '-I./Modules/_hacl/include -I./Modules/_hacl/internal '
                       '-D_BSD_SOURCE -D_DEFAULT_SOURCE',
 'MODULE__MD5_DEPS': './Modules/hashlib.h \\ Modules/_hacl/Hacl_Hash_MD5.h '
                     'Modules/_hacl/Hacl_Hash_MD5.c',
 'MODULE__MD5_STATE': 'yes',
 'MODULE__MULTIBYTECODEC_DEPS': './Modules/cjkcodecs/multibytecodec.h',
 'MODULE__MULTIBYTECODEC_LDFLAGS': '',
 'MODULE__MULTIBYTECODEC_STATE': 'yes',
 'MODULE__MULTIPROCESSING_STATE': 'n/a',
 'MODULE__OPCODE_LDFLAGS': '',
 'MODULE__OPCODE_STATE': 'yes',
 'MODULE__OPERATOR_LDFLAGS': '',
 'MODULE__PICKLE_LDFLAGS': '',
 'MODULE__PICKLE_STATE': 'yes',
 'MODULE__POSIXSHMEM_STATE': 'n/a',
 'MODULE__POSIXSUBPROCESS_STATE': 'n/a',
 'MODULE__QUEUE_LDFLAGS': '',
 'MODULE__QUEUE_STATE': 'yes',
 'MODULE__RANDOM_LDFLAGS': '',
 'MODULE__RANDOM_STATE': 'yes',
 'MODULE__SCPROXY_STATE': 'n/a',
 'MODULE__SHA1_CFLAGS': '-I./Modules/_hacl/include -I./Modules/_hacl/internal '
                        '-D_BSD_SOURCE -D_DEFAULT_SOURCE',
 'MODULE__SHA1_DEPS': './Modules/hashlib.h \\ Modules/_hacl/Hacl_Hash_SHA1.h '
                      'Modules/_hacl/Hacl_Hash_SHA1.c',
 'MODULE__SHA1_STATE': 'yes',
 'MODULE__SHA2_CFLAGS': '-I./Modules/_hacl/include -I./Modules/_hacl/internal '
                        '-D_BSD_SOURCE -D_DEFAULT_SOURCE',
 'MODULE__SHA2_DEPS': './Modules/hashlib.h \\ '
                      'Modules/_hacl/libHacl_Hash_SHA2.a',
 'MODULE__SHA2_STATE': 'yes',
 'MODULE__SHA3_DEPS': './Modules/hashlib.h \\ Modules/_hacl/Hacl_Hash_SHA3.h '
                      'Modules/_hacl/Hacl_Hash_SHA3.c',
 'MODULE__SHA3_STATE': 'yes',
 'MODULE__SIGNAL_LDFLAGS': '',
 'MODULE__SOCKET_DEPS': './Modules/socketmodule.h ./Modules/addrinfo.h '
                        './Modules/getaddrinfo.c ./Modules/getnameinfo.c',
 'MODULE__SOCKET_LDFLAGS': '',
 'MODULE__SOCKET_STATE': 'yes',
 'MODULE__SQLITE3_DEPS': './Modules/_sqlite/connection.h '
                         './Modules/_sqlite/cursor.h '
                         './Modules/_sqlite/microprotocols.h '
                         './Modules/_sqlite/module.h '
                         './Modules/_sqlite/prepare_protocol.h '
                         './Modules/_sqlite/row.h ./Modules/_sqlite/util.h',
 'MODULE__SQLITE3_STATE': 'disabled',
 'MODULE__SRE_LDFLAGS': '',
 'MODULE__SSL_DEPS': './Modules/_ssl.h ./Modules/_ssl/cert.c '
                     './Modules/_ssl/debughelpers.c ./Modules/_ssl/misc.c '
                     './Modules/_ssl_data.h ./Modules/_ssl_data_111.h '
                     './Modules/_ssl_data_300.h ./Modules/socketmodule.h',
 'MODULE__SSL_STATE': 'missing',
 'MODULE__STATISTICS_LDFLAGS': '-lm',
 'MODULE__STATISTICS_STATE': 'yes',
 'MODULE__STAT_LDFLAGS': '',
 'MODULE__STRUCT_LDFLAGS': '',
 'MODULE__STRUCT_STATE': 'yes',
 'MODULE__SYMTABLE_LDFLAGS': '',
 'MODULE__TESTBUFFER_LDFLAGS': '',
 'MODULE__TESTBUFFER_STATE': 'yes',
 'MODULE__TESTCAPI_DEPS': './Modules/_testcapi/testcapi_long.h '
                          './Modules/_testcapi/parts.h '
                          './Modules/_testcapi/util.h',
 'MODULE__TESTCAPI_LDFLAGS': '',
 'MODULE__TESTCAPI_STATE': 'yes',
 'MODULE__TESTCLINIC_LDFLAGS': '',
 'MODULE__TESTCLINIC_STATE': 'yes',
 'MODULE__TESTIMPORTMULTIPLE_STATE': 'yes',
 'MODULE__TESTINTERNALCAPI_LDFLAGS': '',
 'MODULE__TESTINTERNALCAPI_STATE': 'yes',
 'MODULE__TESTMULTIPHASE_STATE': 'yes',
 'MODULE__THREAD_LDFLAGS': '',
 'MODULE__TKINTER_STATE': 'n/a',
 'MODULE__TRACEMALLOC_LDFLAGS': '',
 'MODULE__TYPING_LDFLAGS': '',
 'MODULE__TYPING_STATE': 'yes',
 'MODULE__UUID_STATE': 'missing',
 'MODULE__WEAKREF_LDFLAGS': '',
 'MODULE__XXINTERPCHANNELS_STATE': 'n/a',
 'MODULE__XXSUBINTERPRETERS_STATE': 'n/a',
 'MODULE__XXTESTFUZZ_LDFLAGS': '',
 'MODULE__XXTESTFUZZ_STATE': 'yes',
 'MODULE__ZONEINFO_LDFLAGS': '',
 'MODULE__ZONEINFO_STATE': 'yes',
 'MS_WIN32': '/* only support win32 and greater. */',
 'MULTIARCH': 'wasm32-wasi',
 'MULTIARCH_CPPFLAGS': '-DMULTIARCH=\\"wasm32-wasi\\"',
 'NDIR': 0,
 'NO_AS_NEEDED': '',
 'NTDDI_VERSION': 'Py_NTDDI',
 'OBJECT_OBJS': '\\',
 'OPT': '-DNDEBUG -g -O3 -Wall',
 'PARSER_HEADERS': '\\',
 'PARSER_OBJS': '\\ \\ Parser/myreadline.o Parser/tokenizer.o',
 'PEGEN_HEADERS': '\\',
 'PEGEN_OBJS': '\\',
 'PGO_PROF_GEN_FLAG': '-fprofile-instr-generate',
 'PGO_PROF_USE_FLAG': '-fprofile-instr-use=code.profclangd',
 'PLATLIBDIR': 'lib',
 'POBJS': '\\',
 'PROFILE_TASK': '-m test --pgo --timeout=1200',
 'PURIFY': '',
 'PY3LIBRARY': '',
 'PYD_PLATFORM_TAG': '"win_arm32"',
 'PYTHON': 'python.wasm',
 'PYTHONFRAMEWORK': '',
 'PYTHONFRAMEWORKDIR': 'no-framework',
 'PYTHONFRAMEWORKINSTALLDIR': '',
 'PYTHONFRAMEWORKPREFIX': '',
 'PYTHONPATH': '',
 'PYTHON_FOR_BUILD': "_PYTHON_HOSTRUNNER='wasmtime run --env "
                     'PYTHONPATH=/$(shell realpath --relative-to '
                     'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
                     'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2)/$(shell '
                     "cat pybuilddir.txt):/Lib --mapdir /::. --' "
                     '_PYTHON_PROJECT_BASE=C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
                     '_PYTHON_HOST_PLATFORM=$(_PYTHON_HOST_PLATFORM) '
                     'PYTHONPATH=$(shell test -f pybuilddir.txt && echo '
                     'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2/`cat '
                     'pybuilddir.txt`:)./Lib '
                     '_PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata__wasi_wasm32-wasi '
                     'C:/stupidspeed/temp/cpython-wasm/py312/python.exe',
 'PYTHON_FOR_BUILD_DEPS': '',
 'PYTHON_FOR_FREEZE': 'C:/stupidspeed/temp/cpython-wasm/py312/python.exe',
 'PYTHON_FOR_REGEN': '',
 'PYTHON_HEADERS': '\\',
 'PYTHON_OBJS': '\\',
 'PY_BUILTIN_MODULE_CFLAGS': '-fno-strict-overflow -DNDEBUG -g -O3 -Wall '
                             '-target wasm32-wasip1-threads -pthread -target '
                             'wasm32-wasip1-threads -pthread -std=c11 '
                             '-Wno-int-conversion '
                             '-Werror=implicit-function-declaration '
                             '-fvisibility=hidden  -I./Include/internal -I. '
                             '-I./Include -DPy_BUILD_CORE_BUILTIN',
 'PY_CFLAGS': '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
              'wasm32-wasip1-threads -pthread',
 'PY_CFLAGS_NODIST': '-target wasm32-wasip1-threads -pthread -std=c11 '
                     '-Wno-int-conversion '
                     '-Werror=implicit-function-declaration '
                     '-fvisibility=hidden  -I./Include/internal',
 'PY_CORE_CFLAGS': '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
                   'wasm32-wasip1-threads -pthread -target '
                   'wasm32-wasip1-threads -pthread -std=c11 '
                   '-Wno-int-conversion -Werror=implicit-function-declaration '
                   '-fvisibility=hidden  -I./Include/internal -I. -I./Include '
                   '-DPy_BUILD_CORE',
 'PY_CORE_LDFLAGS': '-target wasm32-wasip1-threads -pthread '
                    '-Wl,--import-memory -Wl,--export-memory '
                    '-Wl,--max-memory=1073741824 -z stack-size=524288 '
                    '-Wl,--stack-first -Wl,--initial-memory=10485760',
 'PY_CPPFLAGS': '-I. -I./Include',
 'PY_ENABLE_SHARED': 0,
 'PY_INT32_T': 'int32_t',
 'PY_INT64_T': 'int64_t',
 'PY_LDFLAGS': '',
 'PY_LDFLAGS_NODIST': '-target wasm32-wasip1-threads -pthread '
                      '-Wl,--import-memory -Wl,--export-memory '
                      '-Wl,--max-memory=1073741824 -z stack-size=524288 '
                      '-Wl,--stack-first -Wl,--initial-memory=10485760',
 'PY_LDFLAGS_NOLTO': '',
 'PY_LLONG_MAX': 'LLONG_MAX',
 'PY_LLONG_MIN': 'LLONG_MIN',
 'PY_LONG_LONG': 'long long',
 'PY_STDMODULE_CFLAGS': '-fno-strict-overflow -DNDEBUG -g -O3 -Wall -target '
                        'wasm32-wasip1-threads -pthread -target '
                        'wasm32-wasip1-threads -pthread -std=c11 '
                        '-Wno-int-conversion '
                        '-Werror=implicit-function-declaration '
                        '-fvisibility=hidden  -I./Include/internal -I. '
                        '-I./Include',
 'PY_SUPPORT_TIER': 0,
 'PY_UINT32_T': 'uint32_t',
 'PY_UINT64_T': 'uint64_t',
 'PY_ULLONG_MAX': 'ULLONG_MAX',
 'Py_NTDDI': 'NTDDI_WIN8',
 'Py_WINVER': '0x0602 /* _WIN32_WINNT_WIN8 */',
 'QUICKTESTOPTS': '-x test_subprocess test_io test_lib2to3 \\',
 'READELF': '@READELF@',
 'RESSRCDIR': 'Mac/Resources/framework',
 'RETSIGTYPE': 'void',
 'RUNSHARED': '',
 'SCRIPTDIR': '//lib',
 'SCRIPT_2TO3': 'build/scripts-3.12/2to3-3.12',
 'SCRIPT_IDLE': 'build/scripts-3.12/idle3.12',
 'SCRIPT_PYDOC': 'build/scripts-3.12/pydoc3.12',
 'SHAREDMODS': 'Modules/_testimportmultiple.cpython-312-wasm32-wasi.so '
               'Modules/_testmultiphase.cpython-312-wasm32-wasi.so '
               'Modules/_testsinglephase.cpython-312-wasm32-wasi.so '
               'Modules/xxlimited.cpython-312-wasm32-wasi.so '
               'Modules/xxlimited_35.cpython-312-wasm32-wasi.so',
 'SHELL': '/bin/sh -e',
 'SHLIBS': '-ldl  -lwasi-emulated-signal -lwasi-emulated-getpid '
           '-lwasi-emulated-process-clocks -lpthread',
 'SHLIB_SUFFIX': '.so',
 'SITEPATH': '',
 'SIZEOF_DOUBLE': 8,
 'SIZEOF_FLOAT': 4,
 'SIZEOF_INT': 4,
 'SIZEOF_LONG': 4,
 'SIZEOF_LONG_LONG': 8,
 'SIZEOF_PID_T': 'SIZEOF_INT',
 'SIZEOF_SHORT': 2,
 'SIZEOF_WCHAR_T': 2,
 'SIZEOF__BOOL': 1,
 'SOABI': 'cpython-312-wasm32-wasi',
 'SRCDIRS': 'Modules   Modules/_blake2   Modules/_ctypes   Modules/_decimal   '
            'Modules/_decimal/libmpdec   Modules/_hacl   Modules/_io   '
            'Modules/_multiprocessing   Modules/_sqlite   Modules/_sre   '
            'Modules/_testcapi   Modules/_xxtestfuzz   Modules/cjkcodecs   '
            'Modules/expat   Objects   Parser   Programs   Python   '
            'Python/frozen_modules   Python/deepfreeze',
 'SRC_GDB_HOOKS': './Tools/gdb/libpython.py',
 'STATIC_LIBPYTHON': 1,
 'STDC_HEADERS': 1,
 'STRIPFLAG': '-s',
 'SUBDIRS': '',
 'SUBDIRSTOO': 'Include Lib Misc',
 'SYSDIR': 0,
 'SYSLIBS': '-lm',
 'SYSNDIR': 0,
 'SYS_SELECT_WITH_SYS_TIME': 0,
 'TESTOPTS': '',
 'TESTPATH': '',
 'TESTPYTHON': "_PYTHON_HOSTRUNNER='wasmtime run --env PYTHONPATH=/$(shell "
               'realpath --relative-to '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2)/$(shell cat '
               "pybuilddir.txt):/Lib --mapdir /::. --' "
               '_PYTHON_PROJECT_BASE=C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
               '_PYTHON_HOST_PLATFORM=$(_PYTHON_HOST_PLATFORM) '
               'PYTHONPATH=$(shell test -f pybuilddir.txt && echo '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2/`cat '
               'pybuilddir.txt`:)./Lib '
               '_PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata__wasi_wasm32-wasi '
               'C:/stupidspeed/temp/cpython-wasm/py312/python.exe',
 'TESTPYTHONOPTS': '',
 'TESTRUNNER': "_PYTHON_HOSTRUNNER='wasmtime run --env PYTHONPATH=/$(shell "
               'realpath --relative-to '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2)/$(shell cat '
               "pybuilddir.txt):/Lib --mapdir /::. --' "
               '_PYTHON_PROJECT_BASE=C:/stupidspeed/temp/cpython-wasm/Python-3.12.2 '
               '_PYTHON_HOST_PLATFORM=$(_PYTHON_HOST_PLATFORM) '
               'PYTHONPATH=$(shell test -f pybuilddir.txt && echo '
               'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2/`cat '
               'pybuilddir.txt`:)./Lib '
               '_PYTHON_SYSCONFIGDATA_NAME=_sysconfigdata__wasi_wasm32-wasi '
               'C:/stupidspeed/temp/cpython-wasm/py312/python.exe '
               './Tools/scripts/run_tests.py',
 'TESTSUBDIRS': 'idlelib/idle_test \\',
 'TESTTIMEOUT': 1200,
 'TEST_MODULES': 'yes',
 'TIME_WITH_SYS_TIME': 0,
 'TZPATH': '/usr/share/zoneinfo:/usr/lib/zoneinfo:/usr/share/lib/zoneinfo:/etc/zoneinfo',
 'UNICODE_DEPS': '\\',
 'UNIVERSALSDK': '',
 'UPDATE_FILE': './Tools/build/update_file.py',
 'VERSION': '3.12',
 'VOID_CLOSEDIR': 0,
 'WASM_ASSETS_DIR': './',
 'WASM_STDLIB': './/lib/python3.12/os.py',
 'WHEEL_PKG_DIR': '',
 'WINVER': 'Py_WINVER',
 'WITH_DECIMAL_CONTEXTVAR': 1,
 'WITH_DOC_STRINGS': 1,
 'WITH_FREELISTS': 1,
 'WITH_PYMALLOC': 1,
 'WITH_THREAD': 0,
 'WORD_BIT': 32,
 'XMLLIBSUBDIRS': 'xml xml/dom xml/etree xml/parsers xml/sax',
 'abs_builddir': 'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2',
 'abs_srcdir': 'C:/stupidspeed/temp/cpython-wasm/Python-3.12.2',
 'datarootdir': '//share',
 'exec_prefix': '/',
 'prefix': '/',
 'srcdir': '.'}
