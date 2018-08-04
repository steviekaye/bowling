NUM_TURNS = 10

def bowl
  first = rand(11)

  second =
    if first == 10
      0
    else
      rand(11 - first)
    end

  [first, second]
end

def strike?(frame)
  frame[0] == 10
end

def spare?(frame)
  frame[0] + frame[1] == 10
end

def format_score(frame)
  if frame.nil?
    "   "
  elsif strike?(frame)
    "X  "
  elsif spare?(frame)
    "#{frame[0]} /".gsub(/0/, '-')
  else
    "#{frame[0]} #{frame[1]}".gsub(/0/, '-')
  end
end

def game_over?(turns)
  turns.length == NUM_TURNS
end

def print_turn_instructions
  puts "Press enter to bowl a turn"
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

def score_turn(turn)
  turn[0] + turn[1]
end

def total_score(turns)
  turns.map { |t| score_turn(t) }.reduce(0, :+)
end

def print_scoreboard(turns)
  system "clear"
  draw_scoreboard_top
  draw_scoreboard_mid(turns)
  draw_scoreboard_bottom
end

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

def draw_scoreboard_mid(turns)
  mid_std = ""
  pipe = "│"

  NUM_TURNS.times do |x|
    mid_std += (pipe + format_score(turns[x]))
  end

  mid_std += (pipe + format_total_score(total_score(turns)) + pipe)
  puts mid_std
end

def end_message(score)
  if score > 87
    puts "Great work! You are the Aliens of bowling!"
  elsif score > 72
    puts "Not bad! You are the Alien 3 of bowling!"
  else
    puts "Room for improvement! You are the Alien: Resurrection of bowling!"
  end
end

def play_game
  turns = []

  until game_over?(turns)
    print_turn_instructions

    input = gets
    if input == "\n"
      turns.push(bowl)
    end

    print_scoreboard(turns)
  end
  
  end_message(total_score(turns))
end

play_game
