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
end

get "/list" do
  "@tree.include?('tree_is_working')"
end
