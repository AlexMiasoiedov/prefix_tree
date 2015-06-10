require 'spec_helper'

require_relative '../app/sinatra_tree.rb'

RSpec.describe do

  describe '#homepage test', :type => :feature do
    it 'opens homepage' do
      visit '/'
      expect(page).to have_content 'Welcome to my page!'
    end
  end

  describe '#list', :type => :feature do
    it 'user click on list button' do
      find('form').submit_form!
      expect(page).to have_content 'word'
    end
  end

end

