numbers = []
number1 = 0
number2 = 1

while number1 <= 100
  number_local = number2
  number2 = number1 + number2
  numbers.push(number1)
  number1 = number_local
end

puts numbers
