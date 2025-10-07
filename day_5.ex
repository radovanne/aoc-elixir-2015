defmodule DayFive do
  @moduledoc """
  Advent of Code 2015 - Day 5: Find how many string are not naughty.
  """

  def get_task_data do
    "./input_5.txt"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end
   
   def check_if_nice(s) 
   end

  def task_one do
    get_task_data()
  end
end
