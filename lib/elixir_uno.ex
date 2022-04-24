defmodule ElixirUno do
  alias Game.Cards
  alias Game.Printer

  def start do
    deck = create_deck()
    first_game_card = select_initial_game_card(deck.rest)
    table = [%{card: first_game_card , player: 0, used: nil}]
    rest = deck.rest -- [first_game_card]
    player1_pid = spawn(NPC.Player1, :loop, [deck.player1])
    player2_pid = spawn(NPC.Player2, :loop, [deck.player2])

    Printer.white("GAME LOG: Starting Uno Game")
    send(player1_pid, {:player1, player2_pid, table, rest})
    Printer.green("GAME LOG: First table card is #{first_game_card}")
  end

  defp create_deck do
    cards = Cards.generate_deck()
    {player1, rest} = take(cards)
    {player2, rest} = take(rest)

    %{player1: player1, player2: player2, rest: rest}
  end

  defp take(cards, qtd \\ 8) do
    Enum.split(cards, qtd)
  end

  defp select_initial_game_card(cards) do
    number = Enum.random(0..9)
    Enum.find(cards, fn card -> String.contains?(card, " #{number}") end)
  end
end
