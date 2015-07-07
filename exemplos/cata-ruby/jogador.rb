require 'gosu'

class Jogador
  attr_reader :x, :y

  def initialize(map, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0 #  Velocidade vertical
    @map = map
    # Carrega todas as imagens para animação
    @standing, @walk1, @walk2, @jump = *Gosu::Image.load_tiles("Jogador.png", 50, 50)
    # @cur_image contem a imagem a ser desenhada.
    # A imagem é definida no método update e desenhada no draw
    @cur_image = @standing
  end

  def draw
    # A imagem é desenhada de acordo com a direção que o jogador olha.
    # a variável factor indica essa direção.
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
    @cur_image.draw(@x + offs_x, @y - 49, 0, factor, 1.0)
  end

  # verifica se o objeto pode ser colcado em (x+offs_x,y+offs_y)
  def would_fit(offs_x, offs_y)
    # A verificação é feita no centro/cima e centro/baixo 
    not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end

  def update(move_x)
    # Seleciona a imagem dependendo da ação
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (Gosu::milliseconds / 175 % 2 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end

    # Directional walking, horizontal movement
    if move_x > 0 then
      @dir = :right
      move_x.times do 
        if would_fit(1, 0) then @x += 1 end 
      end
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times do
         if would_fit(-1, 0) then 
           @x -= 1 end 
         end
    end

    # Aceleração/gravidade
    # Ao adicionar 1 em cada frame, e (idealmente) adicionar vy a y,
    # a curva do salto do jogador será a parábola que queremos
    @vy += 1
    # Movimento vertical
    if @vy > 0 then
      @vy.times do
        if would_fit(0, 1) then 
          @y += 1 
        else 
          @vy = 0 
        end 
      end
    end
    if @vy < 0 then
      (-@vy).times do
        if would_fit(0, -1) then 
          @y -= 1 
        else 
          @vy = 0 
        end 
      end
    end
  end

  def try_to_jump
    if @map.solid?(@x, @y + 1) then
      @vy = -20
    end
  end

  def collect_gems(gems)
    gems.reject! do |c|
      (c.x - @x).abs < 50 and (c.y - @y).abs < 50
    end
  end
end
