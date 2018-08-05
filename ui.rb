class UI
  def initialize
  end

  def print_welcome_message
    puts "Welcome to SK's bowling alley!"
  end

  def print_turn_instructions
    puts "Press enter to bowl a turn"
  end

  def press_enter
    puts "Please press ENTER!"
  end

  def print_scoreboard(turns, total_score)
    system "clear"
    draw_scoreboard_top
    draw_scoreboard_mid(turns, total_score)
    draw_scoreboard_bottom
  end

  def print_end_message(score)
    if score > 85
      puts "Great work! You are the Aliens of bowling!"
    elsif score > 72
      puts "Not bad! You are the Alien 3 of bowling!"
    else
      puts "Room for improvement! You are the Alien: Resurrection of bowling!"
    end
  end

  private

  def horizontal_line(num)
    "─" * num
  end

  def scoreboard_frameline(left_corner, cell, right_corner)
    left_corner + cell * 10 + horizontal_line(4) + right_corner
  end

  def draw_scoreboard_top
    top_cell = horizontal_line(3) + "┬"

    puts scoreboard_frameline("┌", top_cell, "┐")
  end

  def draw_scoreboard_bottom
    bottom_cell = horizontal_line(3) + "┴"

    puts scoreboard_frameline("└", bottom_cell, "┘")
  end

  def draw_scoreboard_mid(turns, total_score)
    mid_std = ""
    pipe = "│"

    Bowling::NUM_TURNS.times do |x|
      mid_std += (pipe + format_score(turns[x]))
    end

    mid_std += (pipe + format_total_score(total_score) + pipe)
    puts mid_std
  end

  def format_score(frame)
    if frame.nil?
      "   "
    elsif frame.strike?
      "X  "
    elsif frame.spare?
      "#{frame.get_first} /".gsub(/0/, '-')
    else
      "#{frame.get_first} #{frame.get_second}".gsub(/0/, '-')
    end
  end

  def format_total_score(total)
    if total < 10
      "  #{total} "
    elsif total == 100
      "#{total} "
    else
      " #{total} "
    end
  end
end