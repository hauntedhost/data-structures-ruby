require_relative '../lib/binary_tree_node.rb'

describe BinaryTreeNode do
  let(:root) { BinaryTreeNode.new(0) }
  let(:one) { BinaryTreeNode.new(1) }
  let(:two) { BinaryTreeNode.new(2) }
  let(:three) { BinaryTreeNode.new(3) }
  let(:four) { BinaryTreeNode.new(4) }
  let(:five) { BinaryTreeNode.new(5) }
  let(:six) { BinaryTreeNode.new(6) }
  let(:seven) { BinaryTreeNode.new(7) }

  describe 'child node assignment' do

    it '#left assigns a node' do
      root.left = one
      expect(root.left).to eq(one)
    end

    it '#right assigns a node' do
      root.right = two
      expect(root.right).to eq(two)
    end

    it 'raises an error if a non-node is assigned' do
      expect { root.left = 3 }.to raise_error(ArgumentError)
      expect { root.right = 7 }.to raise_error(ArgumentError)
    end
  end

  describe 'search methods' do
    before(:each) do
      root.left = one
      root.right = four
      one.left = two
      one.right = three
      two.left = seven
      four.left = five
      four.right = six
    end

    describe '#dfs' do
      it 'searches for a value depth-first' do
        expect(root).to receive(:dfs).ordered.and_call_original
        expect(one).to receive(:dfs).ordered.and_call_original
        expect(two).to receive(:dfs).ordered.and_call_original
        expect(seven).to receive(:dfs).ordered.and_call_original
        expect(three).to receive(:dfs).ordered.and_call_original
        expect(four).to receive(:dfs).ordered.and_call_original
        expect(six).not_to receive(:dfs)
        root.dfs(5)
      end

      it 'returns first node with matching value' do
        expect(root.dfs(5)).to be(five)
      end

      it 'returns nil if no matches' do
        expect(root.dfs(155)).to be(nil)
      end
    end

    describe '#bfs' do
      it 'searches for a value breadth-first' do
        expect(root).to receive(:bfs).ordered.and_call_original
        expect(root).to receive(:left).ordered.at_least(:once).and_call_original
        expect(root).to receive(:right).ordered.at_least(:once).and_call_original
        expect(one).to receive(:left).ordered.at_least(:once).and_call_original
        expect(one).to receive(:right).ordered.at_least(:once).and_call_original
        expect(four).to receive(:left).ordered.at_least(:once).and_call_original
        expect(four).to receive(:right).ordered.at_least(:once).and_call_original
        expect(two).to receive(:left).ordered.at_least(:once).and_call_original
        expect(two).to receive(:right).ordered.at_least(:once).and_call_original
        expect(three).to receive(:left).ordered.at_least(:once).and_call_original
        expect(three).to receive(:right).ordered.at_least(:once).and_call_original
        expect(five).not_to receive(:left).and_call_original
        expect(five).not_to receive(:right).and_call_original
        expect(six).not_to receive(:left).and_call_original
        expect(six).not_to receive(:right).and_call_original
        expect(seven).not_to receive(:left).and_call_original
        expect(seven).not_to receive(:right).and_call_original
        root.bfs(5)
      end

      it 'returns first node with matching value' do
        expect(root.bfs(5)).to be(five)
      end

      it 'returns nil if no matches' do
        expect(root.bfs(155)).to be(nil)
      end
    end
  end
end
