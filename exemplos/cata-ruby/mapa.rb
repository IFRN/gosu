require 'gosu'
require 'gema'

class Mapa
  attr_reader :width, :height, :gems

  def initialize(filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    # carrega imagens de 60x60, com 5 pixel de sobreposição nas quatro direções
    @tileset = Gosu::Image.load_tiles("Mapa.png", 60, 60)

    gem_img = Gosu::Image.new("Gema.png")
    @gems = []

    lines = File.readlines(filename).map do |line|
      line.chomp
    end
    @height = lines.size
    @width = lines[0].size
    @tiles = []
    for y in 0..(@height-1) do
      @tiles[y]=[]
      for x in 0..(@width-1) do
        tile = lines[y][x]
        @tiles[y][x] = if    tile == '"' then 0
                       elsif tile == '#' then 1
                       elsif tile == 'x' then
                         @gems << Gema.new(gem_img, x * 50 + 25, y * 50 + 25)
                         nil
                       else nil end
      end
    end
  end

  def draw
    # Função de desenho simplificada:
    #  - Desenha TODOS os quadros. uns na tela outros fora da tela
    for y in 0..(@height-1) do
      for x in 0..(@width-1) do
        tile = @tiles[y][x]
        @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0) if tile #   tile != nil
      end
    end
    for gema in @gems do gema.draw end
  end

  # Método que retorna verdadeiro se o pixel das
  # cordenadas (x,y) passadas é sólido
  def solido?(x, y)
    y < 0 || @tiles[y / 50][x / 50]
  end
end
