require IEx

defmodule DayTwo do
  def solution do
    input()
    |> Enum.reduce([], &Parser.parse_line/2)
    |> Enum.sum()
  end

  def solution_two do
    input()
    |> Enum.reduce(0, &Parser.get_biggest/2)
  end

  def input do
    {:ok, text} = File.read(~c"./input.txt")
    String.split(text, ~r/\n/) |> List.delete_at(-1)
  end
end
