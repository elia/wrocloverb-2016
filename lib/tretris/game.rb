require 'tretris/grid'
require 'tretris/shapes'

module Tretris

class Game
  attr_reader :lines, :height, :width, :next_shape, :points, :paused

  def initialize
    @height     = 20
    @width      = 8
    @grid       = Grid.new(width: @width, height: @height)
    @lines      = @grid.lines
    @paused     = true
    @next_shape = Shapes.sample
    @points     = 0
  end

  def next_shape
    shape = @shape = @next_shape
    @next_shape = Shapes.sample

    new_pos = {
      x: (@grid.width/2).to_i,
      y: -shape.height
    }

    if @grid.can_add?(shape, new_pos)
      @update = @grid.update_for(shape, new_pos)
      @pos = new_pos
    else
      p :paused
      @paused = true
    end
  end

  def toggle
    @paused = !@paused
  end

  def tick
    return if @paused
    p :tick
    next_shape if @shape.nil?

    new_pos = {x: @pos[:x], y: @pos[:y]+1}

    if @grid.can_add?(@shape, new_pos)
      @update = @grid.update_for(@shape, new_pos)
      @pos = new_pos
    else
      @grid.apply_lines(@update)
      @points = @grid.deleted
      @shape = nil
    end
  end

  def move(direction)
    new_shape = @shape
    new_pos = @pos

    case direction
    when :left  then new_pos = {x: @pos[:x]-1, y: @pos[:y]  }
    when :right then new_pos = {x: @pos[:x]+1, y: @pos[:y]  }
    when :down  then new_pos = {x: @pos[:x],   y: @pos[:y]+2}
    when :up    then new_shape = @shape.rotated
    end

    if @grid.can_add?(new_shape, new_pos)
      @update = @grid.update_for(new_shape, new_pos)
      @pos   = new_pos
      @shape = new_shape
    end
  end
end

end
