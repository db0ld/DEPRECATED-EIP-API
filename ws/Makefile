## ########################################################################## ##
## Project: La Vie Est Un Jeu - API                                           ##
## Description: Makefile compiling the API                                    ##
## Author: db0 (db0company@gmail.com, http://db0.fr/)                         ##
## Latest Version is on GitHub: https://github.com/LaVieEstUnJeu/API          ##
## ########################################################################## ##

## Packages required to build the project
SRC_PACKAGES := calendar yojson macaque.syntax str

## Source files
SRC_FILES    := 		\
		valid.ml	\
		otools.ml	\
		apiRsp.ml	\
		jsonTools.ml	\
		apiTypes.ml	\
		eliomJson.ml	\
		db.ml		\
		userTable.ml	\
		auth.ml		\
		user.ml		\
		achievement.ml	\
		achievementTable.ml	\

## Required binaries
ELIOMC      := eliomc
ELIOMOPT    := eliomopt
ELIOMDEP    := eliomdep

## Where to put intermediate object files.
export ELIOM_SRC_DIR  := _server
export ELIOM_TYPE_DIR := .

#####################################

all: byte
byte:: ${APP_NAME}.cma
opt:: ${APP_NAME}.cmxs

#### Compilation #######

SRC_INC  := ${addprefix -package ,${SRC_PACKAGES}}

SRC_OBJS := $(patsubst %.eliom,${ELIOM_SRC_DIR}/%.cmo, ${SRC_FILES})
SRC_OBJS := $(patsubst %.ml,${ELIOM_SRC_DIR}/%.cmo, ${SRC_OBJS})

${APP_NAME}.cma: ${SRC_OBJS}
	${ELIOMC} -a -o $@ $^
${APP_NAME}.cmxa: ${SRC_OBJS:.cmo=.cmx}
	${ELIOMOPT} -a -o $@ $^

${ELIOM_TYPE_DIR}/%.type_mli: %.eliom
	${ELIOMC} -infer ${SRC_INC} $<

${ELIOM_SRC_DIR}/%.cmi: %.mli
	${ELIOMC} -c ${SRC_INC} $<

${ELIOM_SRC_DIR}/%.cmo: %.ml
	${ELIOMC} -c ${SRC_INC} $<
${ELIOM_SRC_DIR}/%.cmo: %.eliom
	${ELIOMC} -c -noinfer ${SRC_INC} $<

${ELIOM_SRC_DIR}/%.cmx: %.ml
	${ELIOMOPT} -c ${SRC_INC} $<
${ELIOM_SRC_DIR}/%.cmx: %.eliom
	${ELIOMOPT} -c -noinfer ${SRC_INC} $<

%.cmxs: %.cmxa
	$(ELIOMOPT) -shared -linkall -o $@ $<

############

## Clean up

clean:
	-rm -f *.cm[ioax] *.cmxa *.cmxs *.o *.a *.annot
	-rm -f *.type_mli
	-rm -rf ${ELIOM_SRC_DIR}

distclean: clean.local
	-rm -f *~ \#* .\#*

## Dependencies

depend: .depend
.depend: ${SRC_FILES}
	$(ELIOMDEP) -server ${SRC_INC} ${SRC_FILES} > .depend

## Warning: Dependencies towards *.eliom are not handled by eliomdep yet.

include .depend

