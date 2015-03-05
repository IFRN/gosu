class Alvo
	attr_reader :shots
	def initialize(window)
		@window = window
		@icon = Gosu::Image.new(@window, "media/alvo.png", true)
		@iconshot = Gosu::Image.new(@window, "media/shoted.png", true)
		@sond = Gosu::Sample.new(@window, "media/arma_tiro.wav")
		@shots = 100
	end

	def update
		if @window.button_down? Gosu::Button::MsLeft then
			@sond.play
		end
	end

	def draw(x,y)
		if @window.button_down? Gosu::Button::MsLeft then
			@iconshot.draw(x-5,y,2)
			@shots -= 0.3
		else
			@icon.draw(x,y,5)
		end
	end

end