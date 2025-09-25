defmodule DayOne do
  @moduledoc """
  Santa is trying to deliver presents in a large apartment building,
  but he can't find the right floor - the directions he got are a little confusing.

  """

  def get_task_data(), do: File.read!("./input_1.txt") |> String.graphemes()

  def calc_floor([], acc), do: acc
  def calc_floor(["(" | tail], acc), do: calc_floor(tail, acc + 1)

  @doc """
  Recursive function to calculate which floor Santa needs to climb.
  For each '(' add floor and for each ')' subtract floor.
  When list ends return accumulative value which represents floor.
  """
  def calc_floor([")" | tail], acc), do: calc_floor(tail, acc - 1)

  @doc """
  Santa starts on the ground floor (floor 0) and then follows the instructions one character at a time.
  An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.
  The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.
  """
  def task_one() do
    calc_floor(get_task_data(), 0)
  end

  def find_basement_position(_, -1, pos), do: pos

  def find_basement_position(["(" | tail], acc, pos),
    do: find_basement_position(tail, acc + 1, pos + 1)

  def find_basement_position([")" | tail], acc, pos),
    do: find_basement_position(tail, acc - 1, pos + 1)

  @doc """
  Recursive function to find on which floor position Santa goes to the basement.
  For each '(' add floor and for each ')' subtract floor.
  When accumulative value hits -1 return the position.
  """
  def find_basement_position(_, _acc, _pos), do: raise("Basement never reached!")

  @doc """
  Find the position of the first character that causes him to enter the basement (floor -1).
  The first character in the instructions has position 1, the second character has position 2,
  and so on.
  """
  def task_two() do
    find_basement_position(get_task_data(), 0, 0)
  end
end
