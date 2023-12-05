require IEx

defmodule MapCompare do
  def values_not_greater?(map, maximum) do
    Enum.all?(map, fn {key, value_1} ->
      value_2 = Map.get(maximum, String.to_atom(key), 0)

      value_1 <= value_2
    end)
  end
end

