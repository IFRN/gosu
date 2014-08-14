require 'gosu'
require 'Fruta'
require 'Nitro'
require 'Cogu'

class Mapa
  attr_reader :width, :height, :fruts, :vid, :nit, :cogu

	def initialize(window, filename)
		@tileset = Gosu::Image.load_tiles(window, "Mapa.png", 60, 60, true) #array que separa a mesma imagem em 5 partes
		fruts_img = Gosu::Image.new(window, "Fruta.png", false) #fruta
		@fruts = []
		nit_img = Gosu::Image.new(window, "nitro.png", false) #nitro
		@nit = []
		cogu_img = Gosu::Image.new(window, "vid.png", false) #cogumelo
		@cogu = []
			lines = File.readlines(filename).map do |line| 
				line.chomp 
			end
		@height = lines.size
		@width = lines[0].size
		@tiles = Array.new(@width) do |x|
			Array.new(@height) do |y| #Caracteres para cada array da imagem
				case lines[y][x, 1]
					when '"'
						0
					when '#'
						3
					when 'o'
						2
					when 'a'
						1
					when 'b'
						4
					when 'x'
						@fruts.push(Fruta.new(fruts_img, x * 50 + 25, y * 50 + 25))
							nil
					when 'n'
						@nit.push(Nitro.new(nit_img, x * 50 + 2, y * 50))
							nil
					when 'c'
						@cogu.push(Cogu.new(cogu_img, x * 50 + 25, y * 50 + 25))
							nil
					else
							nil
				end
			end
		end
	end

	def draw
			@height.times do |y|
				@width.times do |x|
					tile = @tiles[x][y]
						if tile
							@tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
						end
				end
			end
		@fruts.each do |c| c.draw end
		@cogu.each do |c| c.draw end
		@nit.each do |c| c.draw end
	end

	def solid?(x, y)
		y < 0 || @tiles[x / 50][y / 50]
	end
end