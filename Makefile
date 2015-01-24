all:
	make -C MacC all
	make -C MacPascal all
	make -C IIGSPascal all
	make -C IIGSC all

clean:
	make -C MacC clean
	make -C MacPascal clean
	make -C IIGSPascal clean
	make -C IIGSC clean
