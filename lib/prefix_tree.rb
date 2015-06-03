require_relative 'tree/node'

require 'zip'

require "debugger"

class Tree
  WORD_MIN_LENGTH = 3

  def initialize
    @root = Node.new
  end

  def add(str)
    str.chomp!
    current = @root
    str.split('').each do |ch|
      next_node = current.children[ch]
      if next_node.nil?
        next_node = Node.new
        current.children[ch] = next_node
      end
      current = next_node
    end
    current.is_word = true
  end

  def include?(str)
    current = @root
    str.split('').each do |ch|
      return false if current.children[ch].nil?
      current = current.children[ch]
    end
    return current.is_word
  end

  def write_file(path = 'files/write')
    File.open(path, 'w') do |file|
      words = list
      words.each { |word| file.write(word << "\n") }
    end
  end

  def read_file(path = 'files/read')
    File.open(path, 'r') { |f| f.each_line { |line| add(line) } }
  end

  def list(str = '')
    find_words(str)
  end

  def find_words(prefix, words_holder = [])
    current_node = @root
    prefix.split('').each do |node|
      break if current_node.children[node].nil?
      current_node = current_node.children[node]
    end
    words_holder.push(prefix) if current_node.is_word && prefix.length >= WORD_MIN_LENGTH
    current_node.children.each do |key, val|
      find_words(prefix + key, words_holder)
    end
    words_holder
  end

  def write_zip(path = 'files/write.zip')
    Zip::File.open(path) do |zf|
      zf.get_output_stream('write') do |f|
        words = list
        words.each { |word| f.puts word + "\n" }
      end
    end
  end

  def read_zip(path = 'files/read.zip', file = 'read')
    Zip::File.open(path) { |zf| zf.read(file).each_line { |line| add(line.chomp) } }
  end
end
