App			= IIGSPascalTest
ObjectFiles	= IIGSPascalTest.p.o

MPW ?= mpw

all: $(App)

$(App) :$(ObjectFiles)
	$(MPW) LinkIIGS \
		"{PIIGSLibraries}"/Pstart.Obj \
		$(ObjectFiles) \
		-lib "{PIIGSLibraries}"PLib \
		-o "$(App)"
	$(MPW) DuplicateIIGS -y -mac "$(App)" "$(App)"

%.p.o : %.p
	$(MPW) PascalIIGS  $< -o $@

clean:
	rm -f $(App) $(ObjectFiles)
