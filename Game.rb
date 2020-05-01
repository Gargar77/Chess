require_relative "Board"
require_relative "Display"
require_relative "Player"
class Game
    attr_reader :display, :board
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        cursor = @display.cursor
        @players = [Player.new(cursor,'Player1',:white),Player.new(cursor,'player2',:black)]
    end

require 'byebug'
    def play
        player = @players[0]
        while true  
            display.render
            moves = player.make_move
            start_pos,end_pos = moves
            if !start_pos.nil? && !end_pos.nil?
                start_pos,end_pos = moves
                board.move_piece(start_pos,end_pos)
            end
            system('clear')
        end
    end

end
 g = Game.new

#  g.board.move_piece([6,5],[5,5])
#   g.board.move_piece([1,4],[3,4])
#   g.board.move_piece([6,6],[4,6])
#  g.board.move_piece([0,3],[4,7])
#   g.board.move_piece([4,7],[5,7])
  g.play
#  system("clear")
#  g.display.render

#  p g.board.in_check?(:black)
#  p g.board.checkmate?(:black)
#  p g.board[[4,7]].valid_moves
#  g.display.render
 