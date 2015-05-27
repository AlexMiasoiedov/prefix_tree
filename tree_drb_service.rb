require 'drb'

require_relative 'lib/prefix_tree'

tree = Tree.new

DRb.start_service('druby://localhost:6000', tree)
DRb.thread.join