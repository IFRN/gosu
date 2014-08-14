class Cogu
  attr_reader :x, :y

	def initialize(imagem, x, y)
		@imagem = imagem
		@x, @y = x, y
	end   
	def draw
		@imagem.draw(@x, @y, 4, 1)
	end   
end