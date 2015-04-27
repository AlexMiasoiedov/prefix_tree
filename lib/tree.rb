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
end
test=Tree.new
test.add('test')
