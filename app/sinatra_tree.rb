require 'sinatra'
require 'json'
require 'debugger'
require_relative '../lib/prefix_tree'

tree = Tree.new
tree.add('word')
tree.add('grrrr')
tree.add('beeee')

get "/" do
  erb :index
end

get "/add" do
  tree.add(params[:word])
  words_hash = {}
  tree.list.each { |word| words_hash[word] = word }
  JSON.generate(words_hash)
end

get "/list" do
  words_hash = {}
  tree.list(params[:pref]).each { |word| words_hash[word] = word }
  JSON.generate(words_hash)
end

get "/write_file" do 
  tree.write_file('files/write')
end

get "/write_zip" do
  tree.write_zip('files/write.zip')
end

get "/read_file" do
  tree.read_file('files/read')
  words_hash = {}
  tree.list.each { |word| words_hash[word] = word }
  JSON.generate(words_hash)
end

get "/read_zip" do
  tree.read_zip('files/read.zip')
  words_hash = {}
  tree.list.each { |word| words_hash[word] = word }
  JSON.generate(words_hash)
end
