abs = ('a'..'z').to_a

abs_vowels = ['a', 'e', 'i', 'o', 'u', 'y']
vowels = {}
abs.each_with_index do |letter, index|
  vowels[letter] = index + 1 if abs_vowels.include?(letter)
end
