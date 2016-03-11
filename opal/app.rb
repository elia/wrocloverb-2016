require 'opal'
require 'inesita'
require 'browser/interval'
require 'tretris'

class Ouput
  include Inesita::Component

  def render
    game = store

    h3 { "Points: #{game.points}" }
    h3 { "Next: #{game.next_shape.name}" }
    h3 { "Paused (Press the spacebar to resume)" } if $pause
    h3 { "GAME OVER" if game.over? }

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

