require 'spec_helper'

require_relative '../lib/prefix_tree'

RSpec.describe do
  tree = Tree.new
  tree.add('testtree')
  tree.add('testtabdh')
  #tree.add('somone')

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
  end

  describe '#write' do
    it "file" do
      expect(tree.write_file('spec/test_files/write')).to eq(tree.list.each { |word| word << "\n" })
    end
    it "zip" do
      expect(tree.write_zip('spec/test_files/write.zip')).to eq(tree.list)
    end
  end

  describe '#read' do
    tree.read_file('spec/test_files/read')
    tree.read_zip('spec/test_files/read.zip')
    it 'file' do
      expect(tree.include?('read')).to eq(true)
      expect(tree.include?('read_zip')).to eq(true)
      expect(tree.include?('readd')).to eq(false)
    end
  end
end
