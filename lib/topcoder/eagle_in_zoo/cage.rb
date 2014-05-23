module EagleInZoo
  class Cage
    attr_accessor :nodes, :root
    def initialize(parents)
      self.nodes = Node.from_parents parents
      self.root = nodes[0]
    end

    def probably_last_eagle_lands number_of_eagles
      return 1.0 if number_of_eagles <= 1

      states = []
      fly_away = 0
      (1..number_of_eagles).each do
        puts "calcing some eagles\n states: #{states.count}\n uniq: #{states.uniq.count}\n\n"
        states, fly_away = self.root.possible_future_states_given states
      end

      1.0 -fly_away.to_f / states.count
    end
  end
end
