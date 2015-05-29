require 'sinatra'

require 'haml'

require_relative 'lib/prefix_tree'

before do
  @tree = Tree.new
  @tree.add('tree_is_working')
end

get "/" do erb :index end

get "/add" do erb :add end

get "/list" do erb :add end
=begin
post "/add" do
  @tree.add(params[:word])
  "successfully add word: #{params[:word]}"
end

post "/list" do
  words = p @tree.list
  "the list of words is: #{words}"
end
=end
