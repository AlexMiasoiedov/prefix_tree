require_relative 'lib/tree'
p Tree::Node
test=Tree.new
puts 'Add word "test"'
puts 'Add word "tesla"'
puts 'Add word "temp"'
test.add('test')
test.add('tesla')
test.add('temp')
puts "\nIs the 'test' include?"
p test.include?('test')
p 'Return all with prefix "te"'
test.list('te')