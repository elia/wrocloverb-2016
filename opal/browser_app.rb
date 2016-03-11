require 'opal'
require 'browser'
require 'browser/interval'
require 'tretris'

game = Tretris::Game.new
output_grid = []

DOM {
  h1 "TRETRIS"
  table(style: "border: 1px black dotted; margin: auto") {
    game.height.times { |y|
      tr {
        game.width.times { |x|
          td(style: "width: 30px;height: 30px;")
        }
      }
    }
  }
}.append_to($document.body)

colors = %w[😀 ❤️ 🎩 🤖 🐸]
color_map = {}

render = -> {
  $document.css("h1").text = game.over? ? "GAME OVER" : "POINTS: #{game.points}"
  game.height.times { |y|
    output_grid[y] ||= []
    game.width.times { |x|
      color = game.lines[y][x]
      cell = $document.css("tr:nth-child(#{y+1}) td:nth-child(#{x+1})")
      char = (color_map[color] ||= colors.shift) if color
      cell.text = char
    }
  }
}

$document.body.on :keydown do |event|
  game.move(event.key.downcase)
  render.call
end

$window.every 0.5 do
  game.tick
  render.call
end
