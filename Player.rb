class Player
    attr_reader :cursor, :selected_pos
    def initialize(cursor,player_name,color)
       @cursor, @player_name, @color = cursor,player_name,color
       @selected_pos = nil
    end

    def make_move
        if !selected?
            @selected_pos = cursor.get_input
        else
            new_pos = cursor.get_input
        end

        if !selected_pos.nil? && !new_pos.nil?
            return [@selected_pos,new_pos]
        end
    end

    def selected?
        cursor.selected == true
    end
end

class Human_player < Player
end

class ComputerPlayer < Player
end