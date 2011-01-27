include ../arch.make

# lev
LEV_URL=http://www.cmmp.ucl.ac.uk/~lev/codes/lev00/lev00_3.21-forusers.tgz
LEV_TGZ=lev00.tgz

# tetr
TET_URL=http://www.cmmp.ucl.ac.uk/~lev/codes/lev00/tetr_4.5-forusers.tgz
TET_TGZ=tetr.tgz


.PHONY: all lev tetr

all: lev tetr

lev:
	if ! test -d ./lev00;then \
	  if ! test -f $(LEV_TGZ);then \
	    $(DL) -O $(LEV_TGZ) $(LEV_URL);fi; \
	  $(TAR) xvzf $(LEV_TGZ); \
	  mv ./*lev00_* ./lev00; fi

tetr:
	if ! test -d ./tetr;then \
	  if ! test -f $(TET_TGZ);then \
	    $(DL) -O $(TET_TGZ) $(TET_URL);fi; \
	  $(TAR) xvzf $(TET_TGZ); \
	  mv ./*tetr_* ./tetr; fi

clean:
	rm -fR ./lev00
	rm -fR ./tetr
	rm *.tar.gz *.tgz lev00 tetr

