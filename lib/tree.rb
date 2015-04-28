load 'tree/node.rb'
class Tree
  def initialize
    @root=TreeNode.new
  end
  def add (str)
    @current=@root
    @arr=str.split('')
    @arr.each do |ch|
      @next=@current.children[ch]
      if @next.nil?
        @next=TreeNode.new
        @current.children[ch]=@next  #
      end
      @current=@next
    end
    @current.is_word=true
  end
  def include? (str)
    @current=@root
    @arr=str.split('')
    @arr.each do |ch|
      @child=@current.children[ch]
      if @child.nil?
        puts false
        break
      end
      @current=@current.children[ch]
    end
    if @current.is_word
      puts true
    end
  end
end
