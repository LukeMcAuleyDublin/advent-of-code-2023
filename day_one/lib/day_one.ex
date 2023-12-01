defmodule DayOne do
  def solution_one do
    results =
      input_one()
      |> Enum.map(&extract_and_combine/1)
      |> Enum.filter(&is_integer/1)

    IO.inspect(Enum.at(results, -1))
    IO.puts("Results: #{results}")

    sum = Enum.sum(results)
    IO.puts("Sum of results: #{sum}")
  end

  def input_one do
    {:ok, text} = File.read(~c"./input_one.txt")

    # remove last as it's an empty string
    String.split(text, "\n") |> List.delete_at(-1)
  end

  @spec extract_and_combine(String.t()) :: integer | nil
  def extract_and_combine(string) do
    regex = ~r/\d+/

    numbers =
      Regex.scan(regex, string)
      |> Enum.map(&String.to_integer(Enum.at(&1, 0, "0")))

    case numbers do
      [] ->
        IO.puts("No numbers found in the string.")
        nil

      [number] ->
        number

      [first | _rest] ->
        last = List.last(numbers)

        combined_value =
          (Integer.to_string(first) <> Integer.to_string(last))
          |> String.to_integer()

        combined_value
    end
  end
end
