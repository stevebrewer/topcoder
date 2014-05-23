require 'set'
module EagleInZoo
  class Node
    attr_accessor :children, :has_eagle, :id

    def initialize(id)
      self.id = id
      self.children = []
      self.has_eagle = false
      @cache = {}
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
    # in them.
    # return the new states, and the number of times the bird flew away
    def possible_future_states_given states
      return [Set.new([self.id])], 1.0 if states.empty?
      new_states = []
      fly_away = 0
      states.each do |state|
        state.possible_future_state_given_state(state).tap do |s, f|
          fly_away = fly_away + f
          states = states + s
        end
      end
      return new_states, fly_away
    end

    def possible_future_state_given_state state
      return @cache[state] if @cache.try(:has_key?, state)

      new_states = []
      fly_away = 0
      if state.include?(self.id)
        if children.empty?
          # end of the branch - eagle flies away
          new_states << state.clone
          fly_away = 1
        else
          children.each do |child|
            child_states, child_fly_aways = child.possible_future_states_given_state(state)
            child_states.each{|new_state| new_states << new_state}
            fly_away = fly_away + child_fly_aways
          end
        end
      else
        # this node isn't occupied, bird lands here, that's it
        new_states << state.clone.add(self.id)
      end
      @cache.try(:[]=, state, [new_states, fly_away])
      return new_states, fly_away
    end
  end
end