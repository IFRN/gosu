require 'gosu'

class Estrela
  attr_reader :x, :y
  
  def initialize(janela)
    @janela = janela
    @color = Gosu::Color.new(0xff000000)
    @color.red   = rand(256 - 40) + 40
    @color.green = rand(256 - 40) + 40
    @color.blue  = rand(256 - 40) + 40
    @x = rand * 640 
    @y = rand * 480 
    @imagens = Gosu::Image::load_tiles(@janela, "Estrela.png", 25, 25, false)
  end 

  def draw
    imagem= @imagens[Gosu::milliseconds / 100 % @imagens.size]
    imagem.draw(@x - imagem.width / 2.0, @y - imagem.height / 2.0,
        1, 1, 1, @color, :add)
  end 
end
