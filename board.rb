require './tile'
require "byebug"
class Board
  attr_accessor :board, :seen_positions, :rows, :cols

  def initialize
    @board = Array.new(9) { Array.new(9) }
    @known_bomb_pos = []
    @rows = @board.length
    @cols = @board.first.length
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
        if el.nil? || !el.revealed
          "$"
        else
          el.value
        end
      end
      p "#{id}  #{new_row.join("  ")}"
    end
    ""
  end


  def get_random_positions
    available_pos = []
    (0...@rows).each do |row|
      (0...@cols).each do |col|
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
    @known_bomb_pos.each do |pos|
      scan_positions(pos).each do |pos2|
        populate_scanned(pos2)
      end
    end
  end

  def populate_scanned(pos)
    r, c = pos
    if board[r][c].nil?
      board[r][c] = Tile.new(1)
    elsif board[r][c].value != "X"
      board[r][c] = Tile.new(1+board[r][c].value)
    end
  end

  def scan_positions(pos, for_nil = false)
    r, c = pos
    # scan_range = [ [r, (c-1)], [(r+1), (c-1)], [(r-1), (c-1)], [r, (c+1)],\
    # [(r+1), (c+1)], [(r-1), (c+1)], [r, (c+1)], [(r+1), c] ]

    left = [r, c-1]
    uleft = [r-1, c-1]
    up = [r-1, c]
    uright = [r-1, c+1]
    right = [r, c+1]
    dright = [r+1, c+1]
    down = [r+1, c]
    dleft = [r+1, c-1]
    scan_range = [left, uleft, up, uright, right, dright, down, dleft] unless for_nil
    scan_range = [left, up, right, down] if for_nil

    scan_range.select{|arr| valid_pos?(arr)}

  end

  def valid_pos?(arr)
    r, c = arr
    r >= 0 && r < @rows && c >= 0 && c < @cols
  end

  def place_move(pos)
    raise "Invalid move" unless valid_pos?(pos)
    if self[pos].nil?
      find_nil_positions(pos).each do |arr|
        r, c = arr
        board[r][c] = Tile.new(" ", true)
      end
    else
      self[pos].reveal_tile
    end
  end

  def find_nil_positions(pos)
    nil_positions = [pos]
    start_positions = [pos]
    # byebug
    until start_positions.empty?
      new_positions = []
      start_positions.each do |pos|
        scan_positions(pos, true).each do |adj_pos|
          next if nil_positions.include?(adj_pos)
          if self[adj_pos].nil?
            nil_positions << adj_pos
            new_positions << adj_pos
          end
        end
      end
      start_positions = new_positions
    end
    nil_positions
  end
end
