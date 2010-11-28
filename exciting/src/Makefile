include arch.make

EXC_MASTER_GIT=git://github.com/exciting/exciting.git

EXC_HORNOS_GIT=git://github.com/hornos/exciting.git

.PHONY: clean master hornos

all: master hornos

master:
	if ! test -d ./exciting-master;then     \
	  $(GIT) clone $(EXC_MASTER_GIT) exciting-master; \
	else \
	  cd ./exciting-master; $(GIT) pull origin master; \
	fi

hornos:
	if ! test -d ./exciting-hornos;then     \
	  $(GIT) clone $(EXC_HORNOS_GIT) exciting-hornos; \
	else \
	  cd ./exciting-hornos; $(GIT) pull origin master; \
	fi

clean:
	rm -fR ./exciting-master
	rm -fR ./exciting-hornos
