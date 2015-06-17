require 'capybara'
require 'capybara/rspec'

require_relative '../../../app/sinatra_tree'

Capybara.app = PrefixTree
