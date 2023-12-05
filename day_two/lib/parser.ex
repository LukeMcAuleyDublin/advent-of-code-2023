require IEx

defmodule Parser do
  @max_colours %{
    red: 12,
    green: 13,
    blue: 14
  }

  def parse_line(line, acc) do
    [game_id, rest] =
      String.split(line, ~r/:\s/, parts: 2)
      |> Enum.map(&String.trim/1)

    game_id =
      String.split(game_id, ~r/\s/, parts: 2)
      |> List.last()
      |> String.to_integer()

    counts =
      rest
      |> String.split(~r/[;]/)
      |> Enum.map(fn str -> String.split(str, ~r/[,]/) end)
      |> Enum.reduce([], &parse_colour_count/2)

    if Enum.any?(counts, fn x -> x == false end) do
      acc
    else
      acc ++ [game_id]
    end
  end

  def parse_colour_count(colour_count, acc) do
    banana =
      Enum.map(colour_count, fn counter ->
        String.split(String.trim(counter), ~r/\s/, parts: 2)
        |> Enum.map(&String.trim/1)
      end)
      |> Enum.reduce(%{}, fn [number_str, colour_str], acc ->
        acc |> Map.put(colour_str, String.to_integer(number_str))
      end)

    if MapCompare.values_not_greater?(banana, @max_colours) == true do
      [true | acc]
    else
      [false | acc]
    end
  end
end
