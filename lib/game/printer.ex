defmodule Game.Printer do
  import Integer

  def player(num, text) do
    case is_even(num) do
      true -> cyan(text)
      false -> red(text)
    end
  end

  def green(text) do
    (IO.ANSI.green() <> text <> IO.ANSI.reset())
    |> IO.puts()
  end

  def red(text) do
    (IO.ANSI.red() <> text <> IO.ANSI.reset())
    |> IO.puts()
  end

  def yellow(text) do
    (IO.ANSI.yellow() <> text <> IO.ANSI.reset())
    |> IO.puts()
  end

  def white(text) do
    (IO.ANSI.white() <> text <> IO.ANSI.reset())
    |> IO.puts()
  end

  def cyan(text) do
    (IO.ANSI.cyan() <> text <> IO.ANSI.reset())
    |> IO.puts()
  end
end
