require 'gosu'
require_relative 'jogador'
require_relative 'estrela'

class CataEstrela < Gosu::Window
  @@formato = [3, 1.0, 1.0, 0xffffff00]

  def initialize 
    super(640,480,false)
    self.caption = "Sem Nome"
    @imagem_fundo = Gosu::Image.new(self, "Space.png", true)
    @jogador1 = Jogador.new(self) 
    @jogador2 = Jogador.new(self)
    @estrelas = []
    @fonte = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @tempo = 0.0
    @estado = "INICIO"
  end 

  def draw
    @imagem_fundo.draw(0,0,0)
    if    @estado == "INICIO"  then draw_inicio
    elsif @estado == "JOGANDO" then draw_jogando
    else                            draw_fim     end 
  end
  
  private
  def draw_inicio
    msg = "PRESSIONE [I] PARA COMECAR"
    x = self.width / 2 - @fonte.text_width(msg,1) / 2
    @fonte.draw(msg, x, self.height/2, *@@formato)
  end

  def draw_jogando
    @jogador1.draw()
    @jogador2.draw()
    for estrela in @estrelas do
      estrela.draw
    end
    @fonte.draw("Jogador 1: #{@jogador1.placar}", 10, 10, *@@formato)
    @fonte.draw("Jogador 2: #{@jogador2.placar}", 10, 30, *@@formato)
    @fonte.draw("Tempo: #{@tempo.to_i}s",     10, 50, *@@formato)
  end

  def draw_fim
    msg = "FIM DE JOGO: Jogador 1 #{@jogador1.placar} X #{@jogador2.placar} Jogador 2"
    x = self.width / 2 - @fonte.text_width(msg,1) / 2
    @fonte.draw(msg, x, self.height/2, *@@formato)
  end

  public
  def update
    if    @estado == "INICIO" then update_inicio      
    elsif @estado =="JOGANDO" then update_jogando
    #elsif (@estado == "FIM") then
    end 
  end

  private 
  def update_inicio
    @estado = "JOGANDO" if button_down?(Gosu::KbI) or button_down?(Gosu::GpButton9)
  end

  def update_jogando
    @jogador1.girar_direita  if button_down?(Gosu::KbRight) or button_down?(Gosu::Gp0Right) 
    @jogador1.girar_esquerda if button_down?(Gosu::KbLeft) or button_down?(Gosu::Gp0Left)
    @jogador1.acelerar       if button_down?(Gosu::KbUp) or button_down?(Gosu::Gp0Button5)
    @jogador2.girar_direita  if button_down?(Gosu::KbZ) or button_down?(Gosu::Gp1Right) 
    @jogador2.girar_esquerda if button_down?(Gosu::KbX) or button_down?(Gosu::Gp1Left)
    @jogador2.acelerar       if button_down?(Gosu::KbC) or button_down?(Gosu::Gp1Button5)

    if rand(100) < 10 and @estrelas.size < 25 then
      @estrelas.push(Estrela.new(self))
    end
    @jogador1.cata_estrelas(@estrelas)
    @jogador1.mover
    @jogador2.cata_estrelas(@estrelas)
    @jogador2.mover    
    @tempo += 1.0/60.0
    @estado = "FIM" if @tempo.to_i >= 30
  end    
end

