class Piece
    
    def initialize(pos,board)
        get_color(pos)
        @pos, @board = pos, board
    end

    def get_color(pos)
        row,col = pos
        row.between?(0,1) ? @color = :black : @color = :white
    end
end
class Rook < Piece
end

class Bishop < Piece
end

class Queen < Piece
end

class Knight < Piece
end

class King < Piece
end

class Pawn < Piece
end

class NullPiece < Piece
end

