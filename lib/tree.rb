require_relative 'tree/node'
require 'zip'

class Tree
  WORD_MIN_LENGTH = 5

  def initialize
    @root = Node.new
  end

  def add (str)
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

  def include? (str)
    current = @root
    str.split('').each do |ch|
      return false if current.children[ch].nil?
      current = current.children[ch]
    end
    return current.is_word
  end

  def write_file
    File.open('files/write', 'w') do |file|
      w = self.list
      w.each { |word| file.write(word << "\n") }
    end
  end

  def read_file
    File.open('files/read', 'r') do |f|
      f.each_line { |line| self.add(line.chomp) }
    end
  end

  def list (str = '')
    words_holder = Array.new
    self.find_words(str, words_holder)
  end

  def find_words (prefix, words_holder)
    current_node = @root
    prefix.split('').each do |node|
      break current_node if current_node.children[node].nil?
      current_node = current_node.children[node]
    end
    words_holder.push(prefix) if current_node.is_word && prefix.length >= WORD_MIN_LENGTH
    current_node.children.each do |key, val|
      pref = ''
      pref << prefix
      self.find_words(pref << key, words_holder)
    end
    words_holder
  end

  def write_zip
    File.delete('files/write.zip') if File.exist?('files/write.zip')
    Zip::File.open('files/write.zip', Zip::File::CREATE) do |zf|
      self.write_file
      zf.add('write', 'files/write')
    end
  end

  def read_zip
    Zip::File.open('files/read.zip') do |zf|
      puts "\nadd zip file into tree"
      zf.read('read').split("\n").each { |line| self.add(line) }
    end
  end
end
