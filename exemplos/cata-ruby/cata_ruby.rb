require 'gosu'
require 'jogador'
require 'mapa'

class CataRuby < Gosu::Window
  attr_reader :map

  def initialize
    super(640, 480, false)
    self.caption = "Cata Ruby"
    @sky = Gosu::Image.new(self, "Space.png", true)
    @map = Mapa.new(self, "Mapa.txt")
    @jogador = Jogador.new(self, 400, 100)
    # Posicao da "camera" é no topo esquerdo do mapa
    @camera_x = @camera_y = 0
  end
  def update
    move_x = 0
    move_x -= 5 if button_down? Gosu::KbLeft
    move_x += 5 if button_down? Gosu::KbRight
    @jogador.update(move_x)
    @jogador.collect_gems(@map.gems)
    # camera segue o jogador
    @camera_x = [[@jogador.x - 320, 0].max, @map.width * 50 - 640].min
    @camera_y = [[@jogador.y - 240, 0].max, @map.height * 50 - 480].min
  end
  def draw
    @sky.draw 0, 0, 0
    translate(-@camera_x, -@camera_y) do
      @map.draw
      @jogador.draw
    end
  end
  def button_down(id)
    if id == Gosu::KbUp then @jogador.try_to_jump end
    if id == Gosu::KbEscape then close end
  end
end

