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

  post "/clear" do
    session[:tree] = nil
    redirect '/'
  end
  
  get "/" do
    if session[:tree] == nil
      session[:tree] = Tree.new
    end
    erb :index
  end

  post "/add" do
    session[:tree].add(params[:word]) 
  end

  get "/list" do
    words_array = []
    session[:tree].list(params[:pref]).each { |word| words_array << word }
    JSON.generate(words_array)
  end

  post "/write_file" do
    session[:tree].write_file(path + 'write')
  end

  post "/write_zip" do
    session[:tree].write_zip(path + 'write.zip')
  end

  post "/read_file" do
    session[:tree].read_file(path + 'read')
    words_array = []
    session[:tree].list.each { |word| words_array << word }
    JSON.generate(words_array)
  end

  post "/read_zip" do
    session[:tree].read_zip(path + 'read.zip')
    words_array = []
    session[:tree].list.each { |word| words_array << word }
    JSON.generate(words_array)
  end
  run! if app_file == $0
end
