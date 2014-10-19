require_relative './grid'

class Game
  
  def initialize
    system("clear")
    @grid_size, @population = get_parameters
    @grid = Grid.new(@grid_size, rand_pop_factor: @population)
    run
  end
  
  def get_parameters
    puts "Welcome to Conway's Game of Life!"
    puts
    sleep(2)
    grid_size = prompt("What dimension should the game be?  (nxn): ")
    population = prompt("What percentage of cells should initially be alive? (e.g 20, 65): ")
    [grid_size, population]
  end
  
  def prompt(query)
    print query
    input = Integer(gets.chomp)
    puts
    input
  rescue
    puts "That wasn't a valid entry."
    retry
  end
  
  def run
    loop do
      system("clear")
      @grid.display
      @grid.next_board
      sleep(0.05)
    end
  end
  
end

Game.new