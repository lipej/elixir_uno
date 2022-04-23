defmodule CardsTest do
  use ExUnit.Case
  alias Game.Cards

  @deck Cards.generate_deck()

  test "should genereted a complete deck of cards" do
    assert Enum.count(@deck) == 108
  end

  test "should have 4 special cards for each card" do
    assert Enum.count(@deck, fn card -> card == "Wild Color" end) == 4
    assert Enum.count(@deck, fn card -> card == "Wild Draw4" end) == 4
  end

  test "should have 2 special color cards for each card & color" do
    for card <- ["Draw2", "Reverse", "Skip"], color <- ["Blue", "Yellow", "Green", "Red"] do
      assert Enum.count(@deck, fn x -> x == "#{color} #{card}" end) == 2
    end
  end

  test "Should have 2 cards for each card color from 1..9" do
    for color <- ["Blue", "Yellow", "Green", "Red"], n <- 1..9 do
      assert Enum.count(@deck, fn x -> x == "#{color} #{n}" end) == 2
    end
  end

  test "Should have 1 card 0 for each card color" do
    for color <- ["Blue", "Yellow", "Green", "Red"] do
      assert Enum.count(@deck, fn x -> x == "#{color} 0" end) == 1
    end
  end
end
