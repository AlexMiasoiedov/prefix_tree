require 'sinatra'


require_relative '../lib/prefix_tree'
#require_relative 'helpers/def_tree'

get "/" do
  erb :index
end

get "/add" do
  @tree.add(params[:word])
end

get "/list" do
  p @tree.list(params[:pref])
end
