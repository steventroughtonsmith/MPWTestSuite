App      = IIGSCTest
ObjectFiles  = IIGSCTest.c.o

MPW ?= mpw

all: $(App)

$(App) :$(ObjectFiles)
	$(MPW) LinkIIGS -t S16 \
		"{CIIGSLibraries}"Start.obj \
		$(ObjectFiles) \
		-lib "{CIIGSLibraries}"CLib \
		-o "$(App)"

%.c.o : %.c
	$(MPW) CIIGS $< -o $@

clean:
	rm -f $(App) $(ObjectFiles)
