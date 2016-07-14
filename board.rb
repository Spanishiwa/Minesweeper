class Board
  attr_reader :board
  def initialize
    @board = Array.new(9) { Array.new(9) }
  end

  def render
    p "   #{(0..8).to_a.join("  ")}"
    board.each_with_index do |row, id|
      new_row = row.map do |el|
        if el.nil?
          "$"
        else
          el
        end
      end
      p "#{id}  #{new_row.join("  ")}"
    end

  end

end
