require "simplecov"
SimpleCov.start

require 'minitest/autorun'

require_relative '../lib/tree'

class TestTree < Minitest::Test
  def setup
    @tree = Tree.new
  end

  def test_add_to_tree
    assert_equal true, @tree.add('test_add')
  end

  def test_include
    assert_equal false, @tree.include?('something')
  end

  def test_list
    @tree.add('test')
    assert_equal [], @tree.list
  end

  def test_write_file
    @tree.add('ad')
    assert_equal true, @tree.include?('ad')
    refute_match true, @tree.include?('abc')
  end

  def test_read_file
    @tree.read_file
    assert_equal true, @tree.include?('read')
  end

  def test_write_zip_file
    @tree.add('ad')
    assert_equal true, @tree.include?('ad')
    refute_match true, @tree.include?('abc')
  end

  def test_read_zip_file
    @tree.read_zip
    assert_equal true, @tree.include?('read_zip')
  end
end
