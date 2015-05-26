require 'spec_helper'

require_relative '../lib/tree'

#require 'debugger'

RSpec.describe do
  tree = Tree.new
  tree.add('testtree')

  describe 'add' do
    it 'the word' do
      expected = true
      tree.add('something')
      expect(tree.include?('something')).to eq(expected)
    end
  end

  describe 'include' do
    it 'word "testtree"' do
      expect(tree.include?('testtree')).to eq(true)
    end
  end
  #debugger
  describe 'write and read' do
    it 'file' do
      tree.write_file('spec/test_files/write')
      expect(tree.read_file('spec/test_files/write')).to eq(tree.list)
    end
  end

  describe 'write and read zip' do
    it 'file' do
      tree.write_zip('spec/test_files/write.zip')
      expect(tree.read_zip('spec/test_files/write.zip', 'write').split("\n")).to eq(tree.list)
    end
  end

  describe "write file" do
    it "readable" do
      expect(File.readable?('spec/test_files/write')).to eq(true)
    end
  end
end
