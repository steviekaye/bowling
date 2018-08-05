class Frame
  def initialize
    @frame = bowl
  end

  def strike?
    @frame[0] == 10
  end

  def spare?
    @frame[0] + @frame[1] == 10
  end

  def score_turn
    @frame[0] + @frame[1]
  end

  def get_first
    @frame[0]
  end

  def get_second
    @frame[1]
  end

  private

  def bowl
    first = rand(11)
    second = second_ball(first)

    [first, second]
  end

  def second_ball(first_ball)
    if first_ball == 10
      0
    else
      rand(11 - first_ball)
    end
  end
end
