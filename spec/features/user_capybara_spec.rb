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
      page.save_screenshot('homepage.png')
    end
  end

  describe '#add word', :js => true do
    it 'used type "new_word" and click on add button' do
      within("form#add-form") do
        fill_in 'text-area', :with => 'new_word'
      page.save_screenshot('fill new_word.png')
      end
      click_button 'add'
      within("div#list-output") do
        expect(page).to have_content 'new_word'
      page.save_screenshot('add new_word.png')
      end
    end

    it 'nothing happens when used click on add button with out filling added word' do
      click_button 'add'
      expect(page).to have_content nil
      page.save_screenshot('add multiple click.png')
    end

    it 'nothing happens when used click multiple time on add button with out filling added word' do
      click_button 'add'
      click_button 'add'
      click_button 'add'
      expect(page).to have_content nil
      page.save_screenshot('add multiple click.png')
    end
  end

  describe '#list', :js => true do
    it 'user click on list button WITHOUT specific prefix' do
      click_button 'list'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_no_content 'fake content'
      page.save_screenshot('list click with out prefix.png')
    end

    it 'user fill specific prefix and click on list button' do
      within("form#list-form") do
        fill_in 'text-ar', :with => 'w'
      end
      click_button 'list'
      expect(page).to have_content 'word'
      page.save_screenshot('list click with existing prefix.png')
    end

    it 'user fill specific unexisting prefix and click on list button' do
      within("form#list-form") do
        fill_in 'text-ar', :with => 'q'
      end
      click_button 'list'
      expect(page).to have_content nil
      page.save_screenshot('list click with unexisting prefix.png')
    end
  end

  describe '#user click on read button', :js => true do
    it 'page should have content from read file' do
      click_button 'read'
      expect(page).to have_content 'spec_read_file'
      page.save_screenshot('read click.png')
    end
  end

  describe '#user click on "read zip" button', :js => true do
    it 'page shoul have content from read_zip file' do
      click_button 'read-zip'
      expect(page).to have_content 'spec_read_zip'
      page.save_screenshot('read zip click.png')
    end
  end

  describe '#user click on "write" button', :js => true do
    it 'write file should contain content from tree' do
      click_button 'write'
      page.save_screenshot('write click.png')
=begin
      write_file_words = []
      File.open('files/write', 'r') { |file| file.each_line { |word| write_file_words << word.chomp } }
      expect(page).to have_content write_file_words
=end
    end
    it 'should nothing happens with page content when user click on "write" button' do
      click_button 'write'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_content 'new_word'
      expect(page).to have_content 'spec_read_file'
      expect(page).to have_content 'spec_read_zip'
      expect(page).to have_no_content 'fake content'
      page.save_screenshot('write click.png')
    end
    it 'should nothing happens with page content when user click on "write" button multiple times' do
      click_button 'write'
      click_button 'write'
      click_button 'write'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_content 'new_word'
      expect(page).to have_content 'spec_read_file'
      expect(page).to have_content 'spec_read_zip'
      expect(page).to have_no_content 'fake content'
      page.save_screenshot('write multiple click.png')
    end
  end

  describe '#user click on "write zip" button', :js => true do
    it 'write file should contain content from tree' do
      click_button 'write-zip'
      page.save_screenshot('write zip click.png')
=begin
      write_file_words = []
      File.open('files/write', 'r') { |file| file.each_line { |word| write_file_words << word.chomp } }
      expect(page).to have_content write_file_words
=end
    end
    it 'should nothing happens with page content when user click on "write zip" button' do
      click_button 'write-zip'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_content 'new_word'
      expect(page).to have_content 'spec_read_file'
      expect(page).to have_content 'spec_read_zip'
      expect(page).to have_no_content 'fake content'
      page.save_screenshot('write zip click.png')
    end
    it 'should nothing happens with page content when user click on "write zip" button multiple times' do
      click_button 'write-zip'
      click_button 'write-zip'
      click_button 'write-zip'
      expect(page).to have_content 'word'
      expect(page).to have_content 'grrrr'
      expect(page).to have_content 'beeee'
      expect(page).to have_content 'new_word'
      expect(page).to have_content 'spec_read_file'
      expect(page).to have_content 'spec_read_zip'
      expect(page).to have_no_content 'fake content'
      page.save_screenshot('write zip multiple click.png')
    end
  end
end
