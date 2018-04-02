numbers = []
default_numbers = [0, 1]

while default_numbers[0] <= 100
  numbers.push(default_numbers[0])
  default_numbers[0], default_numbers[1] = default_numbers[1], default_numbers[0] + default_numbers[1]
end

puts numbers
