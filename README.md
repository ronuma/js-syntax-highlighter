# JavaScript Syntax Highlighter

2023-31-05

Rodrigo Núñez Magallanes, A01028310

Andrea Alexandra Barrón Córdova, A01783126

<br>

## Usage instructions

1. Clone the repository

2. Navigate to the project directory in your terminal

3. Do `$ iex main.exs` to compile the project and open the interactive elixir shell

4. Do `iex> JSSH.run(in_filename)`; JSSH (short for JavaScript Syntax Highlighter) is the module name, and run is the function name, which takes the input file name as an argument (a string, so write it enclosed in double quotation marks e.g. "test.js"). We provided three sample test files:

   a. "test.js": this is the file we used to test the program, it has a lot of different cases, so it is a good file to test the program with.

   b. "test.funcs.js": sample file with a real node.js module with some functions.

   c. "test.sw.js": this is an extract of a Redux state slice from a Next.js application which one of the team members worked on. It is a good example of a real-world JS file. SW in the file name stands for software, as in software development.

   You can also use your own file, just make sure it is in the same directory as the project.

5. After inputting the file name to inspect, the program runs the JS syntax highlighter with "index.html" as an output, so you can open it in your browser and see the results!

<br>

## Our thoughts about the proposed solution

The proposed solution has its advantages and disadvantages. To begin with, we had to sacrifice the recognition of multiline comments and strings. This was done to simplify the algorithm and be able to focus on the recognition of tokens. However, this is not a problem, since the program works correctly with single-line strings and comments. In addition, the program is not sensitive to whitespace, so it does not matter if there is whitespace between the tokens, the program will recognize them anyway.

We used recursion and list handling, and well the execution time of the program depends to a large extent on the size of the file to be read. Actually, the execution time is not that long, but if you wanted to read a very large file, the execution time could be considerable. With the test files we have, the execution time is approximately 0.5 seconds.

<br>

## Algorithm complexity

`/* Calcula la complejidad de tu algoritmo basada en el número de iteraciones y contrástala con el tiempo estimado en el punto anterior. */`

<br>

## Ethical implications

We consider that this type of technology does not necessarily have direct ethical implications, we do not see it quite so. This type of technology is basically designed for better development experience when working with a programming language, in this case, JavaScript, and also possibly for pointing out errors (by adding a DFA that executes every time a new character is added to the file, for example). However, we do not see any ethical implications in this type of technology, since it is not designed to be used in a malicious way, but rather to facilitate the work of developers.
