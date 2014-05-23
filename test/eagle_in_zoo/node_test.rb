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

    possible_states, a = node.possible_future_states_given []

    assert_equal possible_states.size, 1, "Should have one new state"
    assert_equal possible_states.first, Set.new([0]), "Only state is root node occupied"
  end

  def test_possible_states
    nodes = EagleInZoo::Node.from_parents [0, 1, 0, 3]
    root = nodes[0]

    new_states, a = root.possible_future_states_given [Set.new([0])]
    assert_equal new_states.size, 2, "Two possible states"
    assert new_states.include?(Set.new([0, 1])), "Should include [0,1]"
    assert new_states.include?(Set.new([0, 3])), "Should include [0,3]"

    new_states, a = root.possible_future_states_given new_states
    assert_equal new_states.size, 4, "4 possible states"
    assert new_states.include?(Set.new([0, 1, 3])), "Should include [0, 1, 3]"
    assert new_states.include?(Set.new([0, 1, 2])), "Should include [0, 1, 2]"
    assert new_states.include?(Set.new([0, 3, 1])), "Should include [0, 3, 1]"
    assert new_states.include?(Set.new([0, 3, 4])), "Should include [0, 3, 4]"

    new_states, a = root.possible_future_states_given new_states
    assert_equal new_states.size, 8, "Eight possible states"
    assert new_states.include?(Set.new([0, 1, 3, 2])), "Should include [0, 1, 3, 2]"
    assert new_states.include?(Set.new([0, 1, 3, 4])), "Should include [0, 1, 3, 4]"
    assert new_states.include?(Set.new([0, 1, 2])), "Should include [0, 1, 2]"
    assert new_states.include?(Set.new([0, 1, 2, 3])), "Should include [0, 1, 2, 3]"
    assert new_states.include?(Set.new([0, 3, 1, 2])), "Should include [0, 3, 1, 2]"
    assert new_states.include?(Set.new([0, 3, 1, 4])), "Should include [0, 3, 1, 4]"
    assert new_states.include?(Set.new([0, 3, 4])), "Should include [0, 3, 4]"
    assert new_states.include?(Set.new([0, 3, 4, 1])), "Should include [0, 3, 4, 1]"
  end
end