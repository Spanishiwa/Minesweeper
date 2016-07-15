class Tile

  attr_reader :value, :revealed

  def initialize(value, revealed = false)
    @value = value  # X, 1, _

    @revealed = revealed
  end

  def reveal_tile
    @revealed = true
  end

  def bomb?
    @value == "X"
  end

end
