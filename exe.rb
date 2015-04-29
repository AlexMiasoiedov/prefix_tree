load 'lib/tree/node.rb'
load 'lib/tree.rb'

test=Tree.new
puts 'Write the word: '
str=gets.chomp
test.add(str)
puts 'Search the word: '
str=gets.chomp
test.include?(str)