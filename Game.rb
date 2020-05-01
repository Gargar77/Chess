require_relative "Board"
require_relative "Display"
require_relative "Player"
class Game
    attr_reader :display, :board
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        cursor = @display.cursor
        @players = [Player.new(cursor,'Player 1',:white),Player.new(cursor,'player 2',:black)]
        @current_player = @players[0]
    end

require 'byebug'
    def play
        # debugger
        until game_over?
          player = @current_player
          moved = false
         while moved == false
            begin  
              display.render
              puts "Current Player: #{@current_player.player_name}"
              moves = player.make_move
              start_pos,end_pos = moves
             if !start_pos.nil? && !end_pos.nil?
                start_pos,end_pos = moves
                moved = board.move_piece(start_pos,end_pos)
             end
            rescue RuntimeError => e
                puts
                puts "Invalid Move!"
                sleep(1)
                system('clear')
            retry
            end
         system('clear')
          end
          switch_player
        end
        winner_message
    end

    def switch_player
        @current_player  == @players[0] ? @current_player = @players[-1] : @current_player = @players[0]
    end

    def game_over?
        board.checkmate?(:black) || board.checkmate?(:white)
    end

    def winner_message
        if @board.checkmate?(:black)
            puts "Congratulations #{@players[-1].player_name} you WON!"
        else
            puts puts "Congratulations #{@players[0].player_name} you WON!"
        end
    end

end
 g = Game.new

#  g.board.move_piece([6,7],[5,7])
#  debugger
# g.board[[7,7]].valid_moves
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
 