require 'sinatra'

require 'haml'

require_relative 'lib/prefix_tree'

before do
  @tree = Tree.new
  @tree.add('tree_is_working')
end

get "/" do
  erb :index 
end

get "/add" do
  @tree.add(params[:word])
  @tree.write_file
end

get "/list" do
  p @tree.list
end
