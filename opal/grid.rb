class Grid
  def initialize(width:, height:)
    @width = width
    @height = height
    @new_line = -> { Array.new width }
    @lines = Array.new(height, &@new_line)
  end

  attr_reader :lines, :width, :height

  def update_for(shape, x:, y:)
    lines         = @lines
    color         = shape.color
    points        = shape.map[x,y]
    touched_lines = points.map(&:last).uniq
    update = {}

    points.each { |x,y|
      next if y < 0
      line = (update[y] ||= lines[y].dup)
      line[x] = color
    }

    update
  end

  def apply_lines(update)
    full = 0
    update.each do |y,line|
      completed = line.all?
      full += 1
      p [line, full, completed]
      @lines[y] = completed ? nil : line
    end
    @lines = Array.new(full, &@new_line) + @lines.compact
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
