# JavaScript syntax highlighter with parallel programming
# 2023-06-16
# Rodrigo Núñez Magallanes, A01028310
# Andrea Alexandra Barrón Córdova, A01783126

defmodule JSSH do

  @doc """
  This is a description of the private functions of the module:

  write_file/1
  Parameter: in_filename, the name of the input file.
  This function reads the input file and writes the output html file.
  It splits the input file line by line and for each line calls the inspect_line/2 function.

  inspect_line/2
  Parameters: line, the line of code to inspect.
              out_filename, the name of the output file.
  This function inspects each line of the code and writes the html file.
  It uses regular expressions to match the different patterns and writes the html code.
  For every line, it calls itself recursively with helper func inject/4 until the line is empty.
  Every regular expression ensures that it is searched for at the beginning of the line.

  inject/4
  Parameters: line, the line of code to inspect.
              regex, the regular expression to match.
              class, the class to assign to the html code.
              out_filename, the name of the output file.
  This function injects the html code into the html file.
  It uses the regular expression to match the pattern and writes the html code.
  It also calls the inspect_line function recursively until the line is empty.
  """

  @doc """
  run_sequential/1
  Parameter: number_of_files, the number of files to read.
  This function runs the program sequentially.
  It calls the input_filenames/1 function to get the input filenames.
  It then calls the write_file/1 function for each input filename.
  """
  def run_sequential(number_of_files) do
    input_filenames(number_of_files)
    |> Enum.map(&write_file(&1))
  end

  @doc """
  run_parallel/1
  Parameter: number_of_files, the number of files to read.
  This function runs the program in parallel.
  It calls the input_filenames/1 function to get the input filenames.
  It creates a task for each input filename and calls the write_file/1 function.
  It then awaits for all the tasks to finish.
  """
  def run_parallel(number_of_files) do
    input_filenames(number_of_files)
    |> Enum.map(&Task.async(fn -> write_file(&1) end))
    |> Enum.map(&Task.await(&1))
  end

  # helper function to get the input filenames
  defp input_filenames(n), do: do_in_filenames(n, [])

  defp do_in_filenames(0, res), do: Enum.reverse(res)
  defp do_in_filenames(n, res) do
    name = IO.gets("Enter the name of the file to read: ") |> String.trim()
    do_in_filenames(n - 1, [name | res])
  end

  defp write_file(in_filename) do
    doc_head = """
    <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <link rel="stylesheet" href="../styles.css" />
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
          <title>Highlighted #{in_filename}</title></head><body><pre>
    """
    out_filename = "#{in_filename}.html"
    # initialize html output file
    File.write(out_filename, doc_head)
    # read the file
    code = File.read!(in_filename)
    code
    # split the code by lines
    |> String.split("\n")
    # remove trailing spaces and \r
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(fn line ->
      inspect_line(line, out_filename)
    end)
    # close the file
    File.write(out_filename, "</pre></body></html>", [:append])
  end

  defp inspect_line("", out_filename), do: File.write(out_filename, "<br>", [:append])
  defp inspect_line(line, out_filename) do
    # Regular expressions
    comment_regex = ~r/^\/\/.*/
    string_regex = ~r/^(["'`])(?:(?=(\\?))\2.)*?\1/
    keyword_regex = ~r/^\b(?:abstract|await|async|boolean|break|byte|case|catch|char|class|const|continue|debugger|default|do|double|else|enum|export|extends|final|finally|float|for|function|from|goto|if|implements|import|in|instanceof|int|interface|let|long|native|new|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|try|typeof|var|void|volatile|while|with|yield)\b/
    number_regex = ~r/^\b-?\d+\.?(\d+)?\b/
    # matches any boolean, null, undefined, delete, because they should be red
    boolean_regex = ~r/^\b(?:true|false|null|undefined|delete)\b/
    equal_regex = ~r/^(=|\<|\>|\!|\?|\:)/
    space_regex = ~r/^\s+/
    var_regex = ~r/^[a-zA-Z_$][a-zA-Z0-9_$]*/
    math_regex = ~r/^(\+|\-|\/|\*|%)/
    punct_regex = ~r/^[;,\.]/
    func_call_regex = ~r/^([a-zA-Z_$][a-zA-Z0-9_$]*\()/
    obj_regex = ~r/^([a-zA-Z_$][a-zA-Z0-9_$]*\.)/
    prop_regex = ~r/^([a-zA-Z_$][a-zA-Z0-9_$]*\:)/
    arrowfunc_regex = ~r/^(\=\>)/
    # matches any non-space character (words that we don't want to highlight)
    any_regex = ~r/^\S+/
    specials_regex = ~r/^(\(|\)|\{|\}|\[|\])/

    cond do
      # check for comment so we can ignore the rest of the line
      Regex.match?(comment_regex, line) ->
        inject(line, comment_regex, "comment", out_filename)
      # check for string so we can ignore the rest of the line until string closes
      Regex.match?(string_regex, line) ->
        inject(line, string_regex, "string", out_filename)
      # check for a keyword pattern
      Regex.match?(keyword_regex, line) ->
        inject(line, keyword_regex, "keyword", out_filename)
      # check for a space pattern
      Regex.match?(space_regex, line) ->
        inject(line, space_regex, "space", out_filename)
      # check for an arrow function before checking equal sign
      Regex.match?(arrowfunc_regex, line) ->
        inject(line, arrowfunc_regex, "arrowfunc", out_filename)
      # check for a boolean pattern
      Regex.match?(boolean_regex, line) ->
        inject(line, boolean_regex, "boolean", out_filename)
      # check for a punctuation pattern
      Regex.match?(punct_regex, line) ->
        inject(line, punct_regex, "punctuation", out_filename)
      # check for a function call pattern
      Regex.match?(func_call_regex, line) ->
        inject(line, func_call_regex, "special", out_filename)
      # check for an object pattern
      # do it before the variable to ensure the presence of the dot
      # replace it as a variable so we can color the dot properly
      # but we place the class number to color it properly
      Regex.match?(obj_regex, line) ->
        inject(line, var_regex, "number", out_filename)
      # check for definition of object properties
      Regex.match?(prop_regex, line) ->
        inject(line, prop_regex, "punctuation", out_filename)
      # check for a variable name pattern
      Regex.match?(var_regex, line) ->
        inject(line, var_regex, "var", out_filename)
      # check for an equality or inequality pattern
      Regex.match?(equal_regex, line) ->
        inject(line, equal_regex, "boolean", out_filename)
      # check for a number pattern
      Regex.match?(number_regex, line) ->
        inject(line, number_regex, "number", out_filename)
      # check for parentheses, brackets, braces
      Regex.match?(specials_regex, line) ->
        inject(line, specials_regex, "special", out_filename)
      # check for arithmetic operators
      Regex.match?(math_regex, line) ->
        inject(line, math_regex, "boolean", out_filename)
      # there was no match, so we just write the line as is
      true ->
        inject(line, any_regex, "any", out_filename)
    end
  end

  # helper func to inject html into the file
  defp inject(line, regex, class, out_filename) do
    [head | _] = Regex.run(regex, line)
    html = "<span class=\"#{class}\">#{head}</span>"
    File.write(out_filename, html, [:append])
    line = Regex.replace(regex, line, "", global: false)
    inspect_line(line, out_filename)
  end

end
