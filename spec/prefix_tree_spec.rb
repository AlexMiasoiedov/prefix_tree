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
  end

  describe '#include?' do
    it 'word "testtree"' do
      expect(tree.include?('testtree')).to eq(true)
      expect(tree.include?('testtre')).to eq(false)
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
  end

  describe '#write' do
    it "is words were wtitte in write file?" do
      expect(tree.write_file('spec/test_files/write')).to eq(tree.list.each { |word| word + "\n" })
    end
    it "is words were wtitte in write zip file" do
      expect(tree.write_zip('spec/test_files/write.zip')).to eq(tree.list)
    end
  end

  describe '#read' do
    tree.read_file('spec/test_files/read')
    tree.read_zip('spec/test_files/read.zip')
    it 'is the words from read and read zip files in tree now?' do
      expect(tree.include?('testing_read_file')).to eq(true)
      expect(tree.include?('testing_read_zip')).to eq(true)
      expect(tree.include?('testing_readd_file')).to eq(false)
      expect(tree.include?('testing_readd_zip')).to eq(false)
    end
  end
end
