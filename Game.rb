require_relative "Board"
require_relative "Display"
class Game
    attr_reader :display, :board
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
 g = Game.new
#  f2, f3
# e7, e5
# g2, g4
# d8, h4
system("clear")
g.display.render
 g.board.move_piece([6,5],[5,5])
 system("clear")
 g.display.render
 g.board.move_piece([1,4],[3,4])
 system("clear")
 g.display.render
 g.board.move_piece([6,6],[4,6])
 system("clear")
 g.display.render
 g.board.move_piece([0,3],[4,7])
 system("clear")
 g.display.render
#  p g.in_check?()
#  p g.checkmate?()
 
 