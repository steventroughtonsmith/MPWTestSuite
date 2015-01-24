#
# Requires https://github.com/ksherlock/mpw and an
# install of MPW in the emulator's root (~/mpw)
# Uses modern (Xcode) version of Rez
#

# Location of your mpw binary
MPW ?= mpw

RINCLUDES=/Applications/MPW-GM/Interfaces\&Libraries/Interfaces/RIncludes

LDFLAGS =-w -c 'MPS ' -t APPL \
	-sn STDIO=Main -sn INTENV=Main -sn %A5Init=Main

LIBRARIES={Libraries}Stubs.o \
	{Libraries}MacRuntime.o \
	{Libraries}IntEnv.o \
	{Libraries}ObjLib.o \
	{Libraries}Interface.o \
	{Libraries}ToolLibs.o \
	{CLibraries}StdCLib.o \
	{PLibraries}PasLib.o

SOURCES=MacPascalTest.p

OBJECTS=$(SOURCES:.p=.o)

EXECUTABLE=MacPascalTest
RFILES=MacPascalTest.r

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(MPW) link $(LDFLAGS) $(OBJECTS) $(LIBRARIES) -o $@
	Rez -rd $(RFILES) -o $@ -i $(RINCLUDES) -append

%.o : %.p
		$(MPW) Pascal -n -h $< -o $@

clean:
	rm -rf *.o $(EXECUTABLE)
