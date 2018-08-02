
def turn
first = 1+rand(10)
second = 0
if first == 10
  print "X  |"
  else
  second = 1+rand(10-first)
    if first + second == 10
    print "#{first} /|"
    else
    print "#{first} #{second}|"
    end
  end
$totalpoints = $totalpoints + first + second
end

numturns = 10
$totalpoints = 0
puts "_" * 41
print "|"
until numturns == 0
turn
numturns = numturns - 1
end
print "\n"
puts "_" * 41
puts "Total score is #{$totalpoints}"
