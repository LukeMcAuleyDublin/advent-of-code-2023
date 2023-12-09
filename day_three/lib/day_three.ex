require IEx

defmodule DayThree do
  def solution do
    grid =
      input()
      |> String.split()
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, y} ->
        Parser.parse_line(line, {0, y, []})
      end)

    {parts, ids} =
      grid
      |> Enum.split_with(fn {_, value} ->
        is_binary(value)
      end)

    parts = Map.new(parts)
    ids = Map.new(ids)

    used_parts =
      for {xy, _} <- parts,
          dxy <- Parser.around(xy),
          {:ok, val} <- [Map.fetch(ids, dxy)],
          into: %{},
          do: val

    # IO.puts "Parts: #{Enum.sum(Map.values(used_parts))"

    cogs =
      for {xy, "*"} <- parts,
          values =
            Map.take(ids, Parser.around(xy))
            |> Map.values()
            |> Enum.uniq()
            |> Enum.map(&elem(&1, 1)),
          match?([_, _], values),
          do: Enum.product(values)

    IO.puts("Parts: #{Enum.sum(Map.values(used_parts))}")
    IO.puts("Cogs: #{Enum.sum(cogs)}")
  end

  def input do
    File.read!(~c"./input.txt")
    |> String.replace("\r", "")
  end
end
