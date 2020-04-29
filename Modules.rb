
module Stepable
    # class must have #move_diff!
    def moves
        deltas = move_diff
        start_row,start_col = self.pos
        possible_moves = deltas.map { |(row,col)| [start_row + row,start_col + col]}
       current_possible_moves = possible_moves.select { |el| valid_pos?(el)}
        return current_possible_moves
    end
end

module Slideable
    #class must have @pos attribute and #valid_pos?
    def moves
       current_possible_moves = horizontal_dirs + vertical_dirs + diagnol_dirs
       return current_possible_moves
    end

    def vertical_dirs
        diffs = [[1,0],[-1,0]]
        start_pos = self.pos
        vertical_positions = []

        diffs.each do |dif|
            row_diff,col_diff = dif
            current_pos = start_pos

            while valid_pos?(current_pos)
                row,col = current_pos
                current_pos = [row + row_diff, col + col_diff]
                vertical_positions << current_pos
            end
            vertical_positions.pop
        end
        return vertical_positions
    end

    def horizontal_dirs
    #   horizontal_dirs = left_positions + right_positions
    #   return horizontal_dirs

        diffs = [[0,-1],[0,1]]
        start_pos = self.pos
        horizontal_positions = []

        diffs.each do |dif|
            row_diff,col_diff = dif
            current_pos = start_pos
            while valid_pos?(current_pos)
                row,col = current_pos
                current_pos = [row + row_diff, col + col_diff]
                horizontal_positions << current_pos
            end
            horizontal_positions.pop
        end
        return horizontal_positions
    end

    def diagnol_dirs
        diffs = [[-1,-1], [1,-1], [-1,1], [1,1]]
        start_pos = self.pos
        diag_positions = []
        diffs.each do |dif|

            row_diff,col_diff = dif
            current_pos = start_pos
          while valid_pos?(current_pos)
            row,col = current_pos
            current_pos = [row + row_diff , col + col_diff]
            diag_positions << current_pos
          end
            diag_positions.pop
        end

        return diag_positions
    end

# private

    def left_positions
        start_pos = self.pos

        current_pos = start_pos
        left_positions = []
        while valid_pos?(current_pos)
            row,col = current_pos
            current_pos = [row,col - 1]
            left_positions << current_pos
        end
        left_positions.pop
        return left_positions
    end

    def right_positions
        start_pos = self.pos

        current_pos = start_pos
        right_positions = []
        while valid_pos?(current_pos)
            row,col = current_pos
            current_pos = [row,col + 1]
            right_positions << current_pos
        end
        right_positions.pop
        return right_positions
    end

end