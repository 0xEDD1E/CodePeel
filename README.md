# CodePeel
Separates code lines and comment lines in a source file (currently supports Assembly)

### Introduction
**`codepeel`**is a simple educational purpose project. __`codepeel`__ is a comment extractor, which means It can separate comments and code from a source file. *currently __`codepeel`__ supports only `NASM assembly` source files*. In this project what I'm trying to achieve is support for **_ANY_** programming language. I actually want to implement a generalised function to extract comments of any programming lanuage. 

### Implementation (v2.0)(beta)
```
Function : Codepeel
Parameters : source stream, code stream, comment stream, string to determine comment specifiers
Result : extracted(separated) codes and comments in 2 different text files
// Files for this implementation can be found in beta-vers folder
```
The function `codepeel` is a generalised for extracting comments. By generalising I should be able to extract comments of any programming language without changing the data in `codepeel` function. To do this I have introduced a new parameter for `codepeel` function, `comstr`: string to determine the comment specifiers of the programming language. This implemetation of `codepeel` can extract single-line and multi-line comments. So `comstr` has a syntax, which tells the `codepeel` function about single-line, multi-line comment specifiers in a desired programming language.

`comstr` has this format:  
 ```
   "(singleline specifier)[multiline begin]{multiline end}"
 ```
 `codepeel` will call another function to break this string into 3 separate strings (`ss, me, mb`) and then these strings will be used to identify comments in the source file. This implementation is also aware of strings in source file.
