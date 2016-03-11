module Tretris

class Shape
  def initialize(name, maps, color, height)
    @name = name
    @rotation = 0
    @maps, @color, @height = maps, color, height
  end
  attr :height, :color, :rotation, :name

  def rotated
    rotation = @rotation
    rotation += 1
    rotation %= @maps.size

    shape = dup
    shape.rotation = rotation
    shape
  end

  def map
    @maps[@rotation]
  end

  protected

  attr_writer :rotation
end

Shapes = []

Shapes << Shape.new(
  :bar,
  [
    -> x,y {[ [x, y+0],
              [x, y+1],
              [x, y+2],
              [x, y+3], ]},

    -> x,y {[ [x+0, y],[x+1, y],[x+2, y],[x+3, y] ]},
  ],
  :red,
  4
)

Shapes << Shape.new(
  :square,
  [
    -> x,y {[ [x, y  ], [x+1, y  ],
              [x, y+1], [x+1, y+1], ]},
  ],
  :green,
  2
)

Shapes << Shape.new(
  :el,

  [
    -> x,y {[ [x, y  ],
              [x, y+1],
              [x, y+2], [x+1, y+2], ]},

    -> x,y {[ [x, y  ],[x+1, y],[x+2, y],
              [x, y+1], ]},

    -> x,y {[ [x, y], [x+1, y  ],
                      [x+1, y+1],
                      [x+1, y+2], ]},

    -> x,y {[                     [x+2, y  ],
              [x, y+1],[x+1, y+1],[x+2, y+1], ]},
  ],
  :blue,
  3
)

Shapes << Shape.new(
  :es,
  [
    -> x,y {[           [x+1, y  ], [x+2, y  ],
              [x, y+1], [x+1, y+1],             ]},

    -> x,y {[ [x, y  ],
              [x, y+1], [x+1, y+1],
                        [x+1, y+2], ]},
  ],
  :orange,
  2
)


end
