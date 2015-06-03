class Tree
  class Node
    attr_accessor :is_word, :children
    def initialize
      @children = { }
      @is_word = false
    end
  end
end
