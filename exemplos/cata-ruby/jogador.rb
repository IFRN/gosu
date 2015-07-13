require 'gosu'

class Jogador
  attr_reader :x, :y

  def initialize(mapa, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0 #  Velocidade vertical
    @mapa = mapa
    # Carrega todas as imagens para animação
    @parado, @andando1, @andando2, @pulo = *Gosu::Image.load_tiles("Jogador.png", 50, 50)
    # @imagem_atual contem a imagem a ser desenhada.
    # A imagem é definida no método update e desenhada no draw
    @image_atual = @parado
  end

  def draw
    # A imagem é desenhada de acordo com a direção que o jogador olha.
    # a variável factor indica essa direção.
    if @dir == :left then
      offs_x = -25
      fator = 1.0
    else
      offs_x = 25
      fator = -1.0
    end
    @image_atual.draw(@x + offs_x, @y - 49, 0, fator, 1.0)
  end

  # verifica se o objeto pode ser colcado em (x+offs_x,y+offs_y)
  def vai_caber?(offs_x, offs_y)
    # A verificação é feita no centro/cima e centro/baixo
    not @mapa.solido?(@x + offs_x, @y + offs_y) and
      not @mapa.solido?(@x + offs_x, @y + offs_y - 45)
  end

  def update(move_x)
    # Seleciona a imagem dependendo da ação
    if (move_x == 0)
      @image_atual = @parado
    else
      @image_atual =
        if Gosu::milliseconds / 175 % 2 == 0 then @andando1 else @andando2 end
    end
    if (@vy < 0)
      @image_atual = @pulo
    end

    # Movimento horizontal
    if move_x > 0 then
      @dir = :right
      i = 1
    elsif(move_x < 0)
      @dir = :left
      i = -1
    end
    move_x.abs.times do
      if vai_caber?(i, 0) then @x += i end
    end

    # Aceleração/gravidade
    # Ao adicionar 1 em cada frame, e (idealmente) adicionar vy a y,
    # a curva do salto do jogador será a parábola que queremos
    @vy += 1
    # Movimento vertical
    i = if @vy > 0 then 1 else -1 end
    @vy.abs.times do
      if vai_caber?(0, i) then
        @y += i
      else
        @vy = 0
      end
    end
  end

  def tente_pular
    if @mapa.solido?(@x, @y + 1) then
      @vy = -20
    end
  end

  def collect_gems(gemas)
    gemas.reject! do |c|
      (c.x - @x).abs < 50 and (c.y - @y).abs < 50
    end
  end
end
