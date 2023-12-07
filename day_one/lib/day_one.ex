defmodule DayOne do
  def solution do
    input_one()
    |> Enum.map(&Parser.read_string/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end

  def input_one do
    {:ok, text} = File.read(~c"./input_one.txt")

    # remove last as it's an empty string
    String.split(text, "\n") |> List.delete_at(-1)
  end
end
