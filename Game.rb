require_relative "Board"
require_relative "Display"
class Game
    attr_reader :display
    def initialize
        @board = Board.new
        @display = Display.new(@board)
    end
end
g = Game.new
g.display.render