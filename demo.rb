require_relative 'lib/binary_tree_node'

if __FILE__ == $0
  ENV['DEBUG'] = 'true'

  root = BinaryTreeNode.new(0)
  one = BinaryTreeNode.new(1)
  two = BinaryTreeNode.new(2)
  three = BinaryTreeNode.new(3)
  four = BinaryTreeNode.new(4)
  five = BinaryTreeNode.new(5)
  six = BinaryTreeNode.new(6)
  seven = BinaryTreeNode.new(7)

  root.left = one
  root.right = four

  one.left = two
  one.right = three

  two.left = seven

  four.left = five
  four.right = six

  puts 'depth-first search:'
  result = root.dfs(5)
  p result

  puts

  puts 'breadth-first search:'
  result = root.bfs(5)
  p result
end
