# Example 01 :
DATE := $(shell date +%F)
create-dir:
	mkdir -p output
create-file: create-dir
	echo "Hello, Welcome to Makefile! 🥰 $(DATE)" > output/$(DATE).txt
main:
	$(MAKE) create-file


# Makefile Special Variables
# 01. $(MAKE) → Refers to the make command itself. It is used to invoke another Make target.
greet:
	echo "Hello World"
main:
	$(MAKE) greet



# 02. $@ --> The name of the thing you are making (the target) or Represents the current target.
hello.txt:
	echo "Hello, World! 🤯 storing into $@" > $@



# 03. $^ --> Represents all dependencies that target depends on.
DATE := $(shell date +%d-%m-%y)
create-dir:
	mkdir -p $(DATE)
create-file:
	echo "Hello, World 🧠" > $(DATE)/hello.txt
main: create-dir create-file
	@echo "List all the dependencies : $^"



# 04. $< --> Represents the first dependency (first prerequisite).
main: file1.txt file2.txt
	@echo "First dependency: $<"
file1.txt:
	@touch $@
file2.txt:
	@touch $@


# 05. $? --> Represents only the dependencies that have changed since the target was last built.
backup: file1.txt file2.txt
	@echo "Changed dependencies: $?"
	@touch backup


# Example
# $@  --> Target
# $^  --> All dependencies
# $<  --> First dependency

sandwich: bread lettuce tomato cheese
	@echo "Target           : $@"
	@echo "Dependencies     : $^"
	@echo "First Dependency : $<"

bread:
	@echo "🍞 Bread is ready."

lettuce:
	@echo "🥬 Lettuce is ready."

tomato:
	@echo "🍅 Tomato is ready."

cheese:
	@echo "🧀 Cheese is ready."



# Overriding the variables in Makefile
NAME:= "Piyush"
get_name:
	@echo "$(NAME)"