defmodule Cards do
  @cards_colors ["Blue", "Yellow", "Green", "Red"]

  def generate_deck do
    deck = generate_special_cards() ++ generate_number_cards() ++ generate_special_color_cards()
    shuffle(deck)
  end

  defp shuffle(list) do
    Enum.shuffle(list)
  end

  defp generate_number_cards do
    for card <- Enum.to_list(0..9) ++ Enum.to_list(1..9), color <- @cards_colors do
      "#{color} #{card}"
    end
  end

  defp generate_special_color_cards do
    for card <- ["Draw 2", "Reverse", "Skip"], color <- @cards_colors, _n <- 1..2 do
      "#{color} #{card}"
    end
  end

  defp generate_special_cards do
    for card <- ["Wild", "Wild Draw 4"], _n <- 1..4 do
      card
    end
  end
end
