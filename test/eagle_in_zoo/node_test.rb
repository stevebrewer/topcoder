require "helper"

class BuildTreeTest < Topcoder::TestCase

  def test_create_tree_from_parents
    nodes = EagleInZoo::Node.from_parents [0, 1, 0, 3]
    assert nil != nodes, "should return a set of nodes"
    assert_equal nodes[0].children.length, 2, "Root node should have two children"
    assert nodes[0].children.include?(nodes[1]), "Root node should have node 1 as a child"
  end
end