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

  def get_prefix (str)
    current = @root
    str.split('').each do |ch|
      current = current.children[ch]
    end
    return current
  end

  def some_method (object_hash)
    p "object hash #{object_hash}"
    object_hash.each do |key, value|
      current = object_hash[key]
      p key
      some_method (current.children)
    end
  end

  def list (str='')
    current = get_prefix (str)
    some_method (current.children)
  end
end
