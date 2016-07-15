class Tile

  attr_reader :value, :revealed

  def initialize(value)
    @value = value  # X, 1, _

    @revealed = false
  end

  def reveal_tile
    @revealed = true
  end

  def bomb?
    @value == "X"
  end

end
