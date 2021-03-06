require_relative "Piece"
require "byebug"
class Board
    attr_reader :rows, :sentinel
    def initialize
      make_grid
      populate
    end

    def populate
       [:black,:white].each do |color|
         add_back_row(color)
         add_pawns(color)
       end
       add_nill_piece
    end

    def []=(pos,value)
      row,col = pos
      @rows[row][col] = value
    end

    def [](pos)
      row,col = pos
      @rows[row][col]
    end

    def valid_pos?(pos)
      pos.all? { |n| n.between?(0,7)}
    end

    def move_piece(start_pos,end_pos)
      raise "There is no piece at #{start_pos.to_s}!" if self[start_pos] == sentinel
      [start_pos,end_pos].each {|el| raise "#{el.to_s} is an invalid position!" if !valid_pos?(el)} 
      raise "cannot move to #{end_pos.to_s}!" if self[end_pos].color == self[start_pos].color
      valid_moves = self[start_pos].valid_moves
      raise "Invalid move!" if !valid_moves.include?(end_pos)
        piece = self[start_pos]
        piece.pos = end_pos
        self[start_pos] = sentinel
        self[end_pos] = piece
        return true
    end

    def move_piece!(start_pos,end_pos)
      piece = self[start_pos]
        piece.pos = end_pos
        self[start_pos] = sentinel
        self[end_pos] = piece
    end

    def in_check?(color)
      king_pos = find_king(color)
      opposing_piece_moves = opposing_moves(color)
      opposing_piece_moves.any? { |move| move == king_pos}
    end

    def checkmate?(color)
      king_pos = find_king(color)
      king_moves = self[king_pos].moves
      return true if king_moves == [] && !king_start_pos?(color)
      opposing_moves = opposing_moves(color)
      return true if in_check?(color) && king_moves.all? { |move| opposing_moves.include?(move)}
      false
    end

    def king_start_pos?(color)
      pos = find_king(color)
      pos == self[pos].starting_pos
    end
    
    def dup
      original_board = self
      dup = Marshal.load(Marshal.dump(original_board))
      return dup
    end


    private

    def find_king(color)
      rows.each_with_index do |row,idx1|
        row.each_with_index do |piece,idx2|
          if piece.the_king == true  && piece.color == color
            return [idx1,idx2]
          end
        end
      end
    end
    def make_grid
      @rows = Array.new(8) {Array.new(8)}
    end

    def opposing_moves(color)
      opp_moves = []
      rows.each_with_index do |row,idx1|
        row.each_with_index do |col,idx2|
          if col.color != color && col != sentinel
            opp_moves += col.moves
          end
        end
      end
      return opp_moves
    end

    def add_piece(pos,piece)
      self[pos] = piece.new(pos,self)
    end

    def add_pawns(color)
      if color == :black
        col = 0
        8.times do 
          add_piece([1,col],Pawn)
          col += 1
        end
      else
        col = 0
        8.times do 
          add_piece([6,col],Pawn)
          col += 1
        end
      end
      true
    end

    def add_nill_piece
      null_piece = NullPiece.instance
      rows.each_with_index do |row,row_idx|
        row.each_with_index do |col,col_idx|
          if col == nil
            self[[row_idx,col_idx]] = null_piece
          end
        end
      end
      @sentinel = null_piece


    end

    def add_back_row(color)
      row = [Rook,Knight,Bishop,King,Queen,Bishop,Knight,Rook]
      if color == :black
        col = 0
        row.each do |piece|
          add_piece([0,col],piece)
          col += 1
        end
      else
        col = 0
        row.each do |piece|
          add_piece([7,col],piece)
          col += 1
        end
      end
      true
    end    
end

