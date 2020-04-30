require_relative "Board"
require_relative "Display"
class Game
    
    def initialize
        board = Board.new
        cursor = Cursor.new([0,0],board)

        @board = board
        @display = Display.new(board,cursor)
    end
end
