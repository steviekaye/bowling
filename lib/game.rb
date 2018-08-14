require_relative "frame"

class Game
  def initialize(ui)
    @ui = ui
    @turns = []
    @running_total = []
  end

  def play_turn
    turn = Frame.new
    @ui.print_turn_instructions

    input = gets
    if input == "\n"
      if final_turn?
        turn.complete_final_turn
      end
      record_turn(turn)
    else
      @ui.press_enter
    end

    @ui.print_scoreboard(@turns, @running_total, total_score)
  end

  def total_score(turns = @turns)
    turns.each_with_index.map { |t, i|
      if t.strike?
        t.score_turn +
        if turns[i + 1].nil?
          0
        else
          if turns[i + 1].strike?
            if turns[i + 2].nil?
              0
            else
              10 + turns[i + 2].get_first
            end
          else
            turns[i + 1].score_turn
          end
        end
      elsif t.spare?
        t.score_turn +
        if turns[i + 1].nil?
          0
        else
          turns[i + 1].get_first
        end
      else
        t.score_turn
      end
    }.reduce(0, :+)
  end

  def running_total
    @turns.map.with_index { |t, i|
      if @turns[i + 1].nil?
        @running_total[i] = total_score(@turns[0..i])
      else
        @running_total[i] = total_score(@turns[0..i + 1]) - @turns[i + 1].score_turn
      end
    }
  end

  def game_over?
    @turns.length == Bowling::NUM_TURNS
  end

  private

  def record_turn(turn)
    @turns.push(turn)
    running_total
  end

  def final_turn?
    @turns.length == (Bowling::NUM_TURNS - 1)
  end
end