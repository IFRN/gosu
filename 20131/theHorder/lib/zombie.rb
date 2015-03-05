class Zombie
	attr_reader :x, :y
	def initialize(window)
		@window = window

		#Direção Inicial do Zombie
		moveIni = array_bool
		@moveUp = moveIni[0]; @moveDown = moveIni[1]; @moveLeft = moveIni[2]; @moveRight = moveIni[3]
		@moveQ1 = @moveQ2 = @moveQ3 = @moveQ4 = false
		@randMove = 0
		@following = false
		@x = 0
		@y = 0
		born
		@Skulls = []

		#Define cada imagem para a direção em que o Zombie anda
		@iconUp = Gosu::Image.new(@window, "media/zombiemoveup.png", true)
		@arrayTilesmoveUp = Gosu::Image::load_tiles(@window,@iconUp,34,52,true)

		@iconRight = Gosu::Image.new(@window, "media/zombiemoveright.png", true)
		@arrayTilesmoveRight = Gosu::Image::load_tiles(@window,@iconRight,37,56,true)

		@iconDown = Gosu::Image.new(@window, "media/zombiemovedown.png", true)
		@arrayTilesmoveDown = Gosu::Image::load_tiles(@window,@iconDown,37,52,true)

		@iconLeft = Gosu::Image.new(@window, "media/zombiemoveleft.png", true)
		@arrayTilesmoveLeft  = Gosu::Image::load_tiles(@window,@iconLeft,34,56,true)

	end

	def born
		borns = [
			rise_up    = [rand(@window.width-50), 0],
			rise_right = [ @window.width-50 , rand(@window.height-50)],
			rise_down  = [rand(@window.width-50), @window.height-50],
			rise_left  = [0, rand(@window.height-50)]
		]
		rise = borns[rand(3)]	
		@x = rise[0]
		@y = rise[1]

	end

	def update(humanX, humanY)
		dont_cross
		Live?
		if Gosu::distance(humanX,humanY,@x,@y) <= 80 then
			@following = true
			follow(humanX, humanY)
		else
			@following = false
			move
		end
	end

	$ind = 0
	$index = 0
	def draw
		#Fazer draw com load tiles diferentes a cada tipo de movimento

		$ind+=1
	    if $ind == 300 then
	        $index+=1
	        $ind = 0
	    end

	    if @moveUp then
	    	if $index >= @arrayTilesmoveUp.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveUp[$index].draw(@x,@y,2)
		elsif @moveDown then
	    	if $index >= @arrayTilesmoveDown.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveDown[$index].draw(@x,@y,2)
		elsif @moveLeft then
	    	if $index >= @arrayTilesmoveLeft.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveLeft[$index].draw(@x,@y,2)
		elsif @moveRight then
	    	if $index >= @arrayTilesmoveRight.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveRight[$index].draw(@x,@y,2)
		elsif @moveQ1 then
	    	if $index >= @arrayTilesmoveDown.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveDown[$index].draw(@x,@y,2)
		elsif @moveQ2 then
	    	if $index >= @arrayTilesmoveUp.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveUp[$index].draw(@x,@y,2)
		elsif @moveQ3 then
	    	if $index >= @arrayTilesmoveUp.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveUp[$index].draw(@x,@y,2)
		elsif @moveQ4 then
	    	if $index >= @arrayTilesmoveDown.size then
	        	$index = 0
	    	end 
			@arrayTilesmoveDown[$index].draw(@x,@y,2)
		end

		if @Skulls.size then
		 	@Skulls.each {|skull| skull.draw}
		end
	end

	def move
		@moveQ1 = @moveQ2 = @moveQ3 = @moveQ4 = false	
		if @randMove  == 1200 then
			x = rand(20)
			if x < 6 then
				@moveUp = true
				@moveDown = false
				@moveLeft = false
				@moveRight = false	
			elsif x > 5 and x < 11 then
				@moveUp = false
				@moveDown = true
				@moveLeft = false
				@moveRight = false
			elsif x > 10 and x < 16 then
				@moveUp = false
				@moveDown = false
				@moveLeft = true
				@moveRight = false
			elsif x > 15 and x < 21 then
				@moveUp = false
				@moveDown = false
				@moveLeft = false
				@moveRight = true				
			end	
			@randMove  = 0	
		end
		@randMove +=1
		if @moveUp then
			move_up
		elsif @moveDown then
			move_down
		elsif @moveLeft then
			move_left
		elsif @moveRight then
			move_right
		end	
	end

	def follow(humX, humY)
		@moveUp = @moveDown = @moveLeft = @moveRight = false
		if humY > @y and humX < @x then
			@moveQ1 = true
			@moveQ2 = false
			@moveQ3 = false
			@moveQ4 = false
			move_Q1
		elsif humY < @y and humX < @x then
			@moveQ1 = false
			@moveQ2 = true
			@moveQ3 = false
			@moveQ4 = false
			move_Q2
		elsif humY < @y and humX > @x then
			@moveQ1 = false
			@moveQ2 = false
			@moveQ3 = true
			@moveQ4 = false
			move_Q3
		elsif humY > @y and humX > @x then
			@moveQ1 = false
			@moveQ2 = false
			@moveQ3 = false
			@moveQ4 = true
			move_Q4
		elsif humY > @y and humX == @x then
			@moveUp = false
			@moveDown = true
			@moveLeft = false
			@moveRight = false
			move_down
		elsif humY == @y and humX < @x then
			@moveUp = false
			@moveDown = false
			@moveLeft = true
			@moveRight = false
			move_left
		elsif humY < @y and humX == @x then
			@moveUp = true
			@moveDown = false
			@moveLeft = false
			@moveRight = false
			move_up
		elsif humY == @y and humX > @x then
			@moveUp = false
			@moveDown = false
			@moveLeft = false
			@moveRight = true
			move_right
		end
	end

	def move_up
		#adicionar depois o referencial ao objetos do cenário
		if @following then
			@y -= 0.25
		else
			@y -= 0.125
		end
		if @y < 0 then
			@y = 0
			@randMove = 1200
		end
	end

	def move_down
		#adicionar depois o referencial ao objetos do cenário
		if @following then
			@y += 0.25
		else
			@y += 0.125
		end
		if @y > @window.height-10 then
			@y = @window.height-10
		end
	end

	def move_left
		#adicionar depois o referencial ao objetos do cenário
		if @following then
			@x -= 0.25
		else
			@x -= 0.125
		end
		if @x < 0 then
			@x = 0
			@randMove = 1200
		end
	end

	def move_right
		#adicionar depois o referencial ao objetos do cenário
		if @following then
			@x += 0.25	
		else
			@x += 0.125
		end
		if @x > @window.width-10 then
			@x = @window.width-10
		end
	end

	def move_Q1
		@x -= 0.25
		if @x < 0 then
			@x = 0
		end
		@y += 0.25
		if @y > @window.height-10 then
			@y = @window.height-10
		end
	end

	def move_Q2
		@y -= 0.25
		if @y < 0 then
			@y = 0
		end
		@x -= 0.25
		if @x < 0 then
			@x = 0
		end
	end

	def move_Q3
		@x += 0.25
		if @x > @window.width-10 then
			@x = @window.width-10
		end
		@y -= 0.125
		if @y < 0 then
			@y = 0
		end
	end

	def move_Q4
		@x += 0.25
		if @x > @window.width-10 then
			@x = @window.width-10
		end
		@y += 0.25
		if @y > @window.height-10 then
			@y = @window.height-10
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

	def Live?
		if Gosu::distance(@x+15, @y, @window.mouse_x, @window.mouse_y) < 15  and @window.button_down? Gosu::Button::MsLeft then
			add_skull
			born
			@randMove = 1200
		end
	end

	def add_skull
		@Skulls << Skull.new(@window,@x+5,@y+30)
	end

	def reverse_direction
		if @moveUp then
			@moveUp = false
			@moveDown = true
		elsif @moveDown then
			@moveUp = true
			@moveDown = false
		elsif @moveLeft then
			@moveLeft = false
			@moveRight = true
		else 
			@moveLeft = true
			@moveRight = false
		end
	end

	def dont_cross
			if (Gosu::distance(@x+10,@y+20,175,230) <= 25) or (Gosu::distance(@x+10,@y+20,775,530) <= 25) then
			reverse_direction
		elsif (Gosu::distance(@x+10,@y+20,205,175) <= 25) or (Gosu::distance(@x+10,@y+20,495,155) <= 25) then
			reverse_direction
		elsif (Gosu::distance(@x+10,@y+20,235,200) <= 18) or (Gosu::distance(@x+10,@y+20,190,490) <= 18) then
			reverse_direction
		elsif (Gosu::distance(@x+10,@y+20,202,363) <= 40) or (Gosu::distance(@x+10,@y+20,280,121) <= 45) then
			reverse_direction
		elsif (Gosu::distance(@x+10,@y+20,805,147) <= 55) or (Gosu::distance(@x+10,@y+20,840, 343) <= 51) or(Gosu::distance(@x+10,@y+20,185,473) <= 25) then
			reverse_direction
		elsif (Gosu::distance(@x+10,@y+20,500,295) <= 120) then
			reverse_direction
		end	
	end

end