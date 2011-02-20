include ../../arch.make

# lev
PBS_URL=http://www.clusterresources.com/downloads/torque/torque-2.4.12.tar.gz
PBS_TGZ=torque.tgz

.PHONY: all pbs torque

all: pbs

pbs:
	if ! test -d ./pbs;then \
	  if ! test -f $(PBS_TGZ);then \
	    $(DL) -O $(PBS_TGZ) $(PBS_URL);fi; \
	  $(TAR) xvzf $(PBS_TGZ); \
	  mv torque-* torque; \
	fi

torque:
	cd ./torque; ./configure --prefix=/opt/local; make

clean:
	rm -fR ./torque
	rm *.tar.gz *.tgz

