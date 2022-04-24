defmodule NPC.Player1 do
  alias Game.Printer
  alias Game.Logic

  def loop(cards) do
    new_cards =
      receive do
        {:player1, pid, table, rest} ->
          Process.sleep(3000)
          result = Logic.execute(1, table, rest, cards)

          case Enum.count(result.cards) do
            0 ->
              Printer.green("PLAYER 1: WINSSSS!")

            1 ->
              Printer.yellow("PLAYER 1: UNOOOOOO!")
              send(pid, {:player2, self(), result.table, result.rest})

            _ ->
              send(pid, {:player2, self(), result.table, result.rest})
          end

          result.cards
      end

    case new_cards do
      [] -> nil
      _ -> loop(new_cards)
    end
  end
end
