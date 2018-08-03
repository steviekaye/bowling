def turn
  first = rand(11)

  second =
    if first == 10
      0
    else
      rand(11 - first)
    end

  #puts [first, second].join(" ")
  [first, second]
end

def play_game
  numturns = 10
  turns = []
  puts "Press enter to bowl another turn"
  until turns.length == 10
    input = gets
    if input == "\n"
      turns.push(turn)
      display_score(turns[-1])
    end
  end

  totalpoints = 0

  for i in turns
    totalpoints += i[0] + i[1]
  end

  puts
  puts "Total score is #{totalpoints}"
end

def display_score(arr)
  if arr[0] == 10
    puts "X  "
  elsif arr[0]+arr[1] == 10
    puts "#{arr[0]} /"
  else
    puts "#{arr[0]} #{arr[1]}"
  end
end


play_game


# def strike?(turn)
#   puts turn[0] == 10
# end
#
# def spare?(turn)
#   turn[0] + turn[1] == 10
# end
#
# is_strike?([10, 0])
# is_strike?([5, 5])
