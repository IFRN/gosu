require 'gosu'
require 'jogador'
require 'mapa'

class Pre < Gosu::Window #Texto do Início
  attr_reader :map, :placar
  
	def initialize
		super(640, 480, false)
		self.caption = "Crazy Crash"
		@y = 0
		@x = 0
		@pre = Gosu::Image.new(self, "pre.png", true)
		@beep2 = Gosu::Song.new(self, "sw.ogg")
		@estado = "PRE"	
	end
	def draw
		if (@estado == "PRE") then
			@pre.draw(0,@x-800,0)
			@beep2.play
		end
	end
	def update
		if (@estado == "PRE")
			@x = (@x-1 )%900
			@beep2.play
			if (button_down?(Gosu::Button::KbR)) then
				close
				jogo = Crazycrash.new
				jogo.show
			end
		end
	end
end