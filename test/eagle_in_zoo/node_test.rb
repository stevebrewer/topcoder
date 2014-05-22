require "helper"

class BuildTreeTest < Topcoder::TestCase

  def test_create_tree_from_parents
    nodes = EagleInZoo::Node.from_parents [0, 1, 0, 3]
    assert nil != nodes, "should return a set of nodes"
    assert_equal nodes[0].children.length, 2, "Root node should have two children"
    assert nodes[0].children.include?(nodes[1]), "Root node should have node 1 as a child"
  end

  def test_empy_possible_states
    node = EagleInZoo::Node.new 0

    possible_states = node.possible_future_states_given []

    assert_equal possible_states.size, 1, "Should have one new state"
    assert_equal possible_states.first, Set.new([0]), "Only state is root node occupied"
  end
end