require_relative "Modules"
require "byebug"
class Piece
    attr_reader :color, :pos
    def initialize(pos,board)
        get_color(pos)
        @pos, @board = pos, board
    end

    def get_color(pos)
        row,col = pos
        row.between?(0,1) ? @color = :black : @color = :white
    end

    def pos=(value)
        @pos = value
    end

    def valid_pos?(pos)
        return false if pos.any? { |num| !num.between?(0,7)}
        return true if @board[pos].nil?
         current_piece_color = self.color
         end_pos_color = @board[pos].color 

         return false if current_piece_color == end_pos_color
    
       true
    end

    def moves
    end
end


class Rook < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class Knight < Piece
    include Stepable

    def move_diff
        possible_moves = [
            [-2,-1],
            [-2,1],
            [-1,-2],
            [-1,2],
            [1,-2],
            [1,2],
            [2,-1],
            [2,1]
                        ]
    end
end

class King < Piece
end

class Pawn < Piece
end

class NullPiece < Piece
end

