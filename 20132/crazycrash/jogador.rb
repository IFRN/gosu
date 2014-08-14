require 'gosu'

class Jogador
  attr_reader :x, :y, :placar, :vid

  def initialize(window, x, y)
    @x, @y = x, y
    @dir = :left
    @vy = 0
    @map = window.map
    @standing, @walk1, @walk2, @jump =
      *Gosu::Image.load_tiles(window, "Jogador2.png", 100, 100, false) #imagem em sprite sheet do jogador
    @cur_image = @standing
	@placar = 0 #placar no inicio
	@vid = 1 #vida
  end

  def draw
    if @dir == :left then
      offs_x = -25
      factor = 1.0
    else
      offs_x = 25
      factor = -1.0
    end
		@cur_image.draw(@x + offs_x, @y - 105, 0, factor, 1.0)
  end

  def would_fit(offs_x, offs_y)
	not @map.solid?(@x + offs_x, @y + offs_y) and
      not @map.solid?(@x + offs_x, @y + offs_y - 45)
  end

  def update(move_x)
  if (@placar == 100) then #código para receber uma vida quando pegar 10 frutas
		@placar = 0
		@vid += 1
		true
		else
		false
	end
    if (move_x == 0)
      @cur_image = @standing
    else
      @cur_image = (Gosu::milliseconds / 175 % 3 == 0) ? @walk1 : @walk2
    end
    if (@vy < 0)
      @cur_image = @jump
    end
    if move_x > 0 then
      @dir = :right
      move_x.times do 
			if would_fit(1, 0) then 
			@x += 1 
			end 
		end
    end
    if move_x < 0 then
      @dir = :left
      (-move_x).times do
         if would_fit(-1, 0) then 
           @x -= 1 
		 end 
      end
    end
    @vy += 1
    if @vy > 0 then
      @vy.times do
        if would_fit(0, 1) then 
          @y += 1 
        else @vy = 0 
        end 
      end
    end
    if @vy < 0 then
      (-@vy).times do
        if would_fit(0, -1) then 
          @y -= 1 
        else @vy = 0 
        end 
      end
    end
  end
 def try_to_jump
    if @map.solid?(@x, @y + 1) then
      @vy = -20
    end
  end
	def collect_fruts(fruts) #coletar frutas e receber 10 pontos
    fruts.reject! do |c|
			if (c.x - @x).abs < 50 and (c.y - @y).abs < 50 then 
				@placar+=10
				true
				else
				false
			end
		end
	end
	def collect_nit(nit) #coletar nitro e perder 1 vida
		nit.reject! do |c|
			if (c.x - @x).abs < 50 and (c.y - @y).abs < 50 then
				@vid -= 1 
				true
				else
				false
			end
		end
	 end
	def collect_cogu(cogu) #coletar cogumelo e substituir o placar por 1000 fazendo com que o estado mude
		cogu.reject! do |c|
			if (c.x - @x).abs < 50 and (c.y - @y).abs < 50 then
				@placar = 1000
				true
				else
				false
			end
		end
	end
end