class Frame
  def initialize
    @final = false
    @frame = bowl
  end

  def strike?
    @frame[0] == 10
  end

  def spare?
    @frame[0] + @frame[1] == 10
  end

  def score_turn
    if is_final?
      @frame[0] + @frame[1] + @frame[2]
    else
      @frame[0] + @frame[1]
    end
  end

  def get_first
    @frame[0]
  end

  def get_second
    @frame[1]
  end

  def get_bonus
    @frame[2]
  end

  def set_final
    @final = true
    if self.strike?
      bonus_one = bowl
      if bonus_one[0] == 10
        bonus_two = bowl
        @frame = [10, 10, bonus_two[0]] # = [@frame[0], bonus_one[0], bonus_two[0]]
      else
        @frame = [10, bonus_one[0], bonus_one[1]] # = [@frame[0], bonus_one[0], bonus_one[1]]
      end
    elsif self.spare?
      bonus_one = bowl
      @frame = [@frame[0], @frame[1], bonus_one[0]]
    else
      @frame = [@frame[0], @frame[1], 0]
    end
  end

  def is_final?
    @final
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
