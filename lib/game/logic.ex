defmodule Game.Logic do
  alias Game.Printer
  alias Game.Cards

  @compile if Mix.env() == :test, do: :export_all

  def execute(player, table, rest, cards) do
    {first, last, last_player, used} = get_last_card(table)
    can_play = player == last_player
    {checked_rest, checked_table} = check_cards(rest, table)

    case {first, last, can_play, used} do
      {_, "Draw4", false, nil} ->
        buy_four(player, checked_rest, checked_table, cards)

      {_, "Draw2", false, nil} ->
        buy_two(player, checked_rest, checked_table, cards)

      {_, "Reverse", false, nil} ->
        skip(player, checked_rest, checked_table, cards)

      {_, "Skip", false, nil} ->
        skip(player, checked_rest, checked_table, cards)

      _ ->
        match =
          Enum.filter(cards, fn card ->
            String.contains?(card, first) or String.contains?(card, last) or
              String.contains?(card, "Wild")
          end)

        can_play = Enum.empty?(match)

        case can_play do
          false ->
            card_to_play = take_card(match)
            card_transformed = transform_wild(card_to_play, cards)
            Printer.player(player, "PLAYER #{player}: played #{card_to_play}")
            new_player_cards = List.delete(cards, card_to_play)
            new_table = checked_table ++ [%{card: card_transformed, player: player, used: nil}]
            %{table: new_table, rest: checked_rest, cards: new_player_cards}

          _ ->
            Printer.player(player, "PLAYER #{player}: buy one new card")
            new_card = buy_one(rest)
            new_player_cards = cards ++ [new_card]
            new_rest = List.delete(checked_rest, new_card)
            %{table: checked_table, rest: new_rest, cards: new_player_cards}
        end
    end
  end

  def skip(player, rest, table, cards) do
    Printer.player(player, "PLAYER #{player}: cannot play")
    %{table: use_last_card(table), rest: rest, cards: cards}
  end

  def buy_four(player, rest, table, cards) do
    Printer.player(player, "PLAYER #{player}: buy four new cards")
    new_cards = buy(rest, 4)
    %{table: use_last_card(table), rest: rest -- new_cards, cards: cards ++ new_cards}
  end

  def buy_two(player, rest, table, cards) do
    Printer.player(player, "PLAYER #{player}: buy two new cards")
    new_cards = buy(rest, 2)
    %{table: use_last_card(table), rest: rest -- new_cards, cards: cards ++ new_cards}
  end

  def use_last_card(table) do
    last = List.last(table)
    new_table = table |> List.delete(last)

    new_table ++ [%{card: last.card, player: last.player, used: true}]
  end

  def check_cards(rest, table) do
    case Enum.empty?(rest) do
      true ->
        cards = Enum.map(table, fn play -> play.card end)
        {Cards.shuffle(cards), []}

      false ->
        {rest, table}
    end
  end

  def get_last_card(table) do
    last_move = List.last(table)
    list = last_move.card |> String.split(" ")

    {List.first(list), List.last(list), last_move.player, last_move.used}
  end

  def buy_one(rest), do: Enum.random(rest)

  def buy(rest, take), do: Enum.take_random(rest, take)

  def take_card(rest), do: Enum.random(rest)

  def transform_wild(card, cards) do
    is_wild = String.contains?(card, "Wild")
    colors = get_colors(cards)

    if is_wild do
      color = Enum.random(colors)
      Printer.green("GAME LOG: New color is #{color}")
      String.replace(card, "Wild", color)
    else
      card
    end
  end

  def get_colors(cards) do
    Enum.map(cards, fn card -> String.split(card) |> List.first() end)
  end
end
