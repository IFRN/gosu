require 'gosu'

class Jogador 
  attr_reader :placar
  def initialize (janela)
    @janela = janela
    @imagem = Gosu::Image.new(@janela,"Nave.bmp", true)
    @beep = Gosu::Sample.new(@janela, "Beep.wav")
    @placar = 0 
    @x = @janela.width / 2
    @y = @janela.height / 2
    @vel_x = 0
    @vel_y = 0
    @angulo = 0.0
  end 

  def draw
    @imagem.draw_rot(@x, @y, 2, @angulo)
  end

  def girar_direita
    @angulo += 5.0
  end 

  def girar_esquerda
    @angulo -= 5.0
  end
 
  def acelerar
    @vel_x += Gosu::offset_x(@angulo, 0.5)
    @vel_y += Gosu::offset_y(@angulo, 0.5)
  end 

  def mover
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def cata_estrelas(estrelas)
    n_estrelas = estrelas.size
    estrelas.reject! do |estrela|
      Gosu::distance(@x, @y, estrela.x, estrela.y) < 35
    end
    n = n_estrelas - estrelas.size
    n.times do @beep.play end
    @placar += n * 10
  end
end
