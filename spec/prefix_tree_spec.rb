require 'spec_helper'

require_relative '../lib/prefix_tree'

RSpec.describe do
  tree = Tree.new
  tree.add('testtree')
  tree.add('testtabdh')
  tree.add('someone')

  describe '#add' do
    it 'add the word to the tree' do
      tree.add('something')
      expect(tree.include?('something')).to eq(true)
    end
    it '"add" method return nil if he take NO parameter' do
      expect(tree.add).to eq(nil)
    end
  end

  describe '#include?' do
    it 'the tree include the words that user added?' do
      expect(tree.include?('testtree')).to eq(true)
      expect(tree.include?('testtre')).to eq(false)
    end
    it 'the tree include the words that was added from read file?' do
      tree.read_file
      expect(tree.include?('testing_read_file')).to eq(true)
      expect(tree.include?('testing_readd_zip')).to eq(false)
    end
    it '"include?" return false if he take NO paramether?' do
      expect(tree.include?).to eq(false)
    end
  end

  describe '#list' do
    it 'list all the words with specified prefix' do
      expect(tree.list('testt1')).to eq([])
      expect(tree.list('testt').sort).to eq(['testtabdh', 'testtree'].sort)
    end
    it 'list all the words' do
      expect(tree.list.sort).to eq( ["testtree", "testtabdh", "testing_read_file", "testing_read_zip", "someone", "something"].sort)
    end
    it 'list unexisting words with specified prefix' do
      expect(tree.list('yr')).to eq([])
    end
  end

  describe '#write file' do
    it "is words writed in the write file from tree?" do
      expect(tree.write_file('spec/test_files/write')).to eq(tree.list.each { |word| word + "\n" })
    end
  end
  describe '#write.zip file' do
    it " is words writed in the write zip file from tree?" do
      expect(tree.write_zip('spec/test_files/write.zip')).to eq(tree.list)
    end
  end

  describe '#read file' do
    tree.read_file('spec/test_files/read')
    it 'is the words from read file added to the tree?' do
      expect(tree.include?('testing_read_file')).to eq(true)
      expect(tree.include?('testing_readd_file')).to eq(false)
    end
  end

  describe '#read.zip file' do
    tree.read_zip('spec/test_files/read.zip')
    it 'is the words from read.zip file added to the tree?' do
      expect(tree.include?('testing_read_zip')).to eq(true)
      expect(tree.include?('testing_readd_zip')).to eq(false)
    end
  end
end
