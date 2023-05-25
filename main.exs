# JavaScript syntax highlighter

# Rodrigo Núñez Magallanes, A01028310
# Andrea Alexandra Barrón Córdova,

defmodule Highlighter do

# Regular expressions
keywordEx = ~r/\b(?:abstract|await|boolean|break|byte|case|catch|char|class|const|continue|debugger|default|delete|do|double|else|enum|export|extends|false|final|finally|float|for|function|goto|if|implements|import|in|instanceof|int|interface|let|long|native|new|null|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|true|try|typeof|var|void|volatile|while|with|yield)\b/
# number (int or float)
# boolean (true or false)
# string (encapsulated in quotation marks)
# comment (starts with // and finishes on newline OR starts at /* and finishes on next */)

def highlight() do
  # text = "await consequence = loki"
  # if Regex.match?(keywordEx, text) do
  #   IO.puts("Pattern matched!")
  # else
  #   IO.puts("Pattern not matched.")
  # end
  # const name=kol
end

end
