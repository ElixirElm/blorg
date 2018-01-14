OUTPUT_DIR = ../vendor/
SOURCE_E4_DIR=./sources/
TARGET_ELM_DIR=./output/

js: $(OUTPUT_DIR)Blorg/App.js #List all the outputs here if more than one

ELM=elm
ELM_MAKE_FLAGS =

RELM_MACROS_DIR = $(SOURCE_E4_DIR)RELM/Macros/
E4_SRC = $(shell find $(SOURCE_E4_DIR) -type f -name '*.e4')
M4_DEFS = $(shell find $(RELM_MACROS_DIR) -type f -name '*.e4')
ELM_TARGETS=$(E4_SRC:$(SOURCE_E4_DIR)%.e4=$(TARGET_ELM_DIR)%.elm)

ELM_SRC = $(shell find $(SOURCE_E4_DIR) -type f -name '*.elm')
ELM_TARGETS2=$(ELM_SRC:$(SOURCE_E4_DIR)%.elm=$(TARGET_ELM_DIR)%.elm)

$(OUTPUT_DIR)%.js: $(ELM_TARGETS) $(ELM_TARGETS2)
	mkdir -p $(dir $(OUTPUT_DIR)$*.js)
	$(ELM)-make $(ELM_MAKE_FLAGS) $(TARGET_ELM_DIR)$*.elm --output $(OUTPUT_DIR)$*.js

elm: $(ELM_TARGETS) $(ELM_TARGETS2)

.SUFFIXES: .e4 .elm      # Add .h.in and .h as suffixes

M4       = m4
M4_FLAGS = -I $(RELM_MACROS_DIR) -d
M4SCRIPT =

$(TARGET_ELM_DIR)%.elm:	$(SOURCE_E4_DIR)%.e4 $(M4_DEFS)
	mkdir -p $(dir $(TARGET_ELM_DIR)$*.elm)
	${M4} ${M4_FLAGS} ${M4SCRIPT} $< > $(TARGET_ELM_DIR)$*.elm

.PHONY: clean
clean:
	-rm $(ELM_TARGETS)
