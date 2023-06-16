# JavaScript Syntax Highlighter
## Parallel programming version

2023-06-16

Rodrigo Núñez Magallanes, A01028310

Andrea Alexandra Barrón Córdova, A01783126

<br>

## Usage instructions

1. Clone the repository

2. Navigate to the project directory in your terminal (remember to be in the parallel directory inside of the project)

3. Do `$ iex main.exs` to compile the project and open the interactive elixir shell

4. Do `iex> JSSH.run(number_of_files)`; JSSH (short for JavaScript Syntax Highlighter) is the module name, and run is the function name, which takes the number of JS files to read as an argument. You will be prompted to enter the file names that will be read, do this without quotation marks. We provided three sample test files:

   a. "test.js": this is the file we used to test the program, it has a lot of different cases, so it is a good file to test the program with.

   b. "test.funcs.js": sample file with a real node.js module with some functions.

   c. "test.sw.js": this is an extract of a Redux state slice from a Next.js application which one of the team members worked on. It is a good example of a real-world JS file. SW in the file name stands for software, as in software development.

   You can also use your own file, just make sure it is in the same directory as the project. Even though you could create a subdirectory and put the file there, the program will be able to read it and write an html file, only it will be created inside of the parallel directory, not inside of the subdirectory, so it is recommended to put the file in the same directory as the project. Especially because of the location of the css file that allow the html to be coloured.

5. After inputting the file names to inspect, the program runs the JS syntax highlighter with as many threads as file names, with the name of the original file and the extension ".html" as outputs, so you can open them in your browser and see the results!

NOTE: the html files have been set to be ignored by version control in the .gitignore file, so they will not be uploaded to the repository. If you want to see the html files, you will have to run the program yourself.

<br>

## Execution times and speedup

<!-- Mide los tiempos de varias ejecuciones de las dos versiones de tu programa. Calcula el speedup obtenido. Reflexiona sobre las soluciones planteadas, los algoritmos implementados y sobre el tiempo de ejecución de estos. -->

<br>

## Algorithm complexity

<!-- Calcula la complejidad de tu algoritmo basada en el número de iteraciones y contrástala con el tiempo obtenido en el punto 4. -->

As per the las time in the following analysis we will "divide and conquer".

First we see the function for run: 
```elixir
def run(number_of_files) do
    input_filenames(number_of_files)
    |> Enum.map(&Task.async(fn -> write_file(&1) end))
    |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    |> IO.inspect()
  end
```
We'll circle back to ```input_filenames```. But all the operations in the function itself have a complexity of O(n), as they are linear. The "n" depends of the number of files, like we explained the previous time, if the files were to be very large the execution time could be considerable.

Now we can analyze ```input_filenames```:
```elixir
defp input_filenames(n), do: do_in_filenames(n, [])

  defp do_in_filenames(0, res), do: Enum.reverse(res)
  defp do_in_filenames(n, res) do
    name = IO.gets("Enter the name of the file to read: ") |> String.trim()
    do_in_filenames(n - 1, [name | res])
  end
```
It uses pattern matching and it is prompting the user for the name of the files. Since it is only being used for doing so it is a linear complexity of O(n).

Now we can analyze ```write_file``, for this function we will have to unpack it a little bit.

We will start with ```String.split("\n")```, which depends on the number of lines on the code, which means it has a complexity of O(n). 

For the next function, ```Enum.map(&String.trim_trailing/1)```, we have a linear time complexity again since it iterates over each line, giving us a O(n) complexity.

When we take a look at the ```inspect_line``` function we can see that the time it takes depends on each line and the number of regular expressions, so the complexity can be estimated by O(k*n), k being the number of regular expressions and n being the number of lines.

So ```write_file``` has a constant complexity that can be approximated as O(n+(k*n)). The umber of lines is represented with n and the number of regular expressions as k.

Lastly lets break down ```inject```, called by ```inspect line```:
```elixir
defp inject(line, regex, class, out_filename) do
    [head | _] = Regex.run(regex, line)
    html = "<span class=\"#{class}\">#{head}</span>"
    File.write(out_filename, html, [:append])
    line = Regex.replace(regex, line, "", global: false)
    inspect_line(line, out_filename)
  end
```
For ```Regex.run``` and ```Regex.replace``` we can see a complexity of O(n), in this case n represents the complexity of the regular expression pattern matching and the replacement respectively. Overall the complexity can be estimated as O(n+m+k), n and m represent the complexities of the regular expression matching and replacement and k the length of the line.

In summary we can define the complexity as O(n * (m + (k * m))), where n represents the number of files to process, m is the  number of lines in each file and lastly k represents the number of regular expressions checked for each line.

<br>

## Ethical implications

As in our previous work, we consider that this type of technology does not necessarily have direct ethical implications, we do not see it quite so. This type of technology is basically designed for better development experience when working with a programming language, in this case, JavaScript, and also possibly for pointing out errors (by adding a DFA that executes every time a new character is added to the file, for example). However, we do not see any ethical implications in this type of technology, since it is not designed to be used in a malicious way, but rather to facilitate the work of developers. The ability to use threads, however, is something we have just learned, and it is certainly a very powerful and helpful tool that will help us in the future.
