defmodule LogicTest do
  use ExUnit.Case
  alias Game.Logic

  test "should return last move" do
    table = [%{card: "First", player: 2}, %{card: "Last", player: 1}]
    {first, _, player} = Logic.get_last_card(table)
    assert first == "Last"
    assert player == 1
  end

  test "should buy a card" do
    cards = ["First"]
    assert Logic.buy_one(cards) == "First"
  end

  test "should buy 2 cards" do
    cards = ["First", "Second", "Third", "Fourth"]
    buy = Logic.buy(cards, 2)

    assert Enum.count(buy) == 2
  end

  test "should perform wild2 action" do
    rest = ["First", "Second", "Third", "Fourth"]
    %{rest: rest, table: table, cards: player_cards} = Logic.buy_two(1, rest, [], [])

    assert Enum.count(rest) == 2
    assert table == []
    assert Enum.count(player_cards) == 2
  end

  test "should perform wild4 action" do
    rest = ["First", "Second", "Third", "Fourth"]
    %{rest: rest, table: table, cards: player_cards} = Logic.buy_four(1, rest, [], [])

    assert rest == []
    assert table == []
    assert Enum.count(player_cards) == 4
  end

  test "should skip" do
    %{rest: rest, table: table, cards: cards} = Logic.buy_four(1, [], [], [])
    assert rest == []
    assert table == []
    assert cards == []
  end

  test "should return shuffle the table to rest" do
    {rest, table} =
      Logic.check_cards([], [%{card: "First", player: 2}, %{card: "Last", player: 1}])

    assert table == []
    assert Enum.count(rest) == 2
  end

  test "should return a card" do
    cards = ["First"]
    assert Logic.take_card(cards) == "First"
  end

  test "should transform wild cards" do
    wild_cards = ["Wild Color", "Wild Draw4"]

    for card <- wild_cards do
      transformed_card = Logic.transform_wild(card)
      [hd | _] = String.split(transformed_card, " ")

      assert Enum.member?(["Blue", "Green", "Yellow", "Red"], hd) == true
      assert hd !== "Wild"
    end
  end

  test "should return card when is not a wild card" do
    assert Logic.transform_wild("Not transform me") == "Not transform me"
  end
end
