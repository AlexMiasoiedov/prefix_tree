require 'drb'

tree = DRbObject.new_with_uri('druby://localhost:6000')
tree.add('DRbServer')
tree.add('working')
tree.add('good')
p tree.list
