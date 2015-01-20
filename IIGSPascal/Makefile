App			= IIGSPascalTest
ObjectFiles	= IIGSPascalTest.p.o

all: $(App)

$(App) :$(ObjectFiles)
	mpw LinkIIGS \
		"{PIIGSLibraries}"/Pstart.Obj \
		$(ObjectFiles) \
		-lib "{PIIGSLibraries}"PLib \
		-o "$(App)"
	mpw DuplicateIIGS -y -mac "$(App)" "$(App)"

%.p.o : %.p
	mpw PascalIIGS  $< -o $@

clean:
	rm -f $(App) $(ObjectFiles)