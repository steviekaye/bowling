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

def display_score(frame)
  if strike?(frame)
    "X  "
  elsif spare?(frame)
    "#{frame[0]} /"
  else
    "#{frame[0]} #{frame[1]}"
  end
end

def game_over?(turns)
  turns.length == 10
end

def print_turn_instructions
  puts "Press enter to bowl a turn"
end

def print_total_score(turns)
  if total_score(turns) < 10
    "  #{total_score(turns)} "
  elsif total_score(turns) == 100
    "#{total_score(turns)} "
  else
    " #{total_score(turns)} "
  end
end

def score_turn(turn)
  turn[0] + turn[1]
end

def total_score(turns)
  turns.map { |t| score_turn(t) }.reduce(0, :+)
  #turns.map { |x| x[0] + x[1] }.reduce(0, :+)
end

def print_scoreboard(turns)
  system "clear"
  draw_scoreboard_top
  draw_scoreboard_mid(turns)
  draw_scoreboard_bot
end

def draw_scoreboard_top
  top_left = sprintf("%c", 9484) + # ┌
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) # ─

  top_mid = sprintf("%c", 9516) + # ┬
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) # ─

  top_right = sprintf("%c", 9516) + # ┬
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c\n", 9488) # ┐

  puts top_left + top_mid * 9 + top_right
end

def draw_scoreboard_mid(turns)
  i = 0
  mid_std = []
  until i == 10
    mid_std.push(sprintf("%c", 9474) + # │
    if !turns[i].nil?
      display_score(turns[i])
    else
      "   "
    end)
    i +=1
  end
  mid_std.push(sprintf("%c", 9474) + # │
  print_total_score(turns) +
  sprintf("%c\n", 9474))# │
  puts mid_std.join("")
end

def draw_scoreboard_bot
  bot_left = sprintf("%c", 9492) + # └
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) # ─

  bot_mid = sprintf("%c", 9524) + # ┴
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) # ─

  bot_right = sprintf("%c", 9524) + # ┴
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c", 9472) + # ─
  sprintf("%c\n", 9496)  # ┘

  puts bot_left + bot_mid * 9 + bot_right
end

def play_game
  turns = []

  until game_over?(turns)

    print_turn_instructions

    input = gets
    if input == "\n"
      turns.push(bowl)
      #display_score(turns[-1])
    end

    print_scoreboard(turns)
  end

  #print_total_score(turns)
end

play_game
