#	File MakeFile -  Make instructions for C examples.
#
#	Copyright Apple Computer, Inc. 1986-1995, 1998
#	All rights reserved.
#
#	This makefile builds:
#		The sample C tool:				Count
#		The sample desk accessory:		Memory
#		The sample performance tool:	TestPerf
#		The sample CDev:				EditCDev
#		The sample application:			Sample
#		The sample application:			SillyBalls
#		The sample application:			TubeTest
#		The sample TE application:		TESample
#

# 	You can define $(SymOptions) as "-sym on" or "-sym off" for use with SADE
# 	We also recommend requiring prototypes for all functions

RINCLUDES=/Applications/MPW-GM/Interfaces\&Libraries/Interfaces/RIncludes
SymOptions	=	-sym Full
SymOpt		=	$(SymOptions)
COptions	=	-w 17 -proto strict $(SymOpt) -D OLDROUTINELOCATIONS=0
MrCOptions	=	$(SymOpt) -D OLDROUTINELOCATIONS=0

# The following variable is used to define the ROM map file used by the
# TestPerf component.  If necessary, you can change this to point to the
# proper location of your machine's ROM map.

RomMapLoc	=	"$(MPW)ROM Maps:"
#RomMap	  	=	Macgestalt mach -sROM.map


# Dummy rule for building all of the samples 

all : Count Memory TestPerf EditCDev Sample SillyBalls TESample TubeTest

#######################################################################
# Build instructions and dependencies for the Count tool
#

VERSION	= "3.4d2"
MPW ?= mpw

%.c.o: %.c
	$(MPW)  SC $< -o $@ $(COptions)

%.c.ppc.o: %.c
	$(MPW)  MrC $< -o $@ $(MrCOptions)

%.a.o: %.a
	$(MPW)  asm $< -o $@

Count : Count.68k Count.ppc
	$(MPW) duplicate -y Count.ppc $@
	$(MPW) duplicate -y -r Count.68k $@
	Rez -i $(RINCLUDES) Count.r	GenericCFRG.r -o Count -append -d APPNAME=\"Count\"
	#$(MPW) SetVersion -t 'vers' -i 1 -version "$(VERSION)" Count
	$(MPW) SetFile -m . -c 'MPS ' -t MPST Count

Count.ppc :	Count.c.ppc.o Count.r	GenericCFRG.r
	$(MPW) PPCLink -d -c 'MPS ' -t MPST $(SymOpt) \
		Count.c.ppc.o \
		"{SharedLibraries}"StdCLib \
		"{SharedLibraries}"InterfaceLib \
		"{PPCLibraries}"StdCRuntime.o \
		"{PPCLibraries}"PPCCRuntime.o \
		"{PPCLibraries}"PPCToolLibs.o \
		-o $@

Count.68k : Count.c.o Count.r	GenericCFRG.r
	$(MPW) Link -d -c 'MPS ' -t MPST $(SymOpt) -mf \
		Count.c.o \
		"{CLibraries}"StdClib.o \
		"{Libraries}"Stubs.o \
		"{Libraries}"IntEnv.o \
		"{Libraries}"MacRuntime.o \
		"{Libraries}"Interface.o \
		"{Libraries}"ToolLibs.o \
		-o $@


#######################################################################
# Build instructions and dependencies for the Memory desk accessory
#

#	The following two variables define the creator and type for the
#	Memory Desk Accessory.  For System 6 compatibility, the build
#	instructions should create a "Suitcase" file containing the DA.
#	Suitcase files have a creator of 'DMOV' and a type of 'DFIL'.  For
#	System 7 and newer, DA's can exist all by themselves, without being
#	wrapped in the "womb" of the Suitcase file.  This makes it easier
#	to manipulate the DA file, since the Suitcase doesn't have to be
#	opened first.  DA's can be treated just like any other application.
#	In this case, the creator should be 'movr' and the type should be
#	'dfil' (note the difference in character case).

DACreator	='movr'
DAType		='dfil'

Memory			:	Memory.c.o DAEntry.a.o
	$(MPW)  Link $(SymOptions) -da -rt DRVR=12 \
		-m DAEntry -sg Memory DAEntry.a.o "{Libraries}"DRVRRuntime.o \
		Memory.c.o "{Libraries}"MacRuntime.o "{Libraries}"Interface.o \
		-o Memory -c $(DACreator) -t $(DAType)
		Rez -i $(RINCLUDES) -rd -c $(DACreator) -t $(DAType) Memory.r -a -o Memory

Memory.NOASM		:	Memory.DRVW Memory.r
	Rez -i $(RINCLUDES) -rd -c $(DACreator) -t $(DAType) -d NOASM_BUILD Memory.r -o Memory.NOASM
	$(MPW) Duplicate -y Memory.NOASM Memory

Memory.DRVW 	:	Memory.c.o
	$(MPW) Link -w -rt DRVW=0 \
		-sg Memory \
		"{Libraries}"DRVRRuntime.o \
		Memory.c.o \
		"{Libraries}"IntEnv.o \
		"{Libraries}"MacRuntime.o \
		"{Libraries}"Interface.o \
		-o Memory.DRVW -c "????" -t "????"


#######################################################################
# Build instructions and dependencies for the TestPerf tool
#
# Warning:  this sample won't build for machines which do not
# have ROM maps (Power Macintoshes being notable examples).

TestPerf	:	TestPerf.c.o
	$(MPW) Link -d \
		-o TestPerf -t MPST -c 'MPS ' \
		-l -la > TestPerf.map  \
		TestPerf.c.o "{Libraries}"PerformLib.o \
		"{Libraries}"Interface.o \
		"{Libraries}"IntEnv.o \
		"{Libraries}"MacRuntime.o \
		"{CLibraries}"StdCLib.o
#mpw Set ThisDir `Directory`
#mpw Directory "$(RomMapLoc)"
#mpw Make "$(RomMap)" >"$(TempFolder)Make.Out" && ("$(TempFolder)"Make.Out && Delete "$(TempFolder)Make.out") || set status 0
#	mpw Directory "$(ThisDir)"
#	mpw Unset ThisDir
#	mpw Catenate "$(RomMapLoc)$(ROMMap)" >> TestPerf.map ≥dev:null || set status 0


#######################################################################
# Build instructions and dependencies for the EditCDev cdev
#
#	EditCdev is a sample Control Panel device (cdev) that 
#	demonstrates the usage of the edit-related messages.  
#	EditCdev demonstrates how to implement an editText item
#	in a Control Panel Device.  It utilizes the new undo, cut, copy,
#	paste, and delete messages that are sent to cdevs in
#	response to user menu selections.
#
#	It is comprised of two editText items that can be edited 
#	and moved between via the mouse or tab key.
#

cdevObjs	= EditCdev.c.o
					
cdevLibs	= "{Libraries}"Interface.o

Destination = $(SystemFolder)Control Panels:
					
EditCDev:	$(cdevObjs)
	mpw Link -o $@ -rt cdev=-4064 -m TEXTCDEV $(cdevObjs) $(cdevLibs)
	Rez -i $(RINCLUDES) -o $@ EditCDev.r -t cdev -c hack -rd -append

			
#######################################################################
# Build instructions and dependencies for the Sample application
#			
#	Sample is an example application that demonstrates how to
#	initialize the commonly used toolbox managers, operate 
#	successfully under MultiFinder, handle desk accessories, 
#	and create, grow, and zoom windows.
#
#	It does not by any means demonstrate all the techniques 
#	you need for a large application. In particular, Sample 
#	does not cover exception handling, multiple windows/documents, 
#	sophisticated memory management, printing, or undo. All of 
#	these are vital parts of a normal full-sized application.
#
#	This application is an example of the form of a Macintosh 
#	application; it is NOT a template. It is NOT intended to be 
#	used as a foundation for the next world-class, best-selling, 
#	600K application. A stick figure drawing of the human body may 
#	be a good example of the form for a painting, but that does not 
#	mean it should be used as the basis for the next Mona Lisa.
#
#	We recommend that you review this program or TESample before 
#	beginning a new application.
#
# 	You can define $(SymOptions) as "-sym on" or "-sym off" for use with SADE
# 	We also recommend requiring prototypes for all functions
							
sampObjs	= Sample.c.o

sampLibs	= "{Libraries}"MacRuntime.o \
			  "{Libraries}"Interface.o
		
Sample		: $(sampObjs) Sample.r
	$(MPW) Link -o $@ $(sampObjs) $(sampLibs) $(SymOptions)
	Rez -i $(RINCLUDES) -rd -o $@ Sample.r -append
	$(MPW) SetFile $@ -t APPL -c 'MOOS' 



#######################################################################
# Build instructions and dependencies for the SillyBalls application
#	
#	This is a very simple sample program that demonstrates how to use Color 
#	QuickDraw.  It is about two pages of code, and does nothing more than open
#	a color window and draw randomly colored ovals in the window.
#	
#	The purpose is to show how to get some initial results with Color QuickDraw.
#	It is a complete program and is very short to be as clear as possible.
#	
#	It does not have an Event Loop.  It is not fully functional in the sense that
#	it does not do all the things you would expect a well behaved Macintosh 
#	program to do, like size the window naturally, have an event loop, use menus, 
#	etc.
#
#	See Sample and TESample for the general structure and MultiFinder techniques that
#	we recommend that you use when building a new application.
#
# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-proto strict' to your UserStartup when you tire of the warning from Make.

sillyObs		=	SillyBalls.c.o

sillyLibs		= "{Libraries}"Interface.o \
				  "{Libraries}"MacRuntime.o 

SillyBalls	:	$(sillyObs)
	mpw Link -o $@ $(sillyObs) $(sillyLibs) $(SymOptions)
	mpw SetFile $@ -t APPL -c '????'



#######################################################################
# Build instructions and dependencies for the TESample application
#	
#	TESample is an example application that demonstrates how 
#	to initialize the commonly used toolbox managers, operate 
#	successfully under MultiFinder, handle desk accessories and 
#	create, grow, and zoom windows. The fundamental TextEdit 
#	toolbox calls and TextEdit autoscroll are demonstrated. It 
#	also shows how to create and maintain scrollbar controls.
#
#	It does not by any means demonstrate all the techniques you 
#	need for a large application. In particular, Sample does not 
#	cover exception handling, multiple windows/documents, 
#	sophisticated memory management, printing, or undo. All of 
#	these are vital parts of a normal full-sized application.
#
#	This application is an example of the form of a Macintosh 
#	application; it is NOT a template. It is NOT intended to be 
#	used as a foundation for the next world-class, best-selling, 
#	600K application. A stick figure drawing of the human body may 
#	be a good example of the form for a painting, but that does not 
#	mean it should be used as the basis for the next Mona Lisa.
#
#	We recommend that you review this program or Sample before 
#	beginning a new application. Sample is a simple app. which doesn’t 
#	use TextEdit or the Control Manager.
#
# 	You can define $(SymOptions) as "-sym on" or "-sym off" for use with SADE
# 	We also recommend requiring prototypes for all functions

teObjs	= TESample.c.o \
		  TESampleGlue.a.o
			
teLibs	= "{Libraries}"MacRuntime.o \
		  "{Libraries}"Interface.o

TESample		: $(teObjs) TESample.r
	$(MPW) Link -o $@ $(teObjs) $(teLibs) $(SymOptions)
	Rez -i $(RINCLUDES) -rd -append -o $@ TESample.r
	$(MPW) SetFile $@ -t APPL -c 'MOOT' 



#######################################################################
# Build instructions and dependencies for the TubeTest application
#	
#	The TubeTest program is a simple demonstration of how to use the Palette 
#	Manager in a color program.  It has a special color palette that is associated
#	with the main window.  The colors are animated using the Palette Manager 
#	to give a flowing tube effect.  The program is very simple, and the Palette
#	Manager and drawing parts are put in separate subroutines to make it easier
#	to figure out what is happening.
#	
#	The program is still a complete Macintosh application with a Main Event Loop,
#	so there is the extra code to run the MEL.  
#	
#	There is a resource file that is necessary as well, to define the Menus, Window,
#	Dialog, and Palette resources used in the program.  
#
#	See Sample and TESample for the general structure and MultiFinder techniques that
#	we recommend that you use when building a new application.
#
# MPW 3.0 and later: We override the default COptions to turn on strict prototyping;
#	add '-r' to your UserStartup when you tire of the warning from Make.

tubeObjs	= TubeTest.c.o
					
tubeLibs 	= "{Libraries}"Interface.o \
			  "{Libraries}"MacRuntime.o 

TubeTest	:	$(tubeObjs) TubeTest.r
	$(MPW) Link -o $@ $(tubeObjs) $(tubeLibs)
	Rez -i $(RINCLUDES) -rd -o $@ TubeTest.r -append
	$(MPW) SetFile $@ -t APPL -c '????'

clean:
	rm -f *.SYM *.c.ppc.o *.c.o *.a.o *.xcoff Count.68k Count.ppc Count Memory TestPerf EditCDev Sample SillyBalls TubeTest TESample
