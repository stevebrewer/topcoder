require 'set'
module EagleInZoo
  class Node
    attr_accessor :children, :has_eagle, :id

    def initialize(id)
      self.id = id
      self.children = []
      self.has_eagle = false
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
      root = Node.new 0
      nodes = [root]
      (list_of_parents || []).each_with_index do |parent, i|
        child = Node.new i+1
        parent = nodes[parent]
        parent.children << child
        nodes << child
      end
      nodes
    end

    # states is a list of sets, each set represents a possible
    # state, where the numbers in the set are the nodes with eagle sitting
    # in them
    def possible_future_states_given states
      return [Set.new([self.id])] if states.empty?
      new_states = []
      states.each do |state|
        if state.include?(self.id)
          if children.empty?
            # end of the branch - eagle flies away
            new_states << state.clone
          else
            children.each do |child|
              child.possible_future_states_given([state]).each{|new_state| new_states << new_state}
            end
          end
        else
          # this node isn't occupied, bird lands here, that's it
          new_states << state.clone.add(self.id)
        end
      end
      new_states
    end
  end
end