class Gema
  attr_reader :x, :y

  def initialize(imagem, x, y)
    @imagem = imagem
    @x, @y = x, y
  end   
  
  def draw
    # Implementa rotação lenta
    @imagem.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu::milliseconds / 133.7))
  end   
end
