require_relative "frame"

class Game
  def initialize(ui)
    @ui = ui
    @turns = []
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

    @ui.print_scoreboard(@turns, total_score)
  end

  def total_score
    @turns.map { |t| t.score_turn }.reduce(0, :+)
  end

  def game_over?
    @turns.length == Bowling::NUM_TURNS
  end

  private

  def record_turn(turn)
    @turns.push(turn)
  end
end
