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
    # Returns a list of the nodes in the order they are created
    # => the first node is always the root
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

    # a state is set with the id of each node where an eagle is sitting.
    # given this set of states the tree could possibly be in, figure out
    # all the possible states the tree could end up in after a new bird 
    # flies out to the tree, and the number of times the bird flys away 
    # without landing
    def possible_future_states_given states
      return [Set.new([self.id])], 0 if states.nil? || states.empty?
      new_states = []
      fly_away = 0
      states.each do |state|
        s, f = self.possible_future_state_given_state(state)
        fly_away = fly_away + f
        new_states = new_states + s
      end
      return new_states, fly_away
    end

    def possible_future_state_given_state state
      new_states = []
      fly_away = 0
      if state.include?(self.id)
        if children.empty?
          # end of the branch - eagle flies away
          new_states << state.clone
          fly_away = 1
        else
          children.each do |child|
            child_states, child_fly_aways = child.possible_future_state_given_state(state)
            child_states.each{|new_state| new_states << new_state}
            fly_away = fly_away + child_fly_aways
          end
        end
      else
        # this node isn't occupied, bird lands here, that's it
        new_states << state.clone.add(self.id)
      end
      return new_states, fly_away
    end
  end
end