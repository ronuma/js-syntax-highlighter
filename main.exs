# JavaScript syntax highlighter

# Rodrigo Núñez Magallanes, A01028310
# Andrea Alexandra Barrón Córdova,

defmodule JSSH do

  def run() do
    # ----  CONSTANTS  -----
    in_filename = "test.js" # this will be inputted in the end
    out_filename = "index.html"
    doc_head = """
    <!DOCTYPE html>
      <html lang="en">
        <head>
          <meta charset="UTF-8" />
          <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
          <meta name="viewport" content="width=device-width, initial-scale=1.0" />
          <link rel="stylesheet" href="styles.css" />
          <link rel="preconnect" href="https://fonts.googleapis.com">
          <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
          <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
          <title>JS Syntax Highlighter</title></head><body><pre>
    """
    # doc_tail = "</pre></body></html>"

    # initialize html output file
    File.write(out_filename, doc_head)

    # read js file
    code = File.read!(in_filename)

    write_file(code, out_filename)
    # # close the tags of the html file and finish
    # File.write(out_filename, doc_tail, [:append])

  end

  defp write_file("", out_filename), do: File.write(out_filename, "</pre></body></html>", [:append])

  defp write_file(code, out_filename) do
    IO.puts(code)
    # Regular expressions
    commentRegex = ~r/\/\/(|\r)*|\/\*(.|\n|\r)*\*\//
    stringRegex = ~r/(["'])(?:(?=(\\?))\2.)*?\1/
    keywordRegex = ~r/\b(?:abstract|await|boolean|break|byte|case|catch|char|class|const|continue|debugger|default|delete|do|double|else|enum|export|extends|final|finally|float|for|function|goto|if|implements|import|in|instanceof|int|interface|let|long|native|new|null|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|try|typeof|var|void|volatile|while|with|yield)\b/
    numberRegex = ~r/\b-?\d+\.?(\d+)?\b/
    booleanRegex = ~r/\b(?:true|false)\b/

    code
      # split the code by lines
      |> String.split("\n")
      # map every line, if the line is empty, add a <br> tag
      |> Enum.map(fn line ->
        if line == "" do
          "<br>"
        else
          line
          # split the line by words
          |> String.split(~r/\b/)
          # map every word, if the word is a token, highlight it
          |> Enum.map(fn word ->
            if Regex.match?(~r/\/\*(.|\n|\r)*/, word) do
              result = Regex.run(commentRegex, code)
              html = "<span class=\"comment\">#{result}</span>"
              File.write(out_filename, html, [:append])
              code = Regex.replace(commentRegex, code, "")
              write_file(code, out_filename)
            else
            if Regex.match?(~r/\/\/.*/, word) do
              result = Regex.run(commentRegex, code)
              html = "<span class=\"comment\">#{result}</span>"
              File.write(out_filename, html, [:append])
              code = Regex.replace(commentRegex, code, "")
              write_file(code, out_filename)
            else
              if Regex.match?(stringRegex, word) do
                result = Regex.run(stringRegex, code)
                html = "<span class=\"string\">#{result}</span>"
                File.write(out_filename, html, [:append])
                code = Regex.replace(stringRegex, code, "")
                write_file(code, out_filename)
              else
                  if Regex.match?(keywordRegex, word) do
                    result = Regex.run(keywordRegex, code)
                    html = "<span class=\"keyword\">#{result}</span>"
                    File.write(out_filename, html, [:append])
                    code = Regex.replace(keywordRegex, code, "")
                    write_file(code, out_filename)
                  else
                    if Regex.match?(numberRegex, word) do
                      result = Regex.run(numberRegex, code)
                      html = "<span class=\"number\">#{result}</span>"
                      File.write(out_filename, html, [:append])
                      code = Regex.replace(numberRegex, code, "")
                      write_file(code, out_filename)
                    else
                      if Regex.match?(booleanRegex, word) do
                        result = Regex.run(booleanRegex, code)
                        html = "<span class=\"boolean\">#{result}</span>"
                        File.write(out_filename, html, [:append])
                        code = Regex.replace(booleanRegex, code, "")
                        write_file(code, out_filename)
                      else
                        result = word
                        html = "<span>#{result}</span>"
                        File.write(out_filename, html, [:append])
                        # TODO : remove the word from the code
                        code = Regex.replace(word, code, "")
                        write_file(code, out_filename)
                      end
                    end
                    end
                  end
                end
              end
          end)
        end
      end)
  end

end
