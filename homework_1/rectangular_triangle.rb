puts 'Введите 1 сторону треугольника'
a = gets.to_f
puts 'Введите 2 сторону треугольника'
b = gets.to_f
puts 'Введите 3 сторону треугольника'
c = gets.to_f
text = 'Треугольник не прямоугольный'
square_arr = [a, b, c].sort
hypotenuse = square_arr[2]
leg1 = square_arr[0]
leg2 = square_arr[1]

is_rectangular = hypotenuse**2 == leg1**2 + leg2**2

if a == b && a == c
  text = 'Треугольник равносторонний и равнобедренный, но не прямоугольный'
elsif is_rectangular && leg2 == leg1
  text = 'Треугольник прямоугольный и равнобедренный'
elsif is_rectangular
  text = 'Треугольник прямоугольный'
end

puts text
