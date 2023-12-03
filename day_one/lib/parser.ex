defmodule Parser do
  def input_one do
    {:ok, text} = File.read(~c"./input_one.txt")

    # remove last as it's an empty string
    String.split(text, "\n") |> List.delete_at(-1)
  end

  # First, extract words of numbers, e.g. "five", "four"
  # Then extrct actual numbers, and the appearance rate
  # For each of them, determine position in the string, by removing one from appearance rate.
  # Assign position in string to each number word and number
  # Grab first and last
  # Put them together eg 3 and 2 is then 32
  # return 32 and sum in main
  def read_string(string) do
    word_instances = pull_words(string)
    number_instances = pull_digits(string)

    word_number_instances = word_instances ++ number_instances
    word_number_instances |> Enum.map(&IO.puts/1)

    reorder = find_first_and_last(word_number_instances, string)
    IO.puts(reorder)
  end

  def pull_words(string) do
    regex = ~r/(one|two|three|four|five|six|seven|eight|nine)/
    Regex.scan(regex, string) |> Enum.flat_map(&Enum.uniq/1)
  end

  def pull_digits(string) do
    string
    |> String.replace(~r/[^0-9]/, "")
    |> String.split(~r//, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  # Rearrange based on where appear in string
  def find_first_and_last(list, string) do
    new = []

    list
    |> Enum.flat_map(fn item ->
      {index, _} = :binary.match(string, to_string(item))
      format = [item, index]
      new = [format | new]
    end)

    new |> highest_and_lowest
  end

  def highest_and_lowest(list) do
    current_lowest = ["", 999_999]
    current_highest = ["", -1]

    list
    |> Enum.map(fn pair ->
      if Enum.at(pair, 1) < Enum.at(current_lowest, 1) do
        current_lowest = pair
      end

      if Enum.at(pair, 1) > Enum.at(current_highest, 1) do
        current_highest = pair
      end
    end)

    [Enum.at(current_lowest, 0), Enum.at(current_highest, 0)]
  end
end
