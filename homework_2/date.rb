print "Введите день: "
date = gets.chomp.to_i
print "Введите месяц: "
mouth = gets.chomp.to_i
print "Введите год: "
year = gets.chomp.to_i

days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_a_month[1] = 29 if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)

sum = 0
for i in 0..mouth - 2
  sum += days_in_a_month[i]
end
sum += date

puts "Порядковый номер даты: #{sum}"
