require 'spec_helper'

require_relative '../lib/tree'

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
			expected = true
      expect(tree.include?('testtree')).to eq(expected)
    end
  end

  describe 'write' do
    it 'file' do
      expected = true
      tree.write_file('../test/test_files/write')
      expect(tree.read_file('../test/test_files/write')).to eq(expected)
    end
  end
end
