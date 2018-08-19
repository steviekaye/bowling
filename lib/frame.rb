class Frame
  attr_reader :frame

  def initialize(bowl)
    @frame = bowl
  end

  def strike?
    @frame[0] == 10
  end

  def spare?
    @frame[0] + @frame[1] == 10
  end

  def score_frame
    if @frame.length == 3
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
end
