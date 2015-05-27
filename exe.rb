require_relative 'lib/prefix_tree.rb'

test=Tree.new
=begin
puts 'Add word "test"'
puts 'Add word "tesla"'
puts 'Add word "temp"'
test.add('test')
test.add('tesla')
test.add('temp')
test.add('writing_zip')
puts "\nIs the 'test' include?"
p test.include?('test')
puts "\nIs the 'tesla' include?"
p test.include?('tesla')
puts "\nIs the 'temp' include?"
p test.include?('temp')
puts "\nIs the 'fake' include?"
p test.include?('fake')
puts "\nwriting file"
test.write_file
puts "\nreading file"
test.read_file
puts "\nlist test:"
p test.list
puts "\nwriting zipfile"
test.write_zip
puts "\nreading zipfile"
test.read_zip
=end
puts "add 'add_method'"
test.add('add_method')
puts "include 'add_method'"
p test.include?('add_method')
puts 'reading from file'
test.read_file
puts 'reading from zip file'
test.read_zip
puts 'tree list'
p test.list
puts 'write file'
test.write_file
puts 'write zipfile'
test.write_zip
#p File.readable?('spec/test_files/write')
