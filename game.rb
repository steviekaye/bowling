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
      record_turn(turn)
    else
      @ui.press_enter
    end

    @ui.print_scoreboard(@turns, @running_total, total_score)
  end

  def total_score(turns = @turns)
    turns.map { |t| t.score_turn }.reduce(0, :+)
  end

  def running_total
    @turns.map.with_index { |t, i|
      @running_total[i] = total_score(@turns[0..i])
    }
  end

  def get_running_total
    @running_total
  end

  def game_over?
    @turns.length == Bowling::NUM_TURNS
  end

  private

  def record_turn(turn)
    @turns.push(turn)
    running_total
  end
end
