require './board'

class Minesweeper
  attr_reader :game

  def initialize
    @game = Board.new
  end

  def set_up
    @game.populate_bombs
    @game.populate_numbers
  end

  def prompt
    puts "Enter your move (index, index)"
    move = gets.chomp.split(',').map(&:to_i)
    # byebug
    prompt unless game.valid_pos?(move)
    return move
  end

  # def play
  #
  #
  # end

  def over?
    game.board.each do |row|
      row.each do |el|
        if !el.nil? && el.revealed
          return true if el.value == "X"
        end
      end
    end
    false
  end
end
