require_relative 'tree/node'

require 'zip'

class Tree
  WORD_MIN_LENGTH = 3

  def initialize
    @root = Node.new
  end

  def add(str = '')
    return if str == ''
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

  def include?(str = '')
    current_node = @root
    str.split('').each do |ch|
      return false if current_node.children[ch].nil?
      current_node = current_node.children[ch]
    end
    return current_node.is_word
  end

  def write_file(path = 'files/write')
    File.open(path, 'w') do |file|
      words = list
      words.each { |word| file.write(word + "\n") }
    end
    return nil
  end

  def read_file(path = 'files/read')
    File.open(path, 'r') { |f| f.each_line { |line| add(line) } }
  end

  def list(str = '')
    search_root_node = find_node(str)
    if search_root_node
      find_words(search_root_node, str)
    else
      []
    end
  end

  def find_words(current_node, prefix, words_holder = [])
    words_holder.push(prefix) if current_node.is_word && prefix.length >= WORD_MIN_LENGTH
    current_node.children.each do |key, val|
      find_words(val, prefix + key, words_holder)
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
    return nil
  end

  def read_zip(path = 'files/read.zip', file = 'read')
    Zip::File.open(path) { |zf| zf.read(file).each_line { |line| add(line.chomp) } }
  end

  private
  def find_node(str = '')
    current_node = @root
    str.split('').each do |ch|
      return false if current_node.children[ch].nil?
      current_node = current_node.children[ch]
    end
    return current_node
  end
end
