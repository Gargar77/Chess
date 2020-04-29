require_relative "Piece"
require "byebug"
class Board
    attr_reader :rows
    def initialize
      make_grid
    end

    def populate
       [:black,:white].each do |color|
         add_back_row(color)
         add_pawns(color)
       end
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
      raise "There is no piece at #{start_pos.to_s}!" if self[start_pos] == nil
      [start_pos,end_pos].each {|el| raise "#{el.to_s} is an invalid position!" if !valid_pos?(el)} 
      raise "cannot move to #{end_pos.to_s}!" if self[end_pos] != nil
      
        piece = self[start_pos]
        piece.pos = end_pos
        self[start_pos] = nil
        self[end_pos] = piece
    end


    private

    def make_grid
      @rows = Array.new(8) {Array.new(8)}
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


b = Board.new
b.populate

pos = [1,0]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [1,3]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [1,6]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [6,0]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [6,1]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [6,3]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts
pos = [6,5]
p 'pawn'
p b[pos].move_diff
p b[pos].moves
puts

# pos = [7,0]
# p 'Rook'
# p b[pos].moves
# puts
# pos = [7,1]
# p 'knight'
# p b[pos].moves
# puts
# pos = [7,2]
# p 'bishop'
# p b[pos].moves
# puts
# pos = [7,3]
# p 'King'
# p b[pos].moves
# puts
# pos = [7,4]
# p 'Queen'
# p b[pos].moves
# puts
# pos = [7,5]
# p 'bishop'
# p b[pos].moves
# puts
# pos = [7,6]
# p 'Knight'
# p b[pos].moves
# puts
# pos = [7,7]
# p 'Rook'
# p b[pos].moves
# puts