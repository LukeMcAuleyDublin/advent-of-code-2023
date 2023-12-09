defmodule Parser do
  def parse_line("", {_, _, acc}), do: acc
  def parse_line("." <> rest, {x, y, acc}), do: parse_line(rest, {x + 1, y, acc})

  def parse_line(<<c>> <> _ = str, {x, y, items}) when c in ?0..?9 do
    {num, rest} = Integer.parse(str)
    len = floor(:math.log10(num) + 1)
    ref = make_ref()

    points =
      for i <- 0..(len - 1) do
        {{x + i, y}, {ref, num}}
      end

    parse_line(rest, {x + len, y, points ++ items})
  end

  def parse_line(<<c>> <> rest, {x, y, items}) do
    parse_line(rest, {x + 1, y, [{{x, y}, <<c>>} | items]})
  end

  def around({x, y}) do
    for dx <- -1..1, dy <- -1..1, do: {x + dx, y + dy}
  end
end
