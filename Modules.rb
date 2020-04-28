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