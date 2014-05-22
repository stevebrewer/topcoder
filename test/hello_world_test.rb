require "helper"

class HelloWorldTest < Topcoder::TestCase

  def setup
    @dumby = Dumby.new
  end

  def test_test
    assert @dumby.run, "Dumby should return true"
  end
end