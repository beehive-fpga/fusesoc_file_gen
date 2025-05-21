# Check the right variables are set
ifndef FLIST_NAME
	$(error FLIST_NAME is not set)
endif
$(info FLIST_NAME is $(FLIST_NAME))

ifndef TOP_CORE_NAME
	$(error TOP_CORE_NAME is not set)
endif
$(info TOP_CORE_NAME is $(TOP_CORE_NAME))

TOP_CORE_NAME_DIR := $(subst :,_,$(TOP_CORE_NAME))
$(info TOP_CORE_NAME_DIR is $(TOP_CORE_NAME_DIR))

# Determine the directory of this Makefile
THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
THIS_DIR := $(dir $(THIS_MAKEFILE))


.PHONY: gen_filelist
gen_filelist:
	fusesoc --config=$(PWD)/fusesoc.conf run --setup --target=sim --no-export $(TOP_CORE_NAME)
	python3 $(THIS_DIR)/generate_filelist.py --target=flist \
		--edam_file=$(PWD)/build/$(TOP_CORE_NAME_DIR)_0.1/sim-modelsim/$(TOP_CORE_NAME_DIR)_0.1.eda.yml \
		--output_file=$(FLIST_NAME)