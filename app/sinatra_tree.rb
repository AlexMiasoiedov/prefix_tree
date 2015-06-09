require 'sinatra'

require_relative '../lib/prefix_tree'

tree = Tree.new
tree.add('the-word')

get "/" do
  erb :index
end

get "/add" do
  tree.add(params[:word])
end

get "/list" do
  tree.list(params[:pref])
end

get "/write_file" do 
  tree.write_file('files/write')
end

get "/write_zip" do
  tree.write_zip('files/write.zip')
end

get "/read_file" do
  tree.read_file('files/read')
  'success'
end

get "/read_zip" do
  tree.read_zip('files/read.zip')
end
