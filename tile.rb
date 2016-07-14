class Tile

  attr_reader :value

  def initialize(value)
    @value = value  # X, 1, _

    @revealed = false
  end

  def reveal_tile
    @revealed = true
  end

  def neighbor_bomb_count

  end

  def bomb?
    @value == "X"
  end

end
