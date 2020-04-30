require "colorize"
require_relative "Cursor"
class Display
    attr_reader :board, :cursor
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0],@board)
    end

    def render
        puts "   " + "-"*34
        build_rows
        letters = ('a'..'h').to_a.map { |char| '  ' + char + ' '}
        puts "   " + letters.join('')
    end

    def build_rows
        @board.rows.each_with_index do |row,index|
            row_num = (8 - index).to_s
            puts "#{row_num} | #{print_row(row)} |"
            puts "   " + "-"*34
        end
    end

    def print_row(row)
        row_string = []
        row.each do |piece|
            if piece == nil
                row_string << '   '
            elsif piece.pos == cursor.cursor_pos
                if cursor.selected == true
                    row_string << (' ' + piece.to_s + ' ').colorize(:background => :green) 
                else
                row_string << (' ' + piece.to_s + ' ').colorize(:background => :red) 
                end

            else
                row_string << ' ' + piece.to_s + ' '
            end
        end
        return row_string.join("|")
    end
end