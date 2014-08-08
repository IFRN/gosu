require 'gosu'
require 'gema'

class Mapa
  attr_reader :width, :height, :gems

  def initialize(window, filename)
    # Load 60x60 tiles, 5px overlap in all four directions.
    # carrega imagens de 60x60, com 5 pixel de sobreposição nas quatro direções
    @tileset = Gosu::Image.load_tiles(window, "Mapa.png", 60, 60, true)

    gem_img = Gosu::Image.new(window, "Gema.png", false)
    @gems = []

    lines = File.readlines(filename).map do |line| 
      line.chomp 
    end
    @height = lines.size
    @width = lines[0].size
    @tiles = Array.new(@width) do |x|
      Array.new(@height) do |y|
        case lines[y][x, 1]
        when '"'
          0
        when '#'
          1
        when 'x'
          @gems.push(Gema.new(gem_img, x * 50 + 25, y * 50 + 25))
          nil
        else
          nil
        end
      end
    end
  end

  def draw
    # Função de desenho simplificada:
    #  - Desenha TODOS os quadros. uns na tela outros fora da tela
    @height.times do |y|
      @width.times do |x|
        tile = @tiles[x][y]
        if tile
          @tileset[tile].draw(x * 50 - 5, y * 50 - 5, 0)
        end
      end
    end
    @gems.each do |c| c.draw end
  end

  # Método que retorna verdadeiro se o pixel das 
  # cordenadas (x,y) passadas é sólido
  def solid?(x, y)
    y < 0 || @tiles[x / 50][y / 50]
  end
end
