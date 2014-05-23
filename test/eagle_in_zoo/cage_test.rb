require "helper"

class CageTest < Topcoder::TestCase

  def test_the_cage
    cage = EagleInZoo::Cage.new [0, 0]
    assert_equal cage.probably_last_eagle_lands(2), 1.0
    assert_equal cage.probably_last_eagle_lands(3), 0.5
    
    cage = EagleInZoo::Cage.new [0, 1, 0, 3]
    assert_equal cage.probably_last_eagle_lands(4), 0.75 
    
    cage = EagleInZoo::Cage.new [0,0,1,1,2,4,4,4,5,5,6,6]
    assert_equal cage.probably_last_eagle_lands(20), 0.14595168754091617
  end

end