INCLUDE_PATH =  -I"C:\stupidspeed\tools\eiffel\Eiffel_25.12\library\time\spec\include"
SHELL = /bin/sh
CC = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/gcc"
CPP = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/gcc"
CFLAGS = -O2 -pipe -imacros eif_config.mingw.h -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN $(ISE_CFLAGS)  -I"C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/spec/win64/include" -I. $(INCLUDE_PATH)
CPPFLAGS = -O2 -pipe -imacros eif_config.mingw.h -D_WIN32_WINNT=0x0500 -DWINVER=0x0500 -D_UNICODE -DUNICODE -DWIN32_LEAN_AND_MEAN $(ISE_CFLAGS)  -I"C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/spec/win64/include" -I. $(INCLUDE_PATH)
LDFLAGS = 
CCLDFLAGS =   -mconsole
LDSHAREDFLAGS =  
EIFLIB = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/spec/win64/lib/mingw/finalized.a"
EIFTEMPLATES = C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/config/win64/templates
LIBS = 
MAKE = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/make.exe"
AR = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/ar"
LD = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/ld"
MKDEP =   --
MV = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/cp"
CP = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/cp"
RANLIB = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/ranlib.exe"
RM = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/rm" -f
FILE_EXIST = 
RMDIR = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/rd"
X2C = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/spec/win64/bin/x2c.exe"
SHAREDLINK = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/dllwrap"
SHAREDLIBS = -luser32 -lws2_32 -ladvapi32 -lgdi32 -lshell32 -lmsimg32 -lcomdlg32 -luuid -lole32 -loleaut32 -lcomctl32 -lmpr -lshlwapi -lwinspool -lstdc++ $(ISE_SHAREDLIBS)
SHARED_SUFFIX = .dll
COMMAND_MAKEFILE = 
START_TEST = if [ ! -f finished ] ; then 
END_TEST = ; fi 
CREATE_TEST = "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/msys/1.0/bin/touch" finished
PATH := C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/libexec/gcc/x86_64-w64-mingw32/4.4.5;C:\stupidspeed\tools\eiffel\Eiffel_25.12\studio\spec\win64\bin;C:\Program Files\Common Files\Oracle\Java\javapath;C:\Program Files (x86)\Common Files\Oracle\Java\java8path;C:\Program Files (x86)\Common Files\Oracle\Java\javapath;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files (x86)\Bitvise SSH Client;C:\Program Files\PuTTY\;C:\Program Files\nodejs\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\dotnet\;C:\WINDOWS\system32\config\systemprofile\AppData\Local\Muse Hub\lib;C:\Program Files\Go\bin;C:\Program Files\Git\cmd;C:\stupidspeed\tools\fpc\bin\i386-Win32;C:\Users\pz020\.cargo\bin;C:\Users\pz020\AppData\Local\Programs\Python\Python313\Scripts\;C:\Users\pz020\AppData\Local\Programs\Python\Python313\;C:\Users\pz020\AppData\Local\Programs\Python\Launcher\;C:\Users\pz020\AppData\Local\Microsoft\WindowsApps;C:\Users\pz020\AppData\Roaming\npm;C:\Users\pz020\AppData\Local\Programs\Microsoft VS Code\bin;C:\Users\pz020\ffmpeg\bin;C:\Users\pz020\go\bin;C:\Users\pz020\OneDrive\Área de Trabalho\sqlite;C:\prompteer;C:\trademapper;C:\Users\pz020\AppData\Local\Programs\Zed\bin;C:\mingw64\bin;C:\Users\pz020\OneDrive\Documentos\speedblitz\target\release;C:\ripgrep;C:\Users\pz020\.bun\bin;C:\Users\pz020\.dotnet\tools;C:\Program Files\Git\bin;C:\Program Files\Git\usr\bin 
SYSTEM_IN_DYNAMIC_LIB = prog.dll 
.SUFFIXES: .x .xpp .cpp .o 

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $<

.x.o:
	$(X2C) $< $*.c
	$(CC) $(CFLAGS) -c $*.c
	$(RM) $*.c

.xpp.o:
	$(X2C) $< $*.cpp
	$(CPP) $(CPPFLAGS) -c $*.cpp
	$(RM) $*.cpp

.x.c:
	$(X2C) $< $*.c

.xpp.cpp:
	$(X2C) $< $*.cpp

SUBDIRS = C1 C2 C3 C4 C5 C6 C7 C8 C9 C10 C11 C12 C13 C14 C15 C16 C17 E1 E2

EXTERNALS = 

all:: prog.exe
	echo done > completed.eif

C1/Cobj1.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C1 && $(START_TEST) $(MAKE) Cobj1.o $(END_TEST) && cd ..

C2/Cobj2.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C2 && $(START_TEST) $(MAKE) Cobj2.o $(END_TEST) && cd ..

C3/Cobj3.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C3 && $(START_TEST) $(MAKE) Cobj3.o $(END_TEST) && cd ..

C4/Cobj4.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C4 && $(START_TEST) $(MAKE) Cobj4.o $(END_TEST) && cd ..

C5/Cobj5.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C5 && $(START_TEST) $(MAKE) Cobj5.o $(END_TEST) && cd ..

C6/Cobj6.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C6 && $(START_TEST) $(MAKE) Cobj6.o $(END_TEST) && cd ..

C7/Cobj7.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C7 && $(START_TEST) $(MAKE) Cobj7.o $(END_TEST) && cd ..

C8/Cobj8.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C8 && $(START_TEST) $(MAKE) Cobj8.o $(END_TEST) && cd ..

C9/Cobj9.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C9 && $(START_TEST) $(MAKE) Cobj9.o $(END_TEST) && cd ..

C10/Cobj10.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C10 && $(START_TEST) $(MAKE) Cobj10.o $(END_TEST) && cd ..

C11/Cobj11.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C11 && $(START_TEST) $(MAKE) Cobj11.o $(END_TEST) && cd ..

C12/Cobj12.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C12 && $(START_TEST) $(MAKE) Cobj12.o $(END_TEST) && cd ..

C13/Cobj13.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C13 && $(START_TEST) $(MAKE) Cobj13.o $(END_TEST) && cd ..

C14/Cobj14.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C14 && $(START_TEST) $(MAKE) Cobj14.o $(END_TEST) && cd ..

C15/Cobj15.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C15 && $(START_TEST) $(MAKE) Cobj15.o $(END_TEST) && cd ..

C16/Cobj16.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C16 && $(START_TEST) $(MAKE) Cobj16.o $(END_TEST) && cd ..

C17/Cobj17.o: Makefile E1/estructure.h E1/eoffsets.h
	cd C17 && $(START_TEST) $(MAKE) Cobj17.o $(END_TEST) && cd ..

E1/emain.o:  Makefile E1/Makefile
	$(CP) "$(EIFTEMPLATES)/emain.template" "E1/emain.c"
	cd E1 && $(START_TEST) $(MAKE) emain.o  $(END_TEST) && cd ..

E1/estructure.h: E1/estructure.x
	$(X2C) E1/estructure.x E1/estructure.h

E1/eoffsets.h: E1/eoffsets.x
	$(X2C) E1/eoffsets.x E1/eoffsets.h

E1/eref.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) eref.o  $(END_TEST) && cd ..

E1/epoly.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) epoly.o  $(END_TEST) && cd ..

E1/esize.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) esize.o  $(END_TEST) && cd ..

E1/eplug.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) eplug.o  $(END_TEST) && cd ..

E1/eskelet.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) eskelet.o  $(END_TEST) && cd ..

E1/enames.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) enames.o  $(END_TEST) && cd ..

E1/evisib.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) evisib.o  $(END_TEST) && cd ..

E1/ececil.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) ececil.o  $(END_TEST) && cd ..

E1/einit.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) einit.o  $(END_TEST) && cd ..

E1/eparents.o : Makefile E1/Makefile E1/estructure.h E1/eoffsets.h
	cd E1 && $(START_TEST) $(MAKE) eparents.o  $(END_TEST) && cd ..

E2/Eobj2.o: Makefile E1/estructure.h E1/eoffsets.h
	cd E2 && $(START_TEST) $(MAKE) Eobj2.o $(END_TEST) && cd ..

OBJECTS = E2/Eobj2.o E1/eparents.o  E1/einit.o  E1/ececil.o  E1/evisib.o  E1/enames.o  E1/eskelet.o  E1/eplug.o  E1/esize.o  E1/epoly.o  E1/eref.o  C17/Cobj17.o C16/Cobj16.o C15/Cobj15.o C14/Cobj14.o C13/Cobj13.o C12/Cobj12.o C11/Cobj11.o C10/Cobj10.o C9/Cobj9.o C8/Cobj8.o C7/Cobj7.o C6/Cobj6.o C5/Cobj5.o C4/Cobj4.o C3/Cobj3.o C2/Cobj2.o C1/Cobj1.o 

C_OBJECTS = C17/Cobj17.o C16/Cobj16.o C15/Cobj15.o C14/Cobj14.o C13/Cobj13.o C12/Cobj12.o C11/Cobj11.o C10/Cobj10.o C9/Cobj9.o C8/Cobj8.o C7/Cobj7.o C6/Cobj6.o C5/Cobj5.o C4/Cobj4.o C3/Cobj3.o C2/Cobj2.o C1/Cobj1.o 

EOBJECTS = E2/Eobj2.o E1/eparents.o  E1/einit.o  E1/ececil.o  E1/evisib.o  E1/enames.o  E1/eskelet.o  E1/eplug.o  E1/esize.o  E1/epoly.o  E1/eref.o  




prog.exe: E1/emain.o $(OBJECTS) prog.res 
	$(COMMAND_MAKEFILE)
	$(RM) $@
	$(CC) $(LDFLAGS) $(CCLDFLAGS) -o prog.exe E1/emain.o $(PRECOMP_OBJECTS) prog.res $(OBJECTS)  $(EIFLIB) -luser32 -lws2_32 -ladvapi32 -lgdi32 -lshell32 -lmsimg32 -lcomdlg32 -luuid -lole32 -loleaut32 -lcomctl32 -lmpr -lshlwapi -lwinspool -lstdc++ $(ISE_SHAREDLIBS)

../../../prog.rc:
	if [ ! -f ../../../prog.rc ] ; then $(MV) "C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/config/win64/mingw/eiffel.rc" ../../../prog.rc ; fi 

prog.res: ../../../prog.rc Makefile
	"C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/windres" --preprocessor='"C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/cpp.exe"' -I../../.. ../../../prog.rc -O coff -o prog.res

RCECIL = malloc.o garcol.o local.o except.o store.o retrieve.o hash.o \
	traverse.o hashin.o tools.o internal.o plug.o copy.o equal.o \
	lmalloc.o out.o timer.o urgent.o sig.o hector.o cecil.o file.o dir.o \
	misc.o error.o umain.o memory.o argv.o boolstr.o search.o main.o \
	run_idr.o compress.o console.o path_name.o object_id.o option.o \
	eif_threads.o gen_conf.o eif_type_id.o rout_obj.o eif_project.o \
	idrs.o posix_threads.o memory_analyzer.o offset.o 


#STATIC_CECIL PART
STATIC_CECIL = libprog.o
cecil: $(STATIC_CECIL)
$(STATIC_CECIL): $(OBJECTS)
	$(AR) x $(EIFLIB)
	$(AR) rc $(STATIC_CECIL) $(OBJECTS) $(EXTERNALS) $(PRECOMP_OBJECTS) $(RCECIL)
	$(RANLIB) $(STATIC_CECIL)
	$(RM) $(RCECIL)



#SHARED_CECIL PART
SHARED_CECIL = libprog$(SHARED_SUFFIX)
dynamic_cecil: $(SHARED_CECIL) 
DEF_FILE= c_prog.def 
c_prog.def: 
	$(RM) $@
	@echo LIBRARY libprog.dll > $@
	@type "C:\stupidspeed\tools\eiffel\Eiffel_25.12/studio/config/win64/templates/cecil.def" >> $@

SHARED_CECIL_OBJECT = $(OBJECTS) \
		E1/emain.o
SHAREDFLAGS = $(LDSHAREDFLAGS) \
\
	--dlltool-name "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/dlltool" \
	--as "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/as" \
	--def $(DEF_FILE) --output-lib c_dll_prog.lib -o $(SHARED_CECIL)

$(SHARED_CECIL): $(SHARED_CECIL_OBJECT)  $(DEF_FILE)
	if [ -f $(SHARED_CECIL) ] ; then $(RM) $(SHARED_CECIL) ; fi
	$(SHAREDLINK) $(SHAREDFLAGS) $(SHARED_CECIL_OBJECT) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) 

#SYSTEM_IN_DYNAMIC_LIB PART

DEF_FILE= prog.def
dynlib: $(SYSTEM_IN_DYNAMIC_LIB) 
E1/egc_dynlib.o: Makefile E1/Makefile
	$(CP) "$(EIFTEMPLATES)/egc_dynlib.template" E1/egc_dynlib.c
	cd E1 && $(MAKE) egc_dynlib.o && cd ..
E1/edynlib.o: Makefile E1/Makefile E1/edynlib.c 
	cd E1 && $(MAKE) edynlib.o && cd ..

SYSTEM_IN_DYNAMIC_LIB_OBJ = $(OBJECTS) \
		E1/edynlib.o E1/egc_dynlib.o 
DYNLIBSHAREDFLAGS = $(LDSHAREDFLAGS) \
\
	--dlltool-name "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/dlltool" \
	--as "C:\stupidspeed\tools\eiffel\Eiffel_25.12/gcc/win64/mingw/bin/as" \
	--def $(DEF_FILE) --output-lib dll_prog.lib -o $(SYSTEM_IN_DYNAMIC_LIB)

$(SYSTEM_IN_DYNAMIC_LIB): $(SYSTEM_IN_DYNAMIC_LIB_OBJ)  $(DEF_FILE)
	if [ -f $(SYSTEM_IN_DYNAMIC_LIB) ] ; then $(RM) $(SYSTEM_IN_DYNAMIC_LIB) ; fi
	$(SHAREDLINK) $(DYNLIBSHAREDFLAGS) $(SYSTEM_IN_DYNAMIC_LIB_OBJ) $(PRECOMP_OBJECTS) $(EXTERNALS) $(EIFLIB) $(SHAREDLIBS) 



clean: sub_clean local_clean
clobber: sub_clobber local_clobber

local_clean::
	$(RM) core finished *.o *.so *.a

local_clobber:: local_clean
	$(RM) Makefile config.sh finish_freezing

sub_clean::
	for i in $(SUBDIRS); \
	do \
		if [ -r $$i/Makefile ]; then \
			(cd $$i ; $(MAKE) clean); \
		fi; \
	done

sub_clobber::
	for i in $(SUBDIRS); \
	do \
		if [ -r $$i/Makefile ]; then \
			(cd $$i ; $(MAKE) clobber); \
		fi; \
	done

