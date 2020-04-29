require_relative "Modules"
require "byebug"
require "singleton"
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
        # debugger
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
    include Slideable
    def initialize(pos,board)
        super
        @symbol = 'R'
    end
    def diagnol_dirs
        return []
    end
    
end

class Bishop < Piece
    include Slideable
    def initialize(pos,board)
        super
        @symbol = 'B'
    end
    def horizontal_dirs
        return []
    end
    def vertical_dirs
        return []
    end
end

class Queen < Piece
    include Slideable
    def initialize(pos,board)
        super
        @symbol = 'Q'
    end
end

class Knight < Piece
    include Stepable
    def initialize(pos,board)
        super
        @symbol = 'Kn'
    end
    protected
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
    include Stepable
    def initialize(pos,board)
        super
        @symbol = 'K'
    end
    
    protected
    def move_diff
        possible_moves = [
            [-1,-1],
            [-1,0],
            [-1,1],
            [0,-1],
            [0, 1],
            [1,-1],
            [1,0],
            [1,1]
        ]
    end
end

class Pawn < Piece
end

class NullPiece
    include Singleton
    def initialize
        @color = :null
        @symbol = "n"
    end
end

