defmodule LogicTest do
  use ExUnit.Case
  alias Game.Logic

  @table [%{card: "First", player: 2, used: nil}, %{card: "Last", player: 1, used: nil}]

  test "should return last move" do
    {first, _, player, _} = Logic.get_last_card(@table)
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
    %{rest: rest, table: table, cards: player_cards} = Logic.buy_two(1, rest, @table, [])

    assert Enum.count(rest) == 2
    assert List.last(table).used == true
    assert Enum.count(player_cards) == 2
  end

  test "should perform wild4 action" do
    rest = ["First", "Second", "Third", "Fourth"]
    %{rest: rest, table: table, cards: player_cards} = Logic.buy_four(1, rest, @table, [])

    assert rest == []
    assert List.last(table).used == true
    assert Enum.count(player_cards) == 4
  end

  test "should skip" do
    %{rest: rest, table: table, cards: cards} = Logic.buy_four(1, [], @table, [])
    assert rest == []
    assert List.last(table).used == true
    assert cards == []
  end

  test "should return shuffle the table to rest" do
    {rest, table} = Logic.check_cards([], @table)

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
      transformed_card = Logic.transform_wild(card, ["Red draw2"])
      [hd | _] = String.split(transformed_card, " ")

      assert Enum.member?(["Red"], hd) == true
      assert hd !== "Wild"
    end
  end

  test "should transform wild cards without any other card" do
    wild_cards = ["Wild Color", "Wild Draw4"]

    for card <- wild_cards do
      transformed_card = Logic.transform_wild(card, [])
      [hd | _] = String.split(transformed_card, " ")

      assert Enum.member?(["Red", "Green", "Blue", "Yellow"], hd) == true
      assert hd !== "Wild"
    end
  end

  test "should return card when is not a wild card" do
    assert Logic.transform_wild("Not transform me", []) == "Not transform me"
  end

  test "should return colors from cards" do
    color = Logic.get_color(["Red draw2"])

    assert color == "Red"
  end

  test "should mark a card as used" do
    table = Logic.use_last_card(@table)
    assert List.last(table).used == true
  end
end
