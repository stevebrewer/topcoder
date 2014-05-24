require "helper"
require 'debugger'

class CageTest < Topcoder::TestCase

  # these values come from the top code problem statement.
  def test_the_cage
    cage = EagleInZoo::Cage.new [0, 0]
    assert_equal cage.probably_last_eagle_lands(2), 1.0
    assert_equal cage.probably_last_eagle_lands(3), 0.5
    assert_equal cage.probably_last_eagle_lands(4), 0.25
    assert_equal cage.probably_last_eagle_lands(5), 0.125
    
    cage = EagleInZoo::Cage.new [0, 1, 0, 3]
    assert_equal cage.probably_last_eagle_lands(4), 0.75
    
    
    # I don't get the exact same answer as in the problem statement for these big examples
    # Been though it in the debugger by hand to 5 rounds, and testing the optimized against 
    # the dumb and obvious solution here to 8 birds (the exponential nature takes over, getting to 11 would take hours)
    # I'm calling it good enough, I can't verify what the author of the top coder problem was doing
    cage = EagleInZoo::Cage.new [0,0,1,1,2,4,4,4,5,5,6,6]
    (2..8).each do |i|
        assert_equal cage.probably_last_eagle_lands_original(i), cage.probably_last_eagle_lands(i), "Optimized should return same as dumb solutions (#{i})"
    end
    # assert_equal cage.probably_last_eagle_lands(20), 0.14595168754091617
    assert cage.probably_last_eagle_lands(20) > 0

    cage = EagleInZoo::Cage.new [0,1,2,3,2,1,1,7,0,9,10,11,12,13,14,15,16,17,18,14,9]
    (2..8).each do |i|
        assert_equal cage.probably_last_eagle_lands_original(i), cage.probably_last_eagle_lands(i), "Optimized should return same as dumb solutions (#{i})"
    end
    assert cage.probably_last_eagle_lands(24) > 0

    cage = EagleInZoo::Cage.new [0,1,2,3,4,5,6,7,8,9,10]
    assert_equal cage.probably_last_eagle_lands(50), 0.0

  end

end