require 'spec_helper'

require_relative '../app/sinatra_tree.rb'
Capybara.default_driver = :selenium
Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 5

RSpec.describe '#tree front-end', :type => :feature do

  before :each do
    visit '/'
  end

  describe '#homepage' do
    it 'should have content with existing words by default' do
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
    end
    it 'should NOT have unexicting content' do
      expect(page).to have_no_content 'fake content'
    end
  end

  describe '#add word "new_word"' do
    it 'should contain content "new_word"', :js => true do
      within("form#add-form") do
        fill_in 'text-area', :with => 'new_word'
      end
      click_button 'add'
      #save_and_open_screenshot
      #visit '/'
      #save_and_open_screenshot
      within("div#list-output") do
        expect(page).to have_content 'new_word'
      end
    end
  end

  describe '#list' do
    it 'user click on list button WITHOUT specific prefix' do
      click_button 'list'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_no_content 'fake content'
    end
    it 'user fill specific prefix and click on list button' do
      within("form#list-form") do
        fill_in 'text-ar', :with => 'w'
      end
      click_button 'list'
      expect(page).to have_content 'word'
    end
    it 'user fill specific unexisting prefix and click on list button' do
      within("form#list-form") do
        fill_in 'text-ar', :with => 'q'
      end
      click_button 'list'
      expect(page).to have_content nil
    end
  end

  describe '#read' do
    it 'user click on read button' do
      click_button 'read'
      visit '/' #ajax don't send response with out page refresh
      expect(page).to have_content 'spek_read_file'
    end
  end

  describe '#read zip' do
    it 'user click on read_zip button' do
      click_button 'read-zip'
      visit '/' #ajax don't send response with out page refresh
      expect(page).to have_content 'spec_read_zip'
    end
  end

end

