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
      puts 'match found'
      return self
    else
      if left
        puts 'headed left'
      elsif right
        puts 'headed right'
      else
        puts 'dead end'
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
        puts 'match found'
        return current_node
      end
      nodes << current_node.left if current_node.left
      nodes << current_node.right if current_node.right
    end
    nil
  end

  private

  def validate_node!(node)
    unless valid_node?(node)
      raise ArgumentError, 'Argument is not a BinaryTreeNode'
    end
  end
end
