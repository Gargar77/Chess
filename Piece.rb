require_relative "Modules"
require "byebug"
require "singleton"
class Piece
    attr_reader :color, :pos, :board
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
        return true if @board[pos] == board.sentinel
         current_piece_color = self.color
         end_pos_color = @board[pos].color 

         return false if current_piece_color == end_pos_color
    
       true
    end

    def moves
    end

    def to_s
        @symbol
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
        @symbol = 'k'
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
    def initialize(pos,board)
        super
        @start_pos = pos
        @symbol = 'P'
    end

    def moves
        deltas = move_diff
        current_pos = self.pos
        start_row,start_col = current_pos

        possible_moves = deltas.map {|(row,col)| [start_row + row, start_col + col]}
        curent_possible_moves = possible_moves.select { |el| valid_pos?(el) }
        curent_possible_moves += side_attack(current_pos)
        return curent_possible_moves
    end

    def move_diff   
        if self.color == :black
            if at_start_row?
                possible_moves = [[2,0],[-1,0],[1,0]]
            else
                possible_moves = [[1,0],[-1,0]]
            end
        else
            if at_start_row?
                possible_moves = [[-1,0],[1,0],[-2,0]]
            else
                possible_moves = [[-1,0],[1,0]]
            end
        end
        return possible_moves
    end

    def side_attack(pos)
        attack_diffs = [[-1,-1],[1,1]]
        row,col = pos
         row
         col
        side_moves = []
        
        attack_diffs.each do |dif|
            d_row,d_col = dif
             attack_pos = [row + d_row, col + d_col]

            if valid_pos?(attack_pos) && @board[attack_pos] != board.sentinel
                side_moves << attack_pos if @board[attack_pos].color != self.color
            end
        end
        side_moves
    end

    def start_pos
       @start_pos 
    end

    def at_start_row?
        pos == start_pos
    end
end

class NullPiece
    include Singleton
    def initialize
        @symbol = "n"
    end
end

