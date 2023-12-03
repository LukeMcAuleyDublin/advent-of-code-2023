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
    word_regex = ~r/(one|two|three|four|five|six|seven|eight|nine)/
    number_regex = ~r/(?<!\d)\b\d\b(?!d)/

    word_instances = Regex.scan(word_regex, string) |> Enum.flat_map(&Enum.uniq/1)
    number_instances = Regex.scan(number_regex, string)

    word_number_instances = word_instances <> number_instances

    determine_positions(string, word_number_instances)
  end

  # Determine positions of words and numbers in string, and return first and last
  def determine_positions(string, instances) do
    IO.puts(string, instances)
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
