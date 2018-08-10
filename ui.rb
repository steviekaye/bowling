class UI
  def initialize
  end

  def print_welcome_message
    system "clear"
    puts "Welcome to SK's bowling alley!"
  end

  def print_turn_instructions
    puts "Press enter to bowl a turn"
  end

  def press_enter
    puts "Please press ENTER!"
  end

  def print_scoreboard(turns, running_total, total_score)
    system "clear"
    draw_scoreboard_top_border
    draw_scoreboard_frame_score(turns, total_score)
    draw_scoreboard_running_total(turns, running_total, total_score)
    draw_scoreboard_bottom_border
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
    left_corner + cell * 10 + horizontal_line(5) + right_corner
  end

  def draw_scoreboard_top_border
    top_cell = horizontal_line(5) + "┬"

    puts scoreboard_frameline("┌", top_cell, "┐")
  end

  def draw_scoreboard_bottom_border
    bottom_cell = horizontal_line(5) + "┴"

    puts scoreboard_frameline("└", bottom_cell, "┘")
  end

  def draw_scoreboard_frame_score(turns, total_score)
    mid_std = ""
    pipe = "│"

    (Bowling::NUM_TURNS-1).times do |x| #(Bowling::NUM_TURNS - 1)
      mid_std += (pipe + format_score(turns[x]))
    end

    mid_std += (pipe + format_final_turn_score(turns[(Bowling::NUM_TURNS-1)]))

    mid_std += (pipe + format_running_score(total_score) + pipe)
    puts mid_std
  end

  def draw_scoreboard_running_total(turns, running_total, total_score)
    mid_std = ""
    pipe = "│"

    (Bowling::NUM_TURNS-1).times do |x| #(Bowling::NUM_TURNS - 1)
      mid_std += (pipe + format_running_score(running_total[x]))
    end

    mid_std += (pipe + format_running_score(running_total[(Bowling::NUM_TURNS-1)])) # + "   "

    mid_std += (pipe + format_running_score(total_score) + pipe)
    puts mid_std
  end

  def format_score(frame)
    if frame.nil?
      "     "
    elsif frame.strike?
      "  X  "
    elsif frame.spare?
      "  #{frame.get_first} /".gsub(/0/, "-")
    else
      "  #{frame.get_first} #{frame.get_second}".gsub(/0/, "-")
    end
  end

  def format_final_turn_score(frame)
    if frame.nil?
      "     "
    elsif frame.strike?
      "#{frame.get_first} #{frame.get_second} #{frame.get_bonus}".gsub(/10/, "X").gsub(/0/, "-")
    elsif frame.spare?
      "#{frame.get_first} / #{frame.get_bonus}".gsub(/10/, "X").gsub(/0/, "-")
    else
      "  #{frame.get_first} #{frame.get_second}".gsub(/0/, "-")
    end
  end

  def format_running_score(running_total)
    if running_total.nil?
      "     "
    elsif running_total < 10
      "    #{running_total}"
    elsif running_total >= 100
      "  #{running_total}"
    else
      "   #{running_total}"
    end
  end
end
