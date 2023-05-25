# Functions to work with file Input and Output
# Perform Caesar Cipher on a file
# Also showing the use of pipe operator
#
# Gilberto Echeverria
# 2023-05-04

defmodule FileIO do

  @doc """
  Change one character (received as an ascii numerical value) into another that is
  'offset' distance from the original one
  """
  def char_shift(char, offset) do
    cond do
      # Check if the letter is uppercase
      65 <= char and char <= 90 -> Integer.mod(char - 65 + offset, 26) + 65
      # Check if the letter is lowercase
      97 <= char and char <= 122 -> Integer.mod(char - 97 + offset, 26) + 97
      # Any other character
      true -> char
    end
  end

  @doc """
  Change all the characters in a string using the offset
  """
  def line_shift(line, offset) do
    # Using a lambda function for the map
    #to_string(Enum.map(to_charlist(line), fn char -> char_shift(char, offset) end))
    # Using capture operator for the map
    #to_string(Enum.map(to_charlist(line), &char_shift(&1, offset)))

    # Broken down in steps to use logical sequence
    #temp1 = to_charlist(line)
    #temp2 = Enum.map(temp1, &char_shift(&1, offset))
    #to_string(temp2)

    # Using pipe operator to apply the sequence of functions
    line
    |> to_charlist()
    |> Enum.map(&char_shift(&1, offset))
    |> to_string()
  end

  @doc """
  Cipher a complete file using Caesar encoding
  """
  def caesar_cipher(in_filename, out_filename, offset) do
    # Generate the new ciphered data
    data = in_filename
           |> File.stream!()
           |> Enum.map(&line_shift(&1, offset))
           |> Enum.join("")

    # Store the string in the file
    File.write(out_filename, data)
  end

end
