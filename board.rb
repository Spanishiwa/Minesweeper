require './tile'
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9) { Array.new(9) }
    @known_bomb_pos = []
  end

  def [](pos)
    r, c = pos
    board[r][c]
  end


  def []=(pos, val)
    r, c = pos
    tile = board[r][c]
    tile.value = val
  end

  def render
    p "   #{(0..8).to_a.join("  ")}"
    board.each_with_index do |row, id|
      new_row = row.map do |el|
        if el.nil? #|| el == "X"
          "$"
        else
          el.value
        end
      end
      p "#{id}  #{new_row.join("  ")}"
    end
  end


  def get_random_positions
    @rows = @board.length
    @cols = @board.first.length
    available_pos = []
    (0...rows).each do |row|
      (0...cols).each do |col|
        available_pos << [row, col]
      end
    end
    available_pos.shuffle.take(10)
  end

  def populate_bombs
    bomb_positions = get_random_positions
    bomb_positions.each{|pos| @known_bomb_pos << pos}
    until bomb_positions.empty?
      r, c = bomb_positions.shift
      board[r][c] = Tile.new("X")
    end
  end

  def populate_numbers


  end

  def check_valid_positions(pos)
    r, c = pos
    scan_range = [ [r, (c-1)], [(r-1), (c-1)], [(r-1), (c-1)], [r, (c+1)],\
    [(r+1), (c+1)], [(r-1), (c+1)], [r, (c+1)], [(r+1), c] ]
    

  end

end
