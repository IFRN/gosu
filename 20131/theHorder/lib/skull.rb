class Skull
	def initialize(window, x, y)
		@window = window
		@x = x
		@y = y
		@icon = Gosu::Image.new(@window, "media/cranio.png", true)
	end

	def draw
		@icon.draw(@x,@y,1)
	end

end