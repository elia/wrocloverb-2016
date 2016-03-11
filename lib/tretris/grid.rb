module Tretris

class Grid
  def initialize(width:, height:)
    @width    = width
    @height   = height
    @new_line = proc { Array.new width }
    @lines    = Array.new(height, &@new_line)
    @deleted  = 0
  end

  attr_reader :lines, :width, :height, :deleted

  def update_for(shape, x:, y:)
    update = {}
    shape.map[x,y].each { |x,y|
      next if y < 0
      line = (update[y] ||= @lines[y].dup)
      line[x] = shape.color
    }
    update
  end

  def apply_lines(update)
    deleted = 0
    update.each do |y,line|
      if line.all?
        deleted += 1
        @lines[y] = nil
      else
        @lines[y] = line
      end
    end
    @deleted += deleted
    @lines = Array.new(deleted, &@new_line) + @lines.reject(&:nil?)
  end

  def with_update(update)
    new_lines = []
    @height.times do |y|
      new_lines[y] = update[y] || @lines[y]
    end
    new_lines
  end

  def can_add?(shape, x:, y:)
    lines  = @lines
    points = shape.map[x,y]
    points.all?(&method(:available?))
  end

  def available?(point)
    x, y = *point
    return false if x > @width-1 || y > @height-1 || x < 0
    return true if y < 0 # above the grid
    !@lines[y][x]
  end

  def color_for(x,y, lines: @lines)
    lines[x][y]
  end
end

end
