require_relative 'lib/tree'
test=Tree.new
puts 'Add word "test"'
puts 'Add word "tesla"'
puts 'Add word "temp"'
test.add('test')
test.add('tesla')
test.add('temp')
puts "\nIs the 'test' include?"
p test.include?('test')
puts "\nIs the 'tesla' include?"
p test.include?('tesla')
puts "\nIs the 'temp' include?"
p test.include?('temp')
puts "\nReturn all with prefix 'tes'"
test.list('tes')
puts "\nReturn all with prefix 'te'"
test.list('te')
puts "\n\nReturn all with prefix 't'"
test.list('t')
puts "\nReturn all with NO prefix"
test.list
puts "\nReturn all with nonexisting prefix 'r'"
test.list('r')