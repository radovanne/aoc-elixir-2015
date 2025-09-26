defmodule DayTwo do
  @moduledoc """
  Advent of Code 2015 - Day 2:
  Wrapping paper and ribbon calculation for cuboid presents.
  """

  @doc """
  Reads and transforms task data from input file.
  """
  def get_task_data() do
    "./input_2.txt"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "x"))
    |> Stream.map(&to_int_list/1)
    |> Enum.to_list()
  end

  @doc """
  Converts list of strings to integers.
  """
  def to_int_list(strings) do
    Enum.map(strings, &String.to_integer/1)
  end

  @doc """
  Calculates the wrapping paper needed for a present.
  """
  def calc_paper_amount([l, w, h]) do
    sides = [l * w, w * h, h * l]
    Enum.sum(sides) * 2 + Enum.min(sides)
  end

  @doc """
  Calculates the ribbon needed for a present.
  """
  def calc_ribbon_length([l, w, h] = dimensions) do
    [x, y | _] = Enum.sort(dimensions)
    perimeter = 2 * (x + y)
    volume = l * w * h
    perimeter + volume
  end

  @doc """
  Part 1: Total square feet of wrapping paper needed.
  """
  def task_one do
    get_task_data()
    |> Enum.map(&calc_paper_amount/1)
    |> Enum.sum()
  end

  @doc """
  Part 2: Total feet of ribbon needed.
  """
  def task_two do
    get_task_data()
    |> Enum.map(&calc_ribbon_length/1)
    |> Enum.sum()
  end
end
