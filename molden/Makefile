include ../arch.make

# lev
MLD_URL=ftp://ftp.cmbi.ru.nl/pub/molgraph/molden/molden5.0.tar.gz
MLD_TGZ=molden.tgz

.PHONY: all molden

all: molden

molden:
	if ! test -d ./src;then \
	  if ! test -f $(MLD_TGZ);then \
	    $(DL) -O $(MLD_TGZ) $(MLD_URL);fi; \
	  $(TAR) xvzf $(MLD_TGZ); \
	  mv ./molden?.? ./src; \
	  cd ./src; make fi

clean:
	rm -fR ./src
	rm *.tar.gz *.tgz

