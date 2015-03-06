class Fort
	def initialize(window, x, y)
		@window = window
		@x = x
		@y = y
		@icon = Gosu::Image.new(@window, "media/fort.png", true)
		@iconUp = Gosu::Image.new(@window, "media/fortUp.png", true)
	end

	def draw
		@icon.draw(@x,@y,1)
		@iconUp.draw(@x,@y,3)
	end

end