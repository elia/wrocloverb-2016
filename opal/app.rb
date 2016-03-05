require 'opal'
require 'inesita'
require 'browser/interval'
require 'shapes'
require 'grid'

class Ouput
  include Inesita::Component

  def initialize(width, height, lines)
    @width = width
    @height = height
    @lines = lines
  end

  attr_writer :lines

  def render
    table(style: {border: '1px black dotted'}) {
      @height.times { |y|
        tr {
          @width.times { |x|
            td(style: {
              border: '1px grey dotted',
              width: '10px',
              height: '10px',
              backgroundColor: @lines[y][x],
            })
          }
        }
      }
    }
  end
end

$grid = Grid.new(width: 8, height: 20)
$output = Ouput.new($grid.width, $grid.height, $grid.lines)

$document.ready {
  $output.mount_to($document.body)

  shape, update, pos, tick = nil

  new_shape = ->{
    shape = Shapes.sample
    new_pos = {
      x: ($grid.width/2).to_i,
      y: -shape.height
    }

    if $grid.can_add?(shape, new_pos)
      update = $grid.update_for(shape, new_pos)
      $output.lines = $grid.with_update(update)
      pos = new_pos
    else
      p :Abort
      tick.abort
    end
  }

  tick = every 0.8 do
    new_shape.call if shape.nil?

    # $grid.clean_lines
    new_pos = {x: pos[:x], y: pos[:y]+1}

    if $grid.can_add?(shape, new_pos)
      update = $grid.update_for(shape, new_pos)
      $output.lines = $grid.with_update(update)
      pos = new_pos
    else
      $grid.apply_lines(update)
      new_shape.call
    end

    $output.render!
  end

  $document.body.on :keydown do |event|
    new_pos = case event.key
              when :Left  then {x: pos[:x]-1, y: pos[:y]  }
              when :Right then {x: pos[:x]+1, y: pos[:y]  }
              when :Down  then {x: pos[:x],   y: pos[:y]+2}
              when :Up    then nil
              end
    if new_pos && $grid.can_add?(shape, new_pos)
      update = $grid.update_for(shape, new_pos)
      $output.lines = $grid.with_update(update)
      pos = new_pos
      $output.render!
    end
  end

}

