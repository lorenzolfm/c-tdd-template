# Silent make
ifndef VERBOSE
.SILENT:
endif

# Compiler
CC = gcc

# Compiler Flags
C_FLAGS = -Werror

MAIN = main.c

# Build directory
BUILD_DIR := build
# Include directory (.h files)
INCLUDE_DIR := include
# Source directory (.c files)
SRC_DIR := src

# Source objects directory (.o files)
SRCS_OBJS_DIR := $(BUILD_DIR)/objs

# List of all files matching this pattern (with directory)
SRCS = $(wildcard src/*.c)

# List of all files matching this pattern (file only)
SRCS_FILES = $(notdir $(SRCS))

# Substitutes the file extension from %.c to %.o and sets the corrrect path
OBJS := $(patsubst %.c, $(SRCS_OBJS_DIR)/%.o, $(SRCS_FILES))

# Dependencies directory
DEPDIR = $(SRCS_OBJS_DIR)/.deps

# Dependencies flags
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d

# Build object files
COMPILE = $(CC) -I $(INCLUDE_DIR) $(DEPFLAGS) $(C_FLAGS) -c

%.o : %.c

$(SRCS_OBJS_DIR)/%.o : $(SRC_DIR)/%.c $(DEPDIR)/%.d | $(DEPDIR)
	mkdir -p $(BUILD_DIR)
	$(COMPILE) $< -o $@

all: $(OBJS)
	$(CC) $(MAIN) $(SRCS) -I $(INCLUDE_DIR) -o $(BUILD_DIR)/main

run:
	./build/main

test:
	make -f MakeTest.mk test

clean:
	rm -rf build
	make -f MakeTest.mk clean

# Create dependencies directory
$(DEPDIR): ; @mkdir -p $@

# Creates dependencies
DEPFILES := $(SRCS_FILES:%.c=$(DEPDIR)/%.d)
$(DEPFILES):

include $(wildcard $(DEPFILES))
