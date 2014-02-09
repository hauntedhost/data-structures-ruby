class BinaryTreeNode
  attr_reader :parent, :left, :right, :value

  def initialize(value)
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end

  def parent=(node)
    validate_node!(node)
    @parent = node
  end

  def left=(node)
    validate_node!(node)
    @left = node
    node.parent = self
  end

  def right=(node)
    validate_node!(node)
    @right = node
    node.parent = self
  end

  def valid_node?(node)
    node.is_a? BinaryTreeNode
  end

  def dfs(target_value)
    if ENV['DEBUG'] == 'true'
      return self.dfs_verbose(target_value)
    end

    return self if self.value == target_value
    (left && left.dfs(target_value)) || (right && right.dfs(target_value))
  end

  def bfs(target_value)
    if ENV['DEBUG'] == 'true'
      return self.bfs_verbose(target_value)
    end

    nodes = [self]
    while nodes.any?
      current_node = nodes.shift
      return current_node if current_node.value == target_value
      nodes << current_node.left if current_node.left
      nodes << current_node.right if current_node.right
    end
    nil
  end

  protected

  def dfs_verbose(target_value)
    puts "at #{self.value}"

    if self.value == target_value
      puts "match found"
      return self
    else
      if left
        puts "headed left"
      elsif right
        puts "headed right"
      else
        puts "dead end"
      end

      match = left.dfs_verbose(target_value) if left
      match = right.dfs_verbose(target_value) if right && match.nil?
      match
    end
  end

  def bfs_verbose(target_value)
    nodes = [self]
    while nodes.any?
      current_node = nodes.shift
      puts "at #{current_node.value}"
      if current_node.value == target_value
        puts "match found"
        return current_node
      end
      nodes << current_node.left if current_node.left
      nodes << current_node.right if current_node.right
    end
    nil
  end

  private

  def validate_node!(node)
    raise "ArgumentError", "Argument is not a BinaryTreeNode" unless valid_node?(node)
  end
end

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

  puts "depth-first search:"
  result = root.dfs(5)
  p result

  puts

  puts "breadth-first search:"
  result = root.bfs(5)
  p result
end
