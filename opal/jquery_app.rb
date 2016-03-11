require 'opal'
require 'js'
require 'jquery'
require 'opal-jquery'
require 'tretris'

game = Tretris::Game.new
pause = false
output_grid = []
game = game
td_style =

line_html = Array.new(game.width, %{<td style="width: 30px;height: 30px;"></td>}).join
grid_html = Array.new(game.height, "<tr>"+line_html+"</tr>").join

Element[:body] << %{<h1>TRETRIS</h1>}
Element[:body] << %{<table style="border: 1px black dotted; margin: auto">#{grid_html}</table>}

colors = %w[😀 ❤️ 🎩 🤖 🐸]
color_map = {}

render = -> {
  Element[:h1].text = game.over? ? "GAME OVER" : "POINTS: #{game.points}"
  game.height.times { |y|
    output_grid[y] ||= []
    game.width.times { |x|
      color = game.lines[y][x]
      cell = Element["tr:nth-child(#{y+1}) td:nth-child(#{x+1})"]
      char = (color_map[color] ||= colors.shift) if color
      cell.text = char
    }
  }
}

Element[:body].on :keydown do |event|
  key = {
    37 => :left,
    39 => :right,
    38 => :up,
    40 => :down,
  }[event.which]

  game.move(key)
  render.call
end

JS.setInterval -> {
  game.tick
  render.call
}, 500
