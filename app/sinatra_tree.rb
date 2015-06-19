require 'sinatra/base'
require 'json'
require 'debugger'
require_relative '../lib/prefix_tree'

class PrefixTree < Sinatra::Application

  if settings.test?
    path = 'spec/files/'
  else
    path = 'files/'
  end

  tree = Tree.new
  tree.add('testtree')
  tree.add('testtabdh')
  tree.add('someone')

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
    tree.write_file('spec/files/write')
  end

  get "/write_zip" do
    tree.write_zip(path + 'write.zip')
  end

  get "/read_file" do
    tree.read_file(path + 'read')
    words_hash = {}
    tree.list.each { |word| words_hash[word] = word }
    JSON.generate(words_hash)
  end

  get "/read_zip" do
    tree.read_zip(path + 'read.zip')
    words_hash = {}
    tree.list.each { |word| words_hash[word] = word }
    JSON.generate(words_hash)
  end
  run! if app_file == $0
end
