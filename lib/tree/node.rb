class Node
  attr_accessor :is_word, :children
  def initialize #(key)
    @children={} #{key}
  end
end