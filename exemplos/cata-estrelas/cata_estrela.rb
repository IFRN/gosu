#encoding: UTF-8
require 'gosu'
require_relative 'jogador'
require_relative 'estrela'

class CataEstrela < Gosu::Window
  @@formato = [1, 1, Gosu::Color::YELLOW]

  def initialize
    super(640, 480)
    self.caption = "Cata Estrelas"
    @imagem_fundo = Gosu::Image.new("Space.png")
    @jogador = Jogador.new(self)
    @estrelas = []
    @fonte = Gosu::Font.new(20)
    @tempo = 0.0
    @estado = "INICIO"
  end

  def draw
    @imagem_fundo.draw(0, 0, 0)
    if    @estado == "INICIO"  then draw_inicio
    elsif @estado == "JOGANDO" then draw_jogando
    else                            draw_fim     end
  end

  def update
    if    @estado == "INICIO" then update_inicio
    elsif @estado =="JOGANDO" then update_jogando
    #elsif (@estado == "FIM") then
    end
  end

  # Estado: inicio do jogo
  def update_inicio
    @estado = "JOGANDO" if button_down?(Gosu::KbI)
  end

  def draw_inicio
    msg = "PRESSIONE [I] PARA COMEÇAR"
    meio = self.width / 2 - @fonte.text_width(msg, 1) / 2
    @fonte.draw(msg, meio, self.height/2, 3, *@@formato)
  end

  # Estado: jogando
  def update_jogando
    # eventos
    @jogador.girar_direita  if button_down?(Gosu::KbRight) or button_down?(Gosu::GpRight)
    @jogador.girar_esquerda if button_down?(Gosu::KbLeft)  or button_down?(Gosu::GpLeft)
    @jogador.acelerar       if button_down?(Gosu::KbUp)    or button_down?(Gosu::GpUp)
    # inserir novas estrelas estrelas se necessario
    @estrelas.push(Estrela.new) if rand(100) < 4 and @estrelas.size < 25

    @jogador.cata_estrelas(@estrelas)  # catar estrelas
    @jogador.mover                     # atualizar a posicao do jogador
    @tempo += 1.0/60.0                 # incrementar o tempo
    @estado = "FIM"        if @tempo.to_i >= 30  # terminar o jogo depois de 30 segundos
  end

  def draw_jogando
    @jogador.draw()               # desenhar o jogador
    for estrela in @estrelas do   # desenhar as estrelas
      estrela.draw
    end
    @fonte.draw("Placar: #{@jogador.placar}", 10, 10, 3, *@@formato)
    @fonte.draw("Tempo: #{@tempo.to_i}s",     10, 30, 3, *@@formato)
  end

  # Estado: fim do jogo
  def draw_fim
    msg = "FIM DE JOGO, VOCE FEZ #{@jogador.placar} PONTOS"
    meio = self.width / 2 - @fonte.text_width(msg, 1) / 2
    @fonte.draw(msg, meio, self.height/2, 3, *@@formato)
  end
end
