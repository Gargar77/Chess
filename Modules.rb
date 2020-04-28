module Stepable
    # class must have #move_diff!
    def moves
        deltas = move_diff
        start_row,start_col = pos
        possible_moves = deltas.map { |(row,col)| [start_row + row,start_col + col]}
        possible_moves.reject! { |el| !valid_pos?(pos)}
        possible_moves
    end
end