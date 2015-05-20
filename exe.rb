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
puts "\nIs the 'fake' include?"
p test.include?('fake')
puts "\nreading file"
test.read_file
puts "\nlist test:"
p test.list
puts "\nwriting zipfile"
test.write_zip
puts "\nreading zipfile"
test.read_zip