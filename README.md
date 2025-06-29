# READ ME!!!
## my-zsh-tools
**repository description:**

my zsh tools, for me they are useful, I don't know how for you
##
## commands info:
### command \"del\":
Usage for delete file/directory: del <your file or directory>

Usage for delete file: del -f <path to the file>

Usage for delete directory: del -d <path to the directory>

Usage -s at the end to the confirm deleting(without -s you will be asked if you confirm the deletion)

Example of use:

`del my-zsh-commands/README.md -s`

`del -d /Users/user/PyCharmProjects/PycharmProjct1`

`del -f logs.txt`

##
### command \"run\":
**Usage: `run file_name_or_path_to_the_file`, can run:**

.py(only with installed python3),

.cpp(only with installed g++),

.c(only with installed gcc),

.cs(only with installed mono),

.js(only with installed node.js),

.sh(zsh is the default, but you can specify the 2nd argument as a console in which you can run it),

.java(only with installed java interpreter(NOT COMPILER!)),

.lua(only with installed lua interpreter),

.rs(only with installed Rust compiler),

.rb(only with installed Ruby interpreter),

.go(only with installed Go interpreter/compiler),

.zsh

**automatic installation in the absence of a compiler for one of the languages ​​you wanted to run is not yet provided**

**You can also specify the 2nd argument as the launch method, example: `run file_name.c cpp`**

**Example of use:**

`run just_java_file.java`

`run c_file.c cpp`

`run python_project.py`
##
### all information about commands can also be read in --help for commands
##
## instruction:
The project was made on the macOS and is intended for ZSH console. If it worked for you on another OS or another console, you are just lucky.

How to make these commands available:

1. Download the `.zshrc` file

2. Enter the following command in your (ZSH!) console:

`source .zshrc`

or instead of .zshrc insert the path where you downloaded the file

3. Use it!
