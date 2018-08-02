
def turn
first = 1+rand(10)
second = 0
if first == 10
  puts "X"
  else
  second = 1+rand(10-first)
    if first + second == 10
    puts "#{first} /"
    else
    puts "#{first} #{second}"
    end
  end
$totalpoints = $totalpoints + first + second
end

numturns = 10
$totalpoints = 0
until numturns == 0
turn
numturns = numturns - 1
end
puts "Total score is #{$totalpoints}"
