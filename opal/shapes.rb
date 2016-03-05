Shape = Struct.new(:map, :color, :height)

VerticalLine = Shape.new(
  -> x,y {
    [
      [x, y+0],
      [x, y+1],
      [x, y+2],
      [x, y+3],
    ]
  },
  :yellow,
  4
)

Square = Shape.new(
  -> x,y {
    [
      [x, y  ], [x+1, y  ],
      [x, y+1], [x+1, y+1],
    ]
  },
  :green,
  2
)

El = Shape.new(
  -> x,y {
    [
      [x, y+1],
      [x, y+2],
      [x, y+3], [x+1, y+3],
    ]
  },
  :blue,
  3
)

Es = Shape.new(
  -> x,y {
    [
                [x+1, y  ], [x+2, y  ],
      [x, y+1], [x+1, y+1],
    ]
  },
  :pink,
  2
)

Shapes = [
  VerticalLine,
  Es,
  El,
  Square,
]
