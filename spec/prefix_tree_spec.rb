require 'spec_helper'
require 'rspec/expectations'
require 'zip'

RSpec.describe '#prefix_tree' do

  before do
    @tree = Tree.new
    @tree.add('testtree')
    @tree.add('testtabdh')
    @tree.add('someone')
  end

  describe '#add' do
    it 'add the word to the tree' do
      @tree.add('something')
      expect(@tree.include?('something')).to eq(true)
    end
    it '"add" method return nil if he take NO parameter' do
      expect(@tree.add).to eq(nil)
    end
  end

  describe '#include?' do
    it 'the tree include the words that user added?' do
      expect(@tree.include?('testtree')).to eq(true)
      expect(@tree.include?('testtre')).to eq(false)
    end
    it 'the tree include the words that was added from read file?' do
      @tree.read_file('spec/files/read')
      expect(@tree.include?('spec_read_file')).to eq(true)
      expect(@tree.include?('testing_readd_zip')).to eq(false)
    end
    it '"include?" return false if he take NO paramether?' do
      expect(@tree.include?).to eq(false)
    end
  end

  describe '#list' do
    it 'list all the words with specified prefix' do
      expect(@tree.list('testt1')).to eq([])
      expect(@tree.list('testt').sort).to eq(['testtabdh', 'testtree'].sort)
    end
    it 'list all the words' do
      expect(@tree.list.sort).to eq( ["testtree", "testtabdh", "someone"].sort)
    end
    it 'list unexisting words with specified prefix' do
      expect(@tree.list('yr')).to eq([])
    end
  end

  describe '#write file' do
    it "write words in the file" do
      expect(@tree.write_file('spec/files/write')).to eq(nil)
    end
    it "the file contain words from tree?" do
      words_arr = []
      File.open('spec/files/write', 'r') { |file| file.each_line { |word| words_arr << word.chomp } }
      expect(words_arr).to eq(@tree.list)
    end
  end

  describe '#write.zip file' do
    it "write words in the zip file" do
      expect(@tree.write_zip('spec/files/write.zip')).to eq(nil)
    end
    it "zip file contain words from tree?" do
      words_arr = []
      Zip::File.open('spec/files/write.zip') { |zip_f| zip_f.read('write').each_line { |word| words_arr << word.chomp } }
      expect(words_arr).to eq(@tree.list)
    end
  end

  describe '#read file' do
    it 'is the words from read file added to the tree?' do
      @tree.read_file('spec/files/read')
      expect(@tree.include?('spec_read_file')).to eq(true)
      expect(@tree.include?('testing_readd_file')).to eq(false)
    end
  end

  describe '#read.zip file' do
    it 'is the words from read.zip file added to the tree?' do
      @tree.read_zip('spec/files/read.zip')
      expect(@tree.include?('spec_read_zip')).to eq(true)
      expect(@tree.include?('testing_readd_zip')).to eq(false)
    end
  end
end
