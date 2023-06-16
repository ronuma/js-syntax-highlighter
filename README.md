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

NOTE: the index.html file has been set to be ignored by version control in the .gitignore file, so it will not be uploaded to the repository. If you want to see the file, you will have to run the program yourself.

<br>

## Our thoughts about the proposed solution

The proposed solution has its advantages and disadvantages. To begin with, we had to sacrifice the recognition of multiline comments and strings. This was done to simplify the algorithm and be able to focus on the recognition of tokens. However, this is not a problem, since the program works correctly with single-line strings and comments. In addition, the program is not sensitive to whitespace, so it does not matter if there is whitespace between the tokens, the program will recognize them anyway.

We used recursion and list handling, and well, the execution time of the program depends to a large extent on the size of the file to be read. Actually, the execution time is not that long, but if you wanted to read a very large file, the execution time could be considerable. With the test files we have, the execution time is approximately 0.5 seconds.

<br>

## Algorithm complexity

For the proposed solution we defined 3 different functions, so in the following analysis we will "divide and conquer".

In the case of JSSH.run(in_filename) we can see that we are dealing with a complexity of O(n), where n depends of the file, like we explained in the previous point if the file were to be a very large file the execution time could be considerable. However unpacking this function further we can analyze two other functions that are necessary in order to initialize html output file and read the js file. For the first one, File.write(out_filename, doc_head), it is a simple as a complexity of O(1), since it is constant in it's execution.

Following with the private function write_file(code, out_filename), mentioned in the previous paragraph, first splits the code by lines, removes the trailing spaces and \r and then calls inspect_line(line, out_filename). Let's break it down. String.split("\n") depends on the number of lines on the code, similar to the first function, which means a complexity of O(n). We follow with Enum.map(&String.trim_trailing/1), which deals with the removal of trailing spaces and \r, also has a linear time complexity, O(n).

Lastly we have the inspect_line(line, out_filename). This is the core function so to speak, it analyses each line of the code and writes HTML code in order to showcase the file in a highlighted form. Taking this into account the complexity, yet again, depends on the input, however it is important that we point out that this functions utilizes recursion. In summary we can define the complexity as O(k*n), where k represents the number of pattern matching conditions and where k is the number of pattern matching conditions.

<br>

## Ethical implications

We consider that this type of technology does not necessarily have direct ethical implications, we do not see it quite so. This type of technology is basically designed for better development experience when working with a programming language, in this case, JavaScript, and also possibly for pointing out errors (by adding a DFA that executes every time a new character is added to the file, for example). However, we do not see any ethical implications in this type of technology, since it is not designed to be used in a malicious way, but rather to facilitate the work of developers.
