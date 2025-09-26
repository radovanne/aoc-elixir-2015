defmodule DayTwo do
  @moduledoc """
  Day 2 solution: wrapping paper calculations for cuboid gifts.
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
  Calculate cuboid face areas.
  """
  def calc_cuboid_faces([l, w, h]) when is_integer(l) and is_integer(w) and is_integer(h) do
    [l * w, w * h, h * l]
  end

  @doc """
  Calculate total wrapping paper needed for a cuboid.
  Includes surface area and area of smallest face.
  """
  def calc_paper_amount([x, y, z] = faces), do: 2 * x + 2 * y + 2 * z + Enum.min(faces)

  @doc """
  Solves task one: sums total paper required for all presents.
  """
  def task_one do
    get_task_data()
    |> Enum.map(&calc_cuboid_faces/1)
    |> Enum.map(&calc_paper_amount/1)
    |> Enum.sum()
  end
end
