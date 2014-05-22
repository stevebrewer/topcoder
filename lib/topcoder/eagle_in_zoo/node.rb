module EagleInZoo
  class Node
    attr_accessor :children, :has_eagle

    def initialize
      self.children = []
    end

    # Takes a list of parent indexes
    # [0, 1, 0, 3]
    #   Tree with 5 nodes (Root is implied as 0).
    #   Node 1's parent is the root
    #   Node 2's parent is node 1, etc
    #         0
    #       1    3
    #       2    4 
    # 
    # Returns a list of the nodes
    def self.from_parents list_of_parents
      root = Node.new
      nodes = [root]
      (list_of_parents || []).each_with_index do |parent, i|
        child = Node.new
        parent = nodes[parent]
        parent.children << child
        nodes << child
      end
      nodes
    end
  end
end