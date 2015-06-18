require 'sinatra/base'
require 'json'
require 'debugger'
require_relative '../lib/prefix_tree'

class PrefixTree < Sinatra::Application
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
    if settings.test?
      tree.write_file('spec/files/write')
    else
      tree.write_file('files/write')
    end
  end

  get "/write_zip" do
    if settings.test?
      tree.write_zip('spec/files/write.zip')
    else
      tree.write_zip('files/write.zip')
    end
  end

  get "/read_file" do
    if settings.test?
      tree.read_file('spec/files/read')
      words_hash = {}
      tree.list.each { |word| words_hash[word] = word }
      JSON.generate(words_hash)
    else
      tree.read_file('files/read')
      words_hash = {}
      tree.list.each { |word| words_hash[word] = word }
      JSON.generate(words_hash)
    end
  end

  get "/read_zip" do
    if settings.test?
      tree.read_zip('spec/files/read.zip')
      words_hash = {}
      tree.list.each { |word| words_hash[word] = word }
      JSON.generate(words_hash)
    else
      tree.read_zip('files/read.zip')
      words_hash = {}
      tree.list.each { |word| words_hash[word] = word }
      JSON.generate(words_hash)
    end
  end
  run! if app_file == $0
end
