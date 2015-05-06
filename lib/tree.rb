require_relative 'tree/node'

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
      w = list
      w.each { |word| file.write(word << "\n") }
    end
  end

  def read_file
    File.open('files/read', 'r') do |f|
      f.each_line { |line| add(line.chomp) }
    end
  end

  def list (str = '', words_arr = Array.new)
    cur_node = iterate_nodes(str)
    cur_node.children.each do |key, value|
      prefix = ''
      prefix << str
      prefix << key
      words_arr.push(prefix) if value.is_word && prefix.length >= WORD_MIN_LENGTH
      list(prefix, words_arr)
    end
    puts words_arr.inspect
    words_arr
  end

  private
  def iterate_nodes (w)
    current = @root
    w.split('').each do |ch|
      break if current.children[ch].nil?
      current = current.children[ch]
    end
    return current
  end
end
