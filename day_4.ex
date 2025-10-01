defmodule DayFour do
  @moduledoc """
  Advent of Code 2015 - Day 4: Mining Advent coins. TCO
  """

  # This changes 
  @task_data "iwrupvqb"

  def check_md5_hash(s, suffix, required_start) do
    hash = :crypto.hash(:md5, s <> Integer.to_string(suffix)) |> Base.encode16(case: :lower)

    if hash |> String.starts_with?(required_start) do
      suffix
    else
      check_md5_hash(s, suffix + 1, required_start)
    end
  end

  def get_md5_suffix(s, suffix, required_start \\ "00000") do
    check_md5_hash(s, suffix, required_start)
  end

  def task_one do
    get_md5_suffix(@task_data, 1)
  end

  def task_two do
    get_md5_suffix(@task_data, 1, "000000")
  end
end

defmodule DayFourStream do
  @moduledoc """
  Advent of Code 2015 - Day 4: Mining Advent coins. Stream
  """

  # This changes 
  @task_data "iwrupvqb"

  defp find_advent_coin(prefix, required_start \\ "00000") do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(fn suffix ->
      hash =
        :crypto.hash(:md5, prefix <> Integer.to_string(suffix))
        |> Base.encode16(case: :lower)

      {suffix, hash}
    end)
    |> Enum.find(fn {_suffix, hash} ->
      String.starts_with?(hash, required_start)
    end)
    |> elem(0)
  end

  def task_one do
    find_advent_coin(@task_data)
  end

  def task_two do
    find_advent_coin(@task_data, "000000")
  end
end
