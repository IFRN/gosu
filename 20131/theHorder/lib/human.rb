class Human
	attr_reader :x, :y
	def initialize(window)
		@window = window
		@x = -100
		@y = -100
		@index = 0

		@move = false

		@canMoveUp = @canMoveRight = @canMoveDown = @canMoveLeft = true

		moveIni = array_bool
		@moveUp = moveIni[0]; @moveDown = moveIni[1]; @moveLeft = moveIni[2]; @moveRight = moveIni[3]


		#CHAR 1
		@iconUp1 = Gosu::Image.new(@window, "media/boy/boyup.png", true)
		@arrayTilesmoveUp1 = Gosu::Image::load_tiles(@window,@iconUp1,32,44,true)

		@iconRight1 = Gosu::Image.new(@window, "media/boy/boyright.png", true)
		@arrayTilesmoveRight1 = Gosu::Image::load_tiles(@window,@iconRight1 ,35,44,true)

		@iconDown1 = Gosu::Image.new(@window, "media/boy/boydown.png", true)
		@arrayTilesmoveDown1 = Gosu::Image::load_tiles(@window,@iconDown1,30,48,true)

		@iconLeft1 = Gosu::Image.new(@window, "media/boy/boyleft.png", true)
		@arrayTilesmoveLeft1  = Gosu::Image::load_tiles(@window,@iconLeft1,32,45,true)

		@iconStop1 = Gosu::Image.new(@window, "media/boy/stopboy.png", true)

	end

	def update
		dont_cross
		run
	end

	def draw
		draw_load_tiles
	end

	def draw_load_tiles
		if ((Gosu::milliseconds/3)%2 == 0) and @move then
	    	@index+=1
		end
		if @moveUp and @move then
			if @index >= @arrayTilesmoveUp.size then
		    	@index = 0
			end 
			@arrayTilesmoveUp[@index].draw(@x,@y,2)
		elsif @moveDown and @move then
			if @index >= @arrayTilesmoveDown.size then
		    	@index = 0
			end 
			@arrayTilesmoveDown[@index].draw(@x,@y,2)
		elsif @moveLeft and @move then
			if @index >= @arrayTilesmoveLeft.size then
		    	@index = 0
			end 
			@arrayTilesmoveLeft[@index].draw(@x,@y,2)
		elsif @moveRight and @move then
			if @index >= @arrayTilesmoveRight.size then
		    	@index = 0
			end 
			@arrayTilesmoveRight[@index].draw(@x,@y,2)
		else
			@iconStop.draw(@x, @y,2)
		end
	end

	def born(zombiespositons)
		new_char
		borns = [
			rise_up    = [rand(@window.width-50), 0],
			rise_right = [ @window.width-50 , rand(@window.height-50)],
			rise_down  = [rand(@window.width-50), @window.height-50],
			rise_left  = [0, rand(@window.height-50)]
		]
		rise = borns[rand(3)]	
		@x = rise[0]
		@y = rise[1]
		zombiespositons.each { |zombie|
			if Gosu::distance(zombie[0], zombie[1], @x, @y) <= 80 then
				born(zombiespositons)
			end
		}
	end

	def move_up
		@y -= 0.5
		if @y < 0 then
			@y = 0
			@randMove = 1200
		end
	end

	def move_down
		@y += 0.5
		if @y > @window.height-10 then
			@y = @window.height-10
		end
	end

	def move_left
		@x -= 0.5
		if @x < 0 then
			@x = 0
			@randMove = 1200
		end
	end

	def move_right
		@x += 0.5
		if @x > @window.width-10 then
			@x = @window.width-10
		end
	end

	def run
			if @window.button_down? Gosu::Button::KbLeft
				@moveUp = false
				@moveDown = false
				@moveLeft = true
				@moveRight = false
		        @move = true	
		        if @canMoveLeft then move_left end
		    elsif @window.button_down? Gosu::Button::KbRight
				@moveUp = false
				@moveDown = false
				@moveLeft = false
				@moveRight = true	
		        @move = true
		        if @canMoveRight then move_right end
		    elsif @window.button_down? Gosu::Button::KbUp
		        @moveUp = true
				@moveDown = false
				@moveLeft = false
				@moveRight = false
				@move = true
		        if @canMoveUp then move_up end
		    elsif @window.button_down? Gosu::Button::KbDown
				@moveUp = false
				@moveDown = true
				@moveLeft = false
				@moveRight = false
				@move = true
				if @canMoveDown then move_down end
			else
				@move = false
		    end
	end

	def array_bool
		x = rand(3)
		bool4 = []
		if x == 0 then
			bool4 = [true,false,false,false]
		elsif x == 1 then
			bool4 = [false,true,false,false]
		elsif x == 2 then
			bool4 = [false,false,true,false]
		elsif x == 3 then
			bool4 = [true,false,false,true]
		end
		return bool4
	end

	def dont_cross
			if (Gosu::distance(@x+10,@y+20,175,230) < 35) or (Gosu::distance(@x+10,@y+20,775,530) < 35) then
				dontMove
			elsif (Gosu::distance(@x+10,@y+20,205,175) < 35) or (Gosu::distance(@x+10,@y+20,495,155) < 35) then
				dontMove
			elsif (Gosu::distance(@x+10,@y+20,235,200) < 18) or (Gosu::distance(@x+10,@y+20,190,490) < 18) then
				dontMove
			elsif (Gosu::distance(@x+10,@y+20,202,363) < 50) or (Gosu::distance(@x+10,@y+20,280,121) < 55) then
				dontMove
			elsif (Gosu::distance(@x+10,@y+20,805,147) < 65) or (Gosu::distance(@x+10,@y+20,840, 343) < 61) or(Gosu::distance(@x+10,@y+20,185,473) < 65) then
				dontMove
			else
				@canMoveUp = @canMoveRight = @canMoveDown = @canMoveLeft = true
			end
	end

	def dontMove
		if @moveUp then
			@canMoveUp = false
			@canMoveRight = @canMoveDown = @canMoveLeft = true
		elsif @moveRight then
			@canMoveRight = false
			@canMoveUp = @canMoveDown = @canMoveLeft = true
		elsif @moveDown then
			@canMoveDown = false
			@canMoveUp = @canMoveRight = @canMoveLeft = true
		else
			@canMoveLeft = false
			@canMoveUp = @canMoveRight = @canMoveDown = true
		end	
	end

	def save
		@x = -100
		@y = - 100
	end

	def new_char
		char = rand(1)
		if char == 0 then
			@arrayTilesmoveUp = @arrayTilesmoveUp1 
			@arrayTilesmoveRight = @arrayTilesmoveRight1 
			@arrayTilesmoveDown = @arrayTilesmoveDown1 
			@arrayTilesmoveLeft = @arrayTilesmoveLeft1 
			@iconStop = @iconStop1 
		end
	end

end