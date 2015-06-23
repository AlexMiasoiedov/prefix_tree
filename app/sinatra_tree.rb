require 'sinatra/base'
require 'json'
require 'debugger'
require_relative '../lib/prefix_tree'

class PrefixTree < Sinatra::Application

  enable :sessions

  if settings.test?
    path = 'spec/files/'
  else
    path = 'files/'
  end
=begin
  get "/new_tree" do
    session['tree'] = Tree.new
  end
=end
  get "/" do
    session['tree'] = Tree.new
    erb :index
  end

  get "/add" do
    session[:tree].add(params[:word])
    words_array = []
    session[:tree].list.each { |word| words_array << word }
    JSON.generate(words_array)
  end

  get "/list" do
    words_array = []
    session[:tree].list(params[:pref]).each { |word| words_array << word }
    JSON.generate(words_array)
  end

  get "/write_file" do
    session[:tree].write_file(path + 'write')
  end

  get "/write_zip" do
    session[:tree].write_zip(path + 'write.zip')
  end

  get "/read_file" do
    session[:tree].read_file(path + 'read')
    words_array = []
    session[:tree].list.each { |word| words_array << word }
    JSON.generate(words_array)
  end

  get "/read_zip" do
    session[:tree].read_zip(path + 'read.zip')
    words_array = []
    session[:tree].list.each { |word| words_array << word }
    JSON.generate(words_array)
  end
  run! if app_file == $0
end
