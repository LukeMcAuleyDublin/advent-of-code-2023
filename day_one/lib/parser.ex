require IEx

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

    highest_lowest_pair = find_first_and_last(number_instances, string)
    highest_lowest_pair |> Enum.map(&word_to_number/1)
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
    new =
      list
      |> Enum.map(fn item ->
        {index, _} = :binary.match(string, to_string(item))
        [item, index]
      end)

    new |> highest_and_lowest(["", 999_999_999], ["", -999_999_999])
  end

  def highest_and_lowest([], current_lowest, current_highest) do
    [Enum.at(current_lowest, 0), Enum.at(current_highest, 0)]
  end

  def highest_and_lowest([pair | rest], current_lowest, current_highest) do
    new_lowest =
      if Enum.at(pair, 1) < Enum.at(current_lowest, 1) do
        [Enum.at(pair, 0), Enum.at(pair, 1)]
      else
        current_lowest
      end

    new_highest =
      if Enum.at(pair, 1) > Enum.at(current_highest, 1) do
        [Enum.at(pair, 0), Enum.at(pair, 1)]
      else
        current_highest
      end

    highest_and_lowest(rest, new_lowest, new_highest)
  end

  def word_to_number(word) do
    case word do
      "one" -> 1
      "two" -> 2
      "three" -> 3
      "four" -> 4
      "five" -> 5
      "six" -> 6
      "seven" -> 7
      "eight" -> 8
      "nine" -> 9
      _ -> word
    end
  end
end
