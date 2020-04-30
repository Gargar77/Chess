require "colorize"
require_relative "Cursor"
class Display
    attr_reader :board, :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0],@board)
    end

    def render
        # puts "   " + "-"*34
        build_rows
        letters = ('a'..'h').to_a
        puts
        puts '      ' + letters.join('  ')
    end

    def build_rows
        @board.rows.each_with_index do |row,index|
            row_num = (8 - index).to_s + '    '
            puts "#{row_num}#{print_row(row,index)}"
            #  puts ("   " + "-"*20)
        end
    end

    def print_row(row,row_index)
        row_string = []
        row.each_with_index do |piece,col_index|

            if piece == nil
                if (cursor.cursor_pos == [row_index,col_index] )
                    row_string << '   '.colorize(:background => :green) if cursor.selected == true
                    row_string << '   '.colorize(:background => :red) if cursor.selected == false    
                elsif (row_index.even? && col_index.even?) || (row_index.odd? && col_index.odd?)
                    row_string << '   '.colorize(:background => :white).underline
                else
                row_string << '   '
                end

            elsif (piece.pos == cursor.cursor_pos)
                if cursor.selected == true
                    row_string << (' ' + piece.to_s + ' ').colorize(:background => :green) 
                else
                    row_string << (' ' + piece.to_s + ' ').colorize(:background => :red) 
                end

            elsif (row_index.even? && col_index.even?) || (row_index.odd? && col_index.odd?)
                row_string << (' ' + piece.to_s + ' ').colorize(:black).colorize(:background => :white).underline
            else
                row_string << ' ' + piece.to_s + ' '
            end
        end
        return row_string.join('')
    end
end