=begin
require File.dirname(__FILE__) + '/spec helper.rb'
require Sinatra::Application.root + '/app'
disable :run

require 'capybara'
require 'capybara/dsl'

#Capybara.app = Sinatra::Application

RSpec.configure do |config|
  config.include Capybara
end
=end