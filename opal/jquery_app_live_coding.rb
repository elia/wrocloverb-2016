require 'opal'
require 'tretris'
require 'jquery'
require 'opal-jquery'


game = Tretris::Game.new
body = Element[:body]

body << "<h1>TRETRIS</h1>"
line = %{<tr>#{"<td style='width:30px;height:30px;'></td>" * game.width}</tr>}
table = %Q{<table style="border: 1px dotted">#{line * game.height}</table>}

body << table

colors = %w[😀 ❤️ 🎩 🤖 🐸]
color_map = {}

print_grid = -> {
  game.height.times do |y|
    game.width.times do |x|
      color = game.lines[y][x]
      case color
      when String, Symbol
        char = color_map[color] ||= colors.shift
      else
        char = ' '
      end
      cell = Element["tr:nth-child(#{y+1}) td:nth-child(#{x+1})"]
      cell.text = char
    end
  end
}

`setInterval(#{-> { game.tick; print_grid.call }}, 500)`

Element[:body].on :keydown do |event|
  key = {
    37 => :left,
    39 => :right,
    38 => :up,
    40 => :down
  }[event.which]

  game.move(key)
  print_grid.call
end
