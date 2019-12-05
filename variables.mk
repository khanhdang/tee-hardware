#########################################################################################
# makefile variables shared across multiple makefiles
# This file is copied from chipyard/variables.mk
# Changes:
#   - keystoneAcc as the default
#   - Remove the example (example depends deeply on chipyard)
#   - Make ROCKETCHIP_DIR, TESTCHIP_DIR, CHIPYARD_FIRRTL_DIR configurable
#########################################################################################

#########################################################################################
# variables to invoke the generator
# descriptions:
#   SBT_PROJECT = the SBT project that you should find the classes/packages in
#   MODEL = the top level module of the project in Chisel (normally the harness)
#   VLOG_MODEL = the top level module of the project in Firrtl/Verilog (normally the harness)
#   MODEL_PACKAGE = the scala package to find the MODEL in
#   CONFIG = the configuration class to give the parameters for the project
#   CONFIG_PACKAGE = the scala package to find the CONFIG class
#   GENERATOR_PACKAGE = the scala package to find the Generator class in
#   TB = wrapper over the TestHarness needed to simulate in a verilog simulator
#   TOP = top level module of the project (normally the module instantiated by the harness)
#
# project specific:
# 	SUB_PROJECT = use the specific subproject default variables
#########################################################################################

#########################################################################################
# subproject overrides
# description:
#   - make it so that you only change 1 param to change most or all of them!
#   - mainly intended for quick developer setup for common flags
#########################################################################################
SUB_PROJECT ?= keystoneAcc

KEYSTONE_ACC_DIR ?= $(base_dir)/hardware/keystoneAcc
SHA3_DIR ?= $(KEYSTONE_ACC_DIR)/vsrc/sha3
SHA3_HIGHPERF_DIR ?= $(SHA3_DIR)/trunk/high_throughput_core
ED25519_DIR ?= $(KEYSTONE_ACC_DIR)/vsrc/ed25519
ED25519_SIGN_DIR ?= $(KEYSTONE_ACC_DIR)/vsrc/ed25519_sign
AES_DIR ?= $(KEYSTONE_ACC_DIR)/vsrc/aes

ifeq ($(SUB_PROJECT),keystoneAcc)
	SBT_PROJECT       ?= keystoneAcc
	MODEL             ?= TestHarness
	VLOG_MODEL        ?= TestHarness
	MODEL_PACKAGE     ?= uec.keystoneAcc.exampletop
	CONFIG            ?= KeystoneDefaultConfig
	CONFIG_PACKAGE    ?= uec.keystoneAcc.exampletop
	GENERATOR_PACKAGE ?= uec.keystoneAcc.exampletop
	TB                ?= TestDriver
	TOP               ?= ExampleRocketSystem
	ADD_VSRC          ?= $(SHA3_HIGHPERF_DIR)/rtl/f_permutation.v \
	$(SHA3_HIGHPERF_DIR)/rtl/round2in1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/keccak.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder.v \
	$(SHA3_HIGHPERF_DIR)/rtl/rconst2in1.v \
	$(ED25519_DIR)/rtl/mac16_generic.v \
	$(ED25519_DIR)/rtl/ed25519_microcode_rom.v \
	$(ED25519_DIR)/rtl/ed25519_operand_bank.v \
	$(ED25519_DIR)/rtl/adder47_generic.v \
	$(ED25519_DIR)/rtl/ed25519_uop_worker.v \
	$(ED25519_DIR)/rtl/subtractor32_generic.v \
	$(ED25519_DIR)/rtl/ed25519_wrapper.v \
	$(ED25519_DIR)/rtl/ed25519_core_top.v \
	$(ED25519_DIR)/rtl/bram_1rw_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1rw_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1wo_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/ed25519_base_point_multiplier.v \
	$(ED25519_DIR)/rtl/curve25519_modular_multiplier.v \
	$(ED25519_DIR)/rtl/ed25519_banks_array.v \
	$(ED25519_DIR)/rtl/modular_adder.v \
	$(ED25519_DIR)/rtl/modular_subtractor.v \
	$(ED25519_DIR)/rtl/adder32_generic.v \
	$(ED25519_DIR)/rtl/multiword_mover.v \
	$(ED25519_SIGN_DIR)/src/rtl/ed25519_sign_core_S.v \
	$(ED25519_SIGN_DIR)/src/rtl/multiplier/MULT_MACRO.v \
	$(AES_DIR)/src/rtl/aes_core.v \
	$(AES_DIR)/src/rtl/aes_decipher_block.v \
	$(AES_DIR)/src/rtl/aes_encipher_block.v \
	$(AES_DIR)/src/rtl/aes_inv_sbox.v \
	$(AES_DIR)/src/rtl/aes_key_mem.v \
	$(AES_DIR)/src/rtl/aes_sbox.v
endif
ifeq ($(SUB_PROJECT),NEDOFPGA)
	SBT_PROJECT       ?= keystoneAcc
	MODEL             ?= NEDOFPGA
	VLOG_MODEL        ?= NEDOFPGA
	MODEL_PACKAGE     ?= uec.keystoneAcc.nedochip
	CONFIG            ?= ChipConfig
	CONFIG_PACKAGE    ?= uec.keystoneAcc.nedochip
	GENERATOR_PACKAGE ?= uec.keystoneAcc.exampletop
	TB                ?= TestDriver
	TOP               ?= NEDOSystem
	ADD_VSRC          ?= $(SHA3_HIGHPERF_DIR)/rtl/f_permutation.v \
	$(SHA3_HIGHPERF_DIR)/rtl/round2in1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/keccak.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder.v \
	$(SHA3_HIGHPERF_DIR)/rtl/rconst2in1.v \
	$(ED25519_DIR)/rtl/mac16_generic.v \
	$(ED25519_DIR)/rtl/ed25519_microcode_rom.v \
	$(ED25519_DIR)/rtl/ed25519_operand_bank.v \
	$(ED25519_DIR)/rtl/adder47_generic.v \
	$(ED25519_DIR)/rtl/ed25519_uop_worker.v \
	$(ED25519_DIR)/rtl/subtractor32_generic.v \
	$(ED25519_DIR)/rtl/ed25519_wrapper.v \
	$(ED25519_DIR)/rtl/ed25519_core_top.v \
	$(ED25519_DIR)/rtl/bram_1rw_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1rw_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1wo_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/ed25519_base_point_multiplier.v \
	$(ED25519_DIR)/rtl/curve25519_modular_multiplier.v \
	$(ED25519_DIR)/rtl/ed25519_banks_array.v \
	$(ED25519_DIR)/rtl/modular_adder.v \
	$(ED25519_DIR)/rtl/modular_subtractor.v \
	$(ED25519_DIR)/rtl/adder32_generic.v \
	$(ED25519_DIR)/rtl/multiword_mover.v \
	$(ED25519_SIGN_DIR)/src/rtl/ed25519_sign_core_S.v \
	$(ED25519_SIGN_DIR)/src/rtl/multiplier/MULT_MACRO.v \
	$(AES_DIR)/src/rtl/aes_core.v \
	$(AES_DIR)/src/rtl/aes_decipher_block.v \
	$(AES_DIR)/src/rtl/aes_encipher_block.v \
	$(AES_DIR)/src/rtl/aes_inv_sbox.v \
	$(AES_DIR)/src/rtl/aes_key_mem.v \
	$(AES_DIR)/src/rtl/aes_sbox.v
endif
ifeq ($(SUB_PROJECT),NEDOFPGAQuartus)
	SBT_PROJECT       ?= keystoneAcc
	MODEL             ?= NEDOFPGAQuartus
	VLOG_MODEL        ?= NEDOFPGAQuartus
	MODEL_PACKAGE     ?= uec.keystoneAcc.nedochip
	CONFIG            ?= ChipConfigDE4
	CONFIG_PACKAGE    ?= uec.keystoneAcc.nedochip
	GENERATOR_PACKAGE ?= uec.keystoneAcc.exampletop
	TB                ?= TestDriver
	TOP               ?= NEDOSystem
	ADD_VSRC          ?= $(SHA3_HIGHPERF_DIR)/rtl/f_permutation.v \
	$(SHA3_HIGHPERF_DIR)/rtl/round2in1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder1.v \
	$(SHA3_HIGHPERF_DIR)/rtl/keccak.v \
	$(SHA3_HIGHPERF_DIR)/rtl/padder.v \
	$(SHA3_HIGHPERF_DIR)/rtl/rconst2in1.v \
	$(ED25519_DIR)/rtl/mac16_generic.v \
	$(ED25519_DIR)/rtl/ed25519_microcode_rom.v \
	$(ED25519_DIR)/rtl/ed25519_operand_bank.v \
	$(ED25519_DIR)/rtl/adder47_generic.v \
	$(ED25519_DIR)/rtl/ed25519_uop_worker.v \
	$(ED25519_DIR)/rtl/subtractor32_generic.v \
	$(ED25519_DIR)/rtl/ed25519_wrapper.v \
	$(ED25519_DIR)/rtl/ed25519_core_top.v \
	$(ED25519_DIR)/rtl/bram_1rw_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1rw_readfirst.v \
	$(ED25519_DIR)/rtl/bram_1wo_1ro_readfirst.v \
	$(ED25519_DIR)/rtl/ed25519_base_point_multiplier.v \
	$(ED25519_DIR)/rtl/curve25519_modular_multiplier.v \
	$(ED25519_DIR)/rtl/ed25519_banks_array.v \
	$(ED25519_DIR)/rtl/modular_adder.v \
	$(ED25519_DIR)/rtl/modular_subtractor.v \
	$(ED25519_DIR)/rtl/adder32_generic.v \
	$(ED25519_DIR)/rtl/multiword_mover.v \
	$(ED25519_SIGN_DIR)/src/rtl/ed25519_sign_core_S.v \
	$(ED25519_SIGN_DIR)/src/rtl/multiplier/MULT_MACRO.v \
	$(AES_DIR)/src/rtl/aes_core.v \
	$(AES_DIR)/src/rtl/aes_decipher_block.v \
	$(AES_DIR)/src/rtl/aes_encipher_block.v \
	$(AES_DIR)/src/rtl/aes_inv_sbox.v \
	$(AES_DIR)/src/rtl/aes_key_mem.v \
	$(AES_DIR)/src/rtl/aes_sbox.v
endif
ifeq ($(SUB_PROJECT),tracegen)
	SBT_PROJECT       ?= tracegen
	MODEL             ?= TestHarness
	VLOG_MODEL        ?= $(MODEL)
	MODEL_PACKAGE     ?= $(SBT_PROJECT)
	CONFIG            ?= TraceGenConfig
	CONFIG_PACKAGE    ?= $(SBT_PROJECT)
	GENERATOR_PACKAGE ?= $(SBT_PROJECT)
	TB                ?= TestDriver
	TOP               ?= TraceGenSystem
endif
# for Rocket-chip developers
ifeq ($(SUB_PROJECT),rocketchip)
	SBT_PROJECT       ?= rocketchip
	MODEL             ?= TestHarness
	VLOG_MODEL        ?= TestHarness
	MODEL_PACKAGE     ?= freechips.rocketchip.system
	CONFIG            ?= DefaultConfig
	CONFIG_PACKAGE    ?= freechips.rocketchip.system
	GENERATOR_PACKAGE ?= freechips.rocketchip.system
	TB                ?= TestDriver
	TOP               ?= ExampleRocketSystem
endif
# for Hwacha developers
ifeq ($(SUB_PROJECT),hwacha)
	SBT_PROJECT       ?= hwacha
	MODEL             ?= TestHarness
	VLOG_MODEL        ?= TestHarness
	MODEL_PACKAGE     ?= freechips.rocketchip.system
	CONFIG            ?= HwachaConfig
	CONFIG_PACKAGE    ?= hwacha
	GENERATOR_PACKAGE ?= hwacha
	TB                ?= TestDriver
	TOP               ?= ExampleRocketSystem
endif
# Stand-in firechip variables:
# TODO: need a seperate generator and test harnesses for each target
#ifeq ($(SUB_PROJECT),firechip)
#	SBT_PROJECT       ?= $(SUB_PROJECT)
#	MODEL             ?= TestHarness
#	VLOG_MODEL        ?= TestHarness
#	MODEL_PACKAGE     ?= freechips.rocketchip.system
#	CONFIG            ?= FireSimRocketChipConfig
#	CONFIG_PACKAGE    ?= firesim.firesim
#	GENERATOR_PACKAGE ?= firesim.firesim
#	TB                ?= TestDriver
#	TOP               ?= FireSimNoNIC
#endif

#########################################################################################
# path to rocket-chip and testchipip
#########################################################################################
ROCKETCHIP_DIR      ?= $(base_dir)/hardware/chipyard/generators/rocket-chip
TESTCHIP_DIR        ?= $(base_dir)/hardware/chipyard/generators/testchipip
CHIPYARD_FIRRTL_DIR ?= $(base_dir)/hardware/chipyard/tools/firrtl

#########################################################################################
# names of various files needed to compile and run things
#########################################################################################
long_name = $(MODEL_PACKAGE).$(MODEL).$(CONFIG)

# match the long_name to what the specific generator will output
ifeq ($(GENERATOR_PACKAGE),freechips.rocketchip.system)
	long_name=$(CONFIG_PACKAGE).$(CONFIG)
endif
ifeq ($(GENERATOR_PACKAGE),hwacha)
	long_name=$(MODEL_PACKAGE).$(CONFIG)
endif

FIRRTL_FILE ?= $(build_dir)/$(long_name).fir
ANNO_FILE   ?= $(build_dir)/$(long_name).anno.json

TOP_FILE       ?= $(build_dir)/$(long_name).top.v
TOP_FIR        ?= $(build_dir)/$(long_name).top.fir
TOP_ANNO       ?= $(build_dir)/$(long_name).top.anno.json
TOP_SMEMS_FILE ?= $(build_dir)/$(long_name).top.mems.v
TOP_SMEMS_CONF ?= $(build_dir)/$(long_name).top.mems.conf
TOP_SMEMS_FIR  ?= $(build_dir)/$(long_name).top.mems.fir

HARNESS_FILE       ?= $(build_dir)/$(long_name).harness.v
HARNESS_FIR        ?= $(build_dir)/$(long_name).harness.fir
HARNESS_ANNO       ?= $(build_dir)/$(long_name).harness.anno.json
HARNESS_SMEMS_FILE ?= $(build_dir)/$(long_name).harness.mems.v
HARNESS_SMEMS_CONF ?= $(build_dir)/$(long_name).harness.mems.conf
HARNESS_SMEMS_FIR  ?= $(build_dir)/$(long_name).harness.mems.fir

# files that contain lists of files needed for VCS or Verilator simulation
sim_files                  ?= $(build_dir)/sim_files.f
sim_top_blackboxes         ?= $(build_dir)/firrtl_black_box_resource_files.top.f
sim_harness_blackboxes     ?= $(build_dir)/firrtl_black_box_resource_files.harness.f
# single file that contains all files needed for VCS or Verilator simulation (unique and without .h's)
sim_common_files           ?= $(build_dir)/sim_files.common.f

#########################################################################################
# java arguments used in sbt
#########################################################################################
JAVA_HEAP_SIZE ?= 8G
JAVA_ARGS ?= -Xmx$(JAVA_HEAP_SIZE) -Xss8M -XX:MaxPermSize=256M

#########################################################################################
# default sbt launch command
#########################################################################################
SCALA_VERSION=2.12.4
SCALA_VERSION_MAJOR=$(basename $(SCALA_VERSION))

SBT ?= java $(JAVA_ARGS) -jar $(ROCKETCHIP_DIR)/sbt-launch.jar ++$(SCALA_VERSION)

#########################################################################################
# output directory for tests
#########################################################################################
output_dir=$(sim_dir)/output/$(long_name)

#########################################################################################
# helper variables to run binaries
#########################################################################################
BINARY ?=
SIM_FLAGS ?=
VERBOSE_FLAGS ?= +verbose
sim_out_name = $(subst $() $(),_,$(notdir $(basename $(BINARY))).$(long_name))

#########################################################################################
# build output directory for compilation
#########################################################################################
gen_dir=$(sim_dir)/generated-src
build_dir=$(gen_dir)/$(long_name)

#########################################################################################
# vsrcs needed to run projects
#########################################################################################
rocketchip_vsrc_dir = $(ROCKETCHIP_DIR)/src/main/resources/vsrc

#########################################################################################
# sources needed to run simulators
#########################################################################################
sim_vsrcs = \
	$(TOP_FILE) \
	$(HARNESS_FILE) \
	$(TOP_SMEMS_FILE) \
	$(HARNESS_SMEMS_FILE) \
	$(ADD_VSRC)

#########################################################################################
# assembly/benchmark variables
#########################################################################################
timeout_cycles = 10000000
bmark_timeout_cycles = 100000000
