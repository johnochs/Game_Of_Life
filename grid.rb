require_relative './cell'

class Grid
  
  def initialize(size, input_options = {})
    default_options = {auto_pop: true, rand_pop_factor: 20}
    options = default_options.merge(input_options)
    
    @size = size
    @rand_pop_factor = options.fetch(:rand_pop_factor)
    @grid = initialize_grid
    auto_populate if options.fetch(:auto_pop) == true
  end
  
  def initialize_grid
    Array.new(@size) { Array.new(@size) }
  end
  
  def auto_populate
    @grid.each_with_index do |row, i|
      row.each_with_index do |el, j|
        alive = rand(100) < (@rand_pop_factor) ? true : false
        @grid[i][j] = Cell.new([i, j], @grid, alive)
      end
    end
  end
  
  def [](pos)
    row, col = pos
    @grid[row][col]
  end
  
  def display
    @grid.each do |row|
      row_str = ""
      row.each do |el|
        row_str += el.render
      end
      puts row_str
    end
    nil
  end
  
  def next_board
    alive_next_round = []
    dead_next_round = []
    
    @grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if alive_next_round?(cell)
          alive_next_round << cell
        else
          dead_next_round << cell
        end
      end
    end
    
    alive_next_round.each { |cell| cell.revive! }
    dead_next_round.each { |cell| cell.die! }
  end
  
  def alive_next_round?(cell)
    live_neighbors = count_live_neighbors(cell.pos)
    
    case live_neighbors
    when 0 || 1
      return false
    when 2
      return false if cell.dead?
      return true
    when 3
      return true
    else
      return false
    end
  end
  
  private
  
  ADJ_DIRS = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]
  
  def adjacent_positions(pos)
    adj_positions = []
    
    ADJ_DIRS.each do |dir|
      adj_positions << [dir[0] + pos[0], dir[1] + pos[1]]
    end
    
    adj_positions
  end
  
  def count_live_neighbors(pos)
    adjacent_positions(pos).select do |adj_pos|
      on_board?(adj_pos) && self[adj_pos].alive?
    end.count
  end
  
  def on_board?(pos)
    pos.all? { |x| x.between?(0, @size - 1) }
  end
  
end
