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
    doc_tail = "</pre></body></html>"

    # Regular expressions
    commentRegex = ~r/\/\/(|\r)*|\/\*(.|\n|\r)*\*\//
    stringRegex = ~r/(["'])(?:(?=(\\?))\2.)*?\1/
    keywordRegex = ~r/\b(?:abstract|await|boolean|break|byte|case|catch|char|class|const|continue|debugger|default|delete|do|double|else|enum|export|extends|final|finally|float|for|function|goto|if|implements|import|in|instanceof|int|interface|let|long|native|new|null|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|try|typeof|var|void|volatile|while|with|yield)\b/
    numberRegex = ~r/\b-?\d+\.?(\d+)?\b/
    booleanRegex = ~r/\b(?:true|false)\b/

    # initialize html output file
    File.write(out_filename, doc_head)

    # read js file
    code = File.read!(in_filename)

    # find and highlight keywords
    highlighted_code =
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
            if Regex.match?(~r/\/\/.*/, word) do
              Regex.replace(commentRegex, word, "<span class=\"comment\">\\0</span>")
            else
              if Regex.match?(stringRegex, word) do
                "<span class=\"string\">#{word}</span>"
                else
                  if Regex.match?(keywordRegex, word) do
                    "<span class=\"keyword\">#{word}</span>"
                  else
                    if Regex.match?(numberRegex, word) do
                      "<span class=\"number\">#{word}</span>"
                    else
                      if Regex.match?(booleanRegex, word) do
                        "<span class=\"boolean\">#{word}</span>"
                      else
                        "<span>#{word}</span>"
                      end
                    end
                  end
                end
              end
          end)
          # join the words again
          |> Enum.join("")
        end
      end)
      # join the lines again with a <br> tag
      |> Enum.join("<br>")

    # write the highlighted code to the html file
    File.write(out_filename, highlighted_code, [:append])

    # close the tags of the html file and finish
    File.write(out_filename, doc_tail, [:append])

  end

end
