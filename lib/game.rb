require_relative "frame"

class Game
  def initialize(ui)
    @ui = ui
    @turns = []
    @running_total = []
  end

  def play_turn
    @ui.print_turn_instructions

    input = gets
    if input == "\n"
      turn = Frame.new(bowl)
      record_turn(turn)
    else
      @ui.press_enter
    end

    @ui.print_scoreboard(@turns, @running_total, total_score)
  end

  def total_score
    @running_total[-1]
  end

  def cumulative_total(turns)
    scored_turns = score_turns(turns)

    cumulative_scores = scored_turns.map.with_index do |t, i|
      scored_turns.slice(0, i + 1).reduce(0, :+)
    end

    completed_scores(turns, cumulative_scores)
  end

  def game_over?
    @turns.length == Bowling::NUM_TURNS
  end

  private

  def completed_scores(turns, cumulative_scores)
    last_frame = turns[-1]
    second_to_last_frame = turns[-2]

    if last_frame.frame.length == 3
      cumulative_scores
    elsif second_to_last_frame
      if second_to_last_frame.strike? && last_frame.strike?
        cumulative_scores[0...-2]
      elsif last_frame.strike? || last_frame.spare?
        cumulative_scores[0...-1]
      else
        cumulative_scores
      end
    elsif last_frame.strike? || last_frame.spare?
      cumulative_scores[0...-1]
    else
      cumulative_scores
    end
  end

  def score_turns(turns)
    turns.each_with_index.map do |t, i|
      next_turn = turns[i + 1]
      second_next_turn = turns[i + 2]

      if t.strike? && next_turn && second_next_turn
        if next_turn.strike?
          t.score_frame + next_turn.score_frame + second_next_turn.get_first
        else
          t.score_frame + next_turn.score_frame
        end
      elsif t.strike? && next_turn
        # edge case of final turn having a strike or a spare - we don't want the third ball
        if next_turn.frame.length == 3
          t.score_frame + next_turn.get_first + next_turn.get_second
        else
          t.score_frame + next_turn.score_frame
        end
      elsif t.spare? && next_turn
        t.score_frame + next_turn.get_first
      else
        t.score_frame
      end
    end
  end

  def record_turn(turn)
    @turns.push(turn)
    @running_total = cumulative_total(@turns)
  end

  def final_turn?
    @turns.length == (Bowling::NUM_TURNS - 1)
  end

  def bowl
    first = rand(11)
    second = second_ball(first)

    if final_turn?
      bowl_final_turn(first, second)
    else
      [first, second]
    end
  end

  def second_ball(first_ball)
    if first_ball == 10
      0
    else
      rand(11 - first_ball)
    end
  end

  def bowl_final_turn(first_ball, second_ball)
    if first_ball == 10
      bonus_ball = rand(11)

      if bonus_ball == 10
        [first_ball, bonus_ball, rand(11)]
      else
        [first_ball, bonus_ball, second_ball(bonus_ball)]
      end
    elsif first_ball + second_ball == 10
      [first_ball, second_ball, rand(11)]
    else
      [first_ball, second_ball, 0]
    end
  end
end
