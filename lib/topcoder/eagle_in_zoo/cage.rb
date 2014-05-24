module EagleInZoo
  class Cage
    attr_accessor :nodes, :root
    def initialize(parents)
      self.nodes = Node.from_parents parents
      self.root = nodes[0]
    end

    def probably_last_eagle_lands number_of_eagles
      return 1.0 if number_of_eagles <= 1

      state_cache = Hash.new {|hash, key| hash[key] = 0}
      states, total_fly_away = self.root.possible_future_states_given states
      state_cache[states.first] = 1
      (2..number_of_eagles).each do
        new_state_cache = Hash.new {|hash, key| hash[key] = 0}
        total_fly_away = 0
        state_cache.each do |state, count|
          states, fly_away = self.root.possible_future_state_given_state state
          total_fly_away = total_fly_away + fly_away * count
          states.each do |s|
            new_state_cache[s] = new_state_cache[s] + count
          end
        end
        state_cache = new_state_cache
      end

      1.0 -total_fly_away.to_f / state_cache.values.inject{|sum,x| sum + x }
    end

    def probably_last_eagle_lands_original number_of_eagles
      return 1.0 if number_of_eagles <= 1

      states = []
      fly_away = 0
      (1..number_of_eagles).each do
        states, fly_away = self.root.possible_future_states_given states
      end

      1.0 -fly_away.to_f / states.count
    end
  end
end
