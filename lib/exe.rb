load 'tree.rb'

test=Tree.new
puts 'Input the word: '
str = gets.chomp
test.add(str)
puts 'Include: '
str = gets.chomp
test.include?(str)