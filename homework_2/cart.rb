cart = {}

loop do
  puts 'Введите название товара'
  name = gets.chomp

  break if name == 'Стоп'

  puts 'Введите цену товара'
  price = gets.to_i
  puts 'Введите количество товара'
  number = gets.to_f

  cart[name] = { price: price, number: number, final_amount: price * number }
end

final_amount = 0

puts cart

cart.each do |product, value|
  product_final_amount = value[:final_amount]
  final_amount += product_final_amount
  
  puts product_final_amount
end

puts final_amount
