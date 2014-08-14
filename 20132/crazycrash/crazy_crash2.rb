require 'gosu'
require 'jogador'
require 'jogador2'
require 'mapa2'

class Crazycrash2 < Gosu::Window #Código para segunda fase
  attr_reader :map, :placar
  
	def initialize
		super(640, 480, false)
		self.caption = "Crazy Crash"
		@y = 0
		@beep = Gosu::Song.new(self, "crash.ogg") #música segunda fase
		@beep2 = Gosu::Song.new(self, "end.ogg") #música conclusão do jogo
		@beep3 = Gosu::Song.new(self, "go.ogg") #música fim de jogo
		@sky = Gosu::Image.new(self, "trainc2.png", true) #trem da segunda fase
		@imagem = Gosu::Image.new(self, "inic2.png", true) #imagem de início da segunda fase
		@imagem2 = Gosu::Image.new(self, "go.png", true)
		@imagem3 = Gosu::Image.new(self, "bk3.png", true) #background seguda fase
		@imagem4 = Gosu::Image.new(self, "go2.png", true) #background conclusão de jogo
		@map = Mapa2.new(self, "Mapa2.txt")
		@jogador = Jogador2.new(self, 400, 100)
		@camera_x = @camera_y = 0
		@tempo = 46.0
		@estado = "INICIO"	
		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	end
	def draw
		if (@estado == "INICIO") then
			@imagem.draw(0,0,0)
		elsif (@estado == "JOGANDO") then 
			@font.draw("      #{@jogador.placar}", 10, 10, 10, 2.0, 2.0, 0xffff0d0d)
			@font.draw("      #{@tempo.to_i}", 200, 10, 10, 2.0, 2.0, 0xffff0d0d)
			@font.draw("      #{@jogador.vid}", 400, 10, 10, 2.0, 2.0, 0xffff0d0d)
			@sky.draw(@y-8433,0,0)
			@imagem3.draw(0,0,0)
				translate(-@camera_x, -@camera_y) do
					@beep.play
					@map.draw
					@jogador.draw	  
				end
		elsif (@estado == "FIM") then
			@imagem2.draw(0,0,0)
		elsif (@estado == "END") then #estado adiconal para conclusão do jogo
			@imagem4.draw(0,0,0)
		end	
	end
	def button_down(id)
		if id == Gosu::KbUp then 
			@jogador.try_to_jump 
		end
		if id == Gosu::KbEscape then 
			close 
		end
	end
	def update
		if (@estado == "INICIO")
			if (button_down?(Gosu::Button::KbI)) then
				@estado = "JOGANDO"
			end
		elsif (@estado == "JOGANDO")
			@y = (@y-3 )%8433
			@beep.play
			move_x = 5
			move_x -= 10 if button_down? Gosu::KbLeft
			move_x += 5 if button_down? Gosu::KbRight
			@jogador.update(move_x)
			@jogador.collect_fruts(@map.fruts)
			@jogador.collect_nit(@map.nit)
			@jogador.collect_cogu(@map.cogu)
			@camera_x = [[@jogador.x - 320, 0].max, @map.width * 50 - 640].min
			@camera_y = [[@jogador.y - 240, 0].max, @map.height * 50 - 480].min
			@tempo-=1.0/60.0
			if (@tempo.to_i == 0) then 
				@estado = "FIM"
			end
			if (@jogador.vid == 0) then 
				@estado = "FIM"
			end
			if (@jogador.placar == 1000) then
				@beep.stop
				@estado = "END"
			end
		elsif (@estado == "FIM")
			@beep.stop
			@beep3.play
			if (button_down?(Gosu::Button::KbI)) then
				@beep3.stop
				close
				jogo = Crazycrash.new
				jogo.show
			end
		elsif (@estado == "END") then
			@beep2.play
			if (button_down?(Gosu::Button::KbI)) then #após concluído, reniciar o jogo
				@beep2.stop
				close
				jogo = Crazycrash.new
				jogo.show
			end
		end
	end
end