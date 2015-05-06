require_relative 'lib/tree'
test=Tree.new
puts 'Add word "test"'
puts 'Add word "tesla"'
puts 'Add word "temp"'
puts 'Add word "worked"'
test.add('test')
test.add('tesla')
test.add('temp')
puts "\nIs the 'test' include?"
p test.include?('test')
puts "\nIs the 'tesla' include?"
p test.include?('tesla')
puts "\nIs the 'temp' include?"
p test.include?('temp')
puts "\nIs the 'fake' include?"
p test.include?('fake')
puts "\nreading file"
test.read_file
puts "\nlist test:"
puts test.list
test.write_file

