module Stepable
    # class must have #move_diff!
    def moves
        deltas = move_diff
        start_row,start_col = pos
        p possible_moves = deltas.map { |(row,col)| [start_row + row,start_col + col]}
       current_possible_moves = possible_moves.select { |el| valid_pos?(el)}
       p current_possible_moves
    end
end

module Slideable
    def horizontal_dirs
      horizontal_dirs = left_positions + right_positions
      return horizontal_dirs
    end

    def diagnol_dirs
        
    end

    def moves

    end
    
private
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