App      = IIGSCTest
ObjectFiles  = IIGSCTest.c.o

all: $(App)

$(App) :$(ObjectFiles)
	mpw LinkIIGS -t S16 \
		"{CIIGSLibraries}"Start.obj \
		$(ObjectFiles) \
		-lib "{CIIGSLibraries}"CLib \
		-o "$(App)"

%.c.o : %.c
	mpw CIIGS $< -o $@

clean:
	rm -f $(App) $(ObjectFiles)