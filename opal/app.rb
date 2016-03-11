require 'opal'
require 'inesita'
require 'browser/interval'
require 'shapes'
require 'grid'
require 'game'

class Ouput
  include Inesita::Component

  def render
    game = store

    h2 "Points: #{game.points}"
    h2 "Next: #{game.next_shape.inspect}"
    text "Paused (Press the spacebar to resume)" if game.paused
    text game.JS[:pos].inspect

    table(style: {border: '1px black dotted'}, margin: :auto) {
      game.height.times { |y|
        tr {
          game.width.times { |x|
            td(style: {
              width: '30px',
              height: '30px',
              backgroundColor: game.lines[y][x],
            })
          }
        }
      }
    }
  end
end


$game = Tretris::Game.new
$output = Ouput.new.with_store($game)

$document.ready {
  $output.mount_to($document.body)

  $document.body.on :keydown do |event|
    if event.code == 32 #Spacebar
      $pause = !$pause
      next
    end

    $game.move(event.key.downcase)
    $output.render!
  end

  $window.every 0.8 do
    next if $pause
    $game.tick
    $output.render!
  end
}

