# SRC = $(wildcard web/elm/*.elm.m4 web/elm/**/*.elm.m4)
ELMSRCDIR=web/elm-m4
ELMTRGDIR=web/elm


ELMSRC = $(shell find $(ELMSRCDIR) -type f -name '*.elm-m4')
M4DEFS = $(shell find $(ELMSRCDIR)/m4-def -type f -name '*.m4')
ELMTARGETS=$(ELMSRC:$(ELMSRCDIR)%.elm-m4=$(ELMTRGDIR)%.elm)
elm: $(ELMTARGETS) $(M4DEFS)

.SUFFIXES: .elm-m4 .elm      # Add .h.in and .h as suffixes

M4       = m4
M4FLAGS  = -I $(ELMSRCDIR)/m4-def/
M4SCRIPT =

$(ELMTRGDIR)%.elm:	$(ELMSRCDIR)%.elm-m4
	mkdir -p $(dir $(ELMTRGDIR)$*.elm)
	${M4} ${M4FLAGS} ${M4SCRIPT} $< > $(ELMTRGDIR)$*.elm
