puts 'Как Вас зовут?'
name = gets.chomp
puts 'Какой ваш рост?'
growth = gets.to_f
weight = growth - 110

if weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес - #{weight}"
end
