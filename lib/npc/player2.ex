defmodule NPC.Player2 do
  alias Game.Printer
  alias Game.Logic

  def loop(cards) do
    new_cards =
      receive do
        {:player2, pid, table, rest} ->
          Process.sleep(500)
          result = Logic.execute(2, table, rest, cards)

          case Enum.count(result.cards) do
            0 ->
              Printer.green("PLAYER 2: WINSSSS!")

            1 ->
              Printer.yellow("PLAYER 2: UNOOOOOO!")
              send(pid, {:player1, self(), result.table, result.rest})

            _ ->
              send(pid, {:player1, self(), result.table, result.rest})
          end

          result.cards
      end

    case new_cards do
      [] -> nil
      _ -> loop(new_cards)
    end
  end
end
