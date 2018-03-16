puts 'Введите a'
a = gets.to_f
puts 'Введите b'
b = gets.to_f
puts 'Введите c'
c = gets.to_f
discriminant = b**2 - 4 * a * c

if discriminant > 0
  root_discriminant = Math.sqrt(discriminant.abs)
  x1 = (-b + root_discriminant) / (2 * a)
  x2 = (-b - root_discriminant) / (2 * a)
  puts "Дискриминант: #{discriminant}, корень 1:  #{x1}, корень 2:  #{x2}"
elsif discriminant.zero?
  x = -b / (2 * a)
  puts "Дискриминант: #{discriminant}, корень: #{x}"
else
  puts "Дискриминант: #{discriminant}. Корней нет"
end
