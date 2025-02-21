The following command-line arguments are supported:

## --help
Shows argument help

## --help-md
Shows argument help, in Markdown

# Inputs

## &lt;path&gt;
A relative or absolute path to a C/C++ file to scan.  
You can specify multiple of these!  
May contain `*` in file name for simple wildcard matches (`test/lib_*.cpp`).

## --index &lt;path&gt;
Scans the file for typedefs/usings, but will not mirror structs from it.

# Outputs

## --cpp &lt;path&gt;
A path to a file where auto-generated C++ functions will be.  
Usually this is a file in your C++ project.

## --gml &lt;path&gt;
A path to a file where auto-generated GML functions will be.  
Usually this is a file in your GM extension.

## --gml-constructors &lt;path&gt;
If you are using constructor+method comment tags,
this is where the generated GML constructor functions will reside.

# Functions and tags

## --prefix &lt;snip&gt;
Sets the prefix for GML helper functions (default: ext)

## --function-tag &lt;tag&gt;
Changes the macro-tag for unmangled functions (default: dllg)  
The tool will only generate wrappers for functions prepended with this tag.

## --function-tag-m &lt;tag&gt;
Changes the macro-tag for mangled/YYRunnerInterface functions (default: dllgm)

## --export-tag &lt;tag&gt;
Changes the tag/macro for generated unmangled functions (default: dllx)

## --export-tag-m &lt;tag&gt;
Changes the tag/macro for generated mangled functions (default: dllm)

# C++ file

## --prepend &lt;line&gt;
Adds a line of code at the beginning of the auto-generated C++ file.

## --append &lt;line&gt;
Adds a line of code at the end of the auto-generated C++ file.

## --include &lt;path&gt;
Adds an `#include "<path>"` to the auto-generated C++ file.

# Esoteric

## --struct &lt;value&gt;
Changes how C++ structs are converted to/from GML:
- 1: always uses GML structs for C++ structs
- 0: always uses arrays for C++ structs
- auto: generates GmxGen-specific wrapper, like:  
  ```gml
  // GMS >= 2.3
  struct-based code
  /*/
  array-based code
  //*/
  ```
- Other values: uses the value as a condition, like:  
  ```gml
  // GMS >= 2.3
  if (value) {
  	struct-based code
  } else //*/
  {
  	array-based code
  }
  ```

## --prefer-ds
Prefer ds_maps and ds_lists over arrays in GM versions without structs.

## --wasm
Enables WebAssembly-specific tweaks to code generation.

## --gmk &lt;path&gt;
A path to a file where GM8.1 scripts will be.  
These will follow 8.1 constraints (such as using lists instead of arrays)
and will generate additional code to make up for lacking API.
