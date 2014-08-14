class Fruta
  attr_reader :x, :y, :placar, :vid

	def initialize(imagem, x, y)
		@imagem = imagem
		@x, @y = x, y
		@placar = 0
	end   
    def draw
		@imagem.draw(@x, @y, 4, 1)
	end   
end