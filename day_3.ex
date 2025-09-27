defmodule DayThree do
  @moduledoc """
  Advent of Code 2015 - Day 3: Presents delivery.
  """

  @doc "Reads and transforms task data from input file."
  def get_task_data do
    "./input_3.txt"
    |> File.read!()
    |> String.graphemes()
  end

  @doc "Given a direction character and current position, returns new position."
  def move("^", {x, y}), do: {x, y + 1}
  def move("v", {x, y}), do: {x, y - 1}
  def move(">", {x, y}), do: {x + 1, y}
  def move("<", {x, y}), do: {x - 1, y}

  defp move_all(directions, start) do
    directions
    |> Enum.reduce({start, MapSet.new([start])}, fn direction, {pos, visited} ->
      new_pos = move(direction, pos)
      {new_pos, MapSet.put(visited, new_pos)}
    end)
    |> elem(1)
  end

  def start_delivery(directions, start \\ {0, 0}) do
    move_all(directions, start)
  end

  def start_delivery(santa_directions, robo_directions, start) do
    santa_houses = move_all(santa_directions, start)
    robo_houses = move_all(robo_directions, start)
    MapSet.union(santa_houses, robo_houses)
  end

  def split_by_index(list) do
    Enum.with_index(list)
    |> Enum.reduce(
      {[], []},
      fn
        {item, idx}, {even, odd} when rem(idx, 2) == 0 -> {[item | even], odd}
        {item, _idx}, {even, odd} -> {even, [item | odd]}
      end
    )
    |> then(fn {even, odd} -> {Enum.reverse(even), Enum.reverse(odd)} end)
  end

  @doc "Part 1: How many houses receive at least one present when Santa is delivering?"
  def task_one do
    get_task_data()
    |> start_delivery()
    |> MapSet.size()
  end

  @doc "Part 2: How many houses receive at least one present when Santa and Robo-Santa are delivering?"
  def task_two do
    {santa_directions, robo_directions} =
      get_task_data()
      |> split_by_index()

    start_delivery(santa_directions, robo_directions, {0, 0})
    |> MapSet.size()
  end
end
