require_relative "Board"
require_relative "Display"
class Game
    attr_reader :display
    def initialize
        @board = Board.new
        @display = Display.new(@board)
    end

    # def play
    #     while true
    #         display.render
    #         display.cursor.get_input
    #         system('clear')
    #     end
    # end

end
# g = Game.new
# g.play