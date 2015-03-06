class Window < Gosu::Window
        
    def initialize
        super(1024,612,false)
        self.caption	=	"Teste Movimentacao Zombie 01"
        @Bg = Gosu::Image.new(self, "media/bg.png", true)
        @InitScreen = Gosu::Image.new(self, "media/fundo.png", true)
        @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
        @alvo = Alvo.new(self)
        @fort = Fort.new(self, 412, 220)
        @humansave = false
        @humandied = false
        createZombie
        @human = Human.new(self)
        @pontos = 0
        @run = false

        @soundtheme = Gosu::Sample.new(self, "media/backgroundtheme.wav")
        @soundexe = true

        #CENARIO
        @treeBig = Gosu::Image.new(self, "media/treeBig.png", true)
        @treeMiddle = Gosu::Image.new(self, "media/treeMiddle.png", true)
        @rock = Gosu::Image.new(self, "media/rock.png", true)
        @tronco = Gosu::Image.new(self, "media/troncoLeft.png", true)
        @carTrash = Gosu::Image.new(self, "media/cartrash.png", true)
        @car = Gosu::Image.new(self, "media/car.png", true)
        @carExp = Gosu::Image.new(self, "media/carExplosed.png", true)
        @trasedCar = Gosu::Image.new(self, "media/trashedcar.png", true)
        @humandie = Gosu::Image.new(self, "media/humandie.png", true)

        zombiespositons = []
        @Zombies.each { |zombie|
           zombiespositons << [zombie.x, zombie.y] 
        }
        @human.born(zombiespositons)
    end

    def createZombie
        @Zombies = 40.times.map { Zombie.new(self)}
    end

    def update
        if @soundexe then
            @soundtheme.play
            @soundexe =false
        end
        if button_down? Gosu::Button::KbSpace and !@run then
            @run = true
        else
            if @run then
                run
            end
        end
    end

    def draw
        #Titulos
        /@font.draw("X: #{mouse_x.to_i} - Y: #{mouse_y.to_i}", 10, 10, 5.0, 1.0, 1.0, 0xffffffff)/
        @font.draw("Score saves: #{@pontos}", 10, 10, 5.0, 1.0, 1.0, 0xffffffff)
        @font.draw("Shots: #{@alvo.shots.to_i}", 10, 25, 5.0, 1.0, 1.0, 0xffffffff)
        
        
        #Humanos
        if !@run then
            @InitScreen.draw(0,0,8)
        end
        if @humandied then
            @humandie.draw(@human.x, @human.y, 2)
        elsif !@humansave then    
            @human.draw
        end

        #Zombies
        @Zombies.each {|zombie| zombie.draw}

        #Cenário
        @Bg.draw(0,-0.5,0)
        @alvo.draw(mouse_x, mouse_y)
        @fort.draw
        @treeBig.draw(150,150,3)
        @treeBig.draw(750,450,3)
        @treeMiddle.draw(180,120,3)
        @treeMiddle.draw(470,100,3)
        @rock.draw(225,190,3)
        @rock.draw(180,450,3)
        @tronco.draw(170,465,3)
        @carTrash.draw(180, 340, 3)
        @car.draw(240,100,3)
        @carExp.draw(760, 120, 3)
        @trasedCar.draw(800, 330, 3)
        #draw_line(480,280, Gosu::Color::RED, (mouse_x+5),(mouse_y+8), Gosu::Color::RED, 999)
    end    

    def run
        @alvo.update
        human_save?
        human_dead
        if !@humansave and !@humandied then
            @Zombies.each {|zombie| zombie.update(@human.x, @human.y)}
            @human.update
        else
            @Zombies.each {|zombie| zombie.update(-100,-100)}
        end
        if(Gosu::milliseconds/2000)%2 == 0 and @humansave then
                @humansave = false
                zombiespositons = []
                @Zombies.each { |zombie|
                   zombiespositons << [zombie.x, zombie.y] 
                }
                @human.born(zombiespositons)
        end
    end

    def human_save?
            if Gosu::distance(@human.x, @human.y, 496,289) <= 60 then
                @humansave = true
                @pontos+=10
                @human.save
            end 
    end

    #Morte Humana
    def human_dead
            if !@humansave then
                @Zombies.each { |zombie|
                    #Zombie comendo
                   if Gosu::distance(@human.x, @human.y, zombie.x, zombie.y) < 2 then
                        @humandied = true
                        #Criar Play em grito do human
                   end
                }
             end
            if(Gosu::milliseconds/2000)%5 == 0 and @humandied then
                    zombiespositons = []
                    @Zombies.each { |zombie|
                        zombiespositons << [zombie.x, zombie.y] 
                    }
                    @humandied = false
                    @human.born(zombiespositons)                    
            end
    end
end