class Tree
  class Node
    attr_accessor :is_word, :children
    def initialize
      @children = { }
    end
  end
end
