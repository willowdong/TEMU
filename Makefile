include mips_sc/src/Makefile.testcase

.PHONY: run clean

ifndef INCLUDE_DIR
INCLUDE_DIR := ./temu/include
endif
ifndef SRC_DIR
SRC_DIR := ./temu/src
endif
ifndef BUILD_DIR
BUILD_DIR := build/
endif
DEBUG := false

# Compilation flags
CC := gcc
CFLAGS := -I$(INCLUDE_DIR) -Wall
LDFLAGS := -lreadline

# Files to be compiled
SRCS := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/memory/*.c) $(wildcard $(SRC_DIR)/cpu/*.c) $(wildcard $(SRC_DIR)/monitor/*.c)

TEMU_TARGET := temu

ifeq ($(DEBUG), true)
CFLAGS += -g
endif

export	INCLUDE_DIR
export	SRC_DIR
export	BUILD_DIR

# ********************
# Rules of Compilation
# ********************

$(BUILD_DIR)$(TEMU_TARGET): 
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRCS)
	@git commit --allow-empty -m "compile"

run: $(BUILD_DIR)$(TEMU_TARGET)
	@./$(BUILD_DIR)$(TEMU_TARGET) $(USER_PROGRAM)
	@git commit --allow-empty -m "run"

clean:
	rm -r $(BUILD_DIR)
	rm log.txt

