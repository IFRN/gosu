require 'gosu'
require 'jogador'
require 'mapa'

class CataRuby < Gosu::Window
  attr_reader :map

  def initialize
    super(640, 480)
    self.caption = "Cata Ruby"
    @sky = Gosu::Image.new("Space.png")
    @mapa = Mapa.new("Mapa.txt")
    @jogador = Jogador.new(@mapa, 400, 100)
    # Posicao da "camera" é no topo esquerdo do mapa
    @camera_x = @camera_y = 0
  end

  def update
    move_x = 0
    move_x -= 5 if button_down? Gosu::KbLeft  or button_down?(Gosu::GpLeft)
    move_x += 5 if button_down? Gosu::KbRight or button_down?(Gosu::GpRight)
    @jogador.update(move_x)
    @jogador.collect_gems(@mapa.gems)
    # camera segue o jogador
    @camera_x = [[@jogador.x - 320, 0].max, @mapa.width * 50 - 640].min
    @camera_y = [[@jogador.y - 240, 0].max, @mapa.height * 50 - 480].min
  end

  def draw
    @sky.draw(0, 0, 0)
    # Faz com que tudo dentro do bloco seja desenhado deslocado
    translate(-@camera_x, -@camera_y) do
      @mapa.draw
      @jogador.draw
    end
  end

  def button_down(id)
    if id == Gosu::KbUp or id == Gosu::GpUp then @jogador.tente_pular end
    if id == Gosu::KbEscape then close end
  end
end
