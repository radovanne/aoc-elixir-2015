defmodule DayOne do
  @moduledoc """
  Advent of Code 2015 - Day 1:
  Floor calculation based on parentheses instructions.
  """

  @doc """
  Reads input from file and returns list of characters.
  """
  def get_task_data(), do: File.read!("./input_1.txt") |> String.graphemes()

  @doc """
  Recursively calculates the floor level from instructions.
  '(' increases floor, ')' decreases floor.
  """
  def calc_floor([], acc), do: acc
  def calc_floor(["(" | tail], acc), do: calc_floor(tail, acc + 1)
  def calc_floor([")" | tail], acc), do: calc_floor(tail, acc - 1)

  @doc """
  Solves task one: finds final floor after all instructions.
  """
  def task_one() do
    calc_floor(get_task_data(), 0)
  end

  @doc """
  Recursively finds position where floor reaches -1.
  '(' increases floor, ')' decreases floor.
  Raises error if basement is never reached.
  """
  def find_basement_position(_, -1, pos), do: pos

  def find_basement_position(["(" | tail], acc, pos),
    do: find_basement_position(tail, acc + 1, pos + 1)

  def find_basement_position([")" | tail], acc, pos),
    do: find_basement_position(tail, acc - 1, pos + 1)

  def find_basement_position(_, _acc, _pos), do: raise("Basement never reached!")

  @doc """
  Solves task two: returns position of first basement entry.
  """
  def task_two() do
    find_basement_position(get_task_data(), 0, 0)
  end
end
