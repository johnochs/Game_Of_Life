require 'colorize'

class Cell
  attr_reader :alive, :pos
  
  def initialize(pos, board, alive = false)
    @pos = pos
    @board = board
    @alive = alive
  end
  
  def revive!; @alive = true; end
  
  def die!; @alive = false; end
  
  def dead?; @alive == false; end
  
  def alive?; @alive == true; end
  
  def render
    background = alive? ? :black : :white
    "   ".colorize( :background => background)
  end

end