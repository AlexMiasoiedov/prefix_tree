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
      child = current.children[ch]
      return false if child.nil?
      current = current.children[ch]
    end
    if current.is_word
      return true
    else
      return false
    end
  end

  def list (str='')
    @arr_word = []
    word = ''
    current = get_prefix(str, word)
    some_method(current.children, word)
    @arr_word.each { |w| puts w }
  end

  private
  def some_method (object_hash, word)
    object_hash.each do |key, value|
      current = object_hash[key]
      p key
      word << key
      @arr_word << word if current.is_word && word.length >= WORD_MIN_LENGTH
      some_method(current.children, word)
    end
  end

  private
  def get_prefix (str, word)
    current = @root
    str.split('').each do |ch|
      next_node = current.children[ch]
      puts "next node: #{next_node.inspect}"
      next if next_node.nil?
      current = current.children[ch]
      word << ch
    end
    return current
  end
end
