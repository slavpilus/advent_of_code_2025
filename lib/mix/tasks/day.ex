defmodule Mix.Tasks.Day do
  use Mix.Task

  def run([day, part]) do
   module = Module.concat(AOC, "Day#{String.pad_leading(day, 2, "0")}")
   input = AOC.input(day)
   fun = String.to_atom("part" <> part)

   result = apply(module, fun, [input])
   IO.inspect(result)
  end
end
