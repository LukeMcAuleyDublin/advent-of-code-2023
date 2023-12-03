defmodule DayOne do
  def solution_one do
    Parser.input_one()
    |> Enum.map(&Parser.read_string/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end
end
