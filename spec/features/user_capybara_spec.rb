
require 'spec_helper'

RSpec.describe '#tree front-end', :type => :feature do
  before :each do
    visit '/'
  end

  describe '#homepage', :js => true do
    it 'should have content with existing words by default' do
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
    end
    it 'should NOT have unexicting content' do
      expect(page).to have_no_content 'fake content'
    end
  end

  describe '#add word', :js => true do
    it 'used type "new_word" and click on add button' do
      within("form#add-form") do
        fill_in 'text-area', :with => 'new_word'
      end
      #save_and_open_screenshot('b_add.png')
      click_button 'add'
      #save_and_open_screenshot('a_add.png')
      within("div#list-output") do
        #save_and_open_screenshot
        expect(page).to have_content 'new_word'
        #save_and_open_screenshot
        #puts Capybara.current_session.server.host
        #puts Capybara.current_session.server.port
      end
    end

    it 'nothing happens when used try to add nothing' do
      click_button 'add'
      expect(page).to have_content nil
    end
  end

  describe '#list', :js => true do
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
        #save_and_open_screenshot
      end
      click_button 'list'
      #save_and_open_screenshot
      expect(page).to have_content 'word'
      #save_and_open_screenshot
    end

    it 'user fill specific unexisting prefix and click on list button' do
      within("form#list-form") do
        fill_in 'text-ar', :with => 'q'
        #save_and_open_screenshot
      end
      click_button 'list'
      #save_and_open_screenshot
      expect(page).to have_content nil
      #save_and_open_screenshot
    end
  end

  describe '#read', :js => true do
    it 'user click on read button' do
      click_button 'read'
      #save_and_open_screenshot
      expect(page).to have_content 'default_read_file'
      #save_and_open_screenshot #!!!!!!!!!! do not make the screenshot
    end
  end

  describe '#read zip', :js => true do
    it 'user click on read_zip button' do
      click_button 'read-zip'
      #save_and_open_screenshot
      expect(page).to have_content 'default_read_zip'
      #save_and_open_screenshot #!!!!!!!!!! do not make the screenshot
    end
  end
end
