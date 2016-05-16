require 'test_helper'

class ToggleTest < Minitest::Test

  def test_enabled_features_are_always_true
    ENV["RANDOM_FEATURE"] = "enabled"
    assert FeatureCop.allows?(:random_feature, "SOME IDENTIFIER")
    assert FeatureCop.allows?(:random_feature)
  end

  def test_disabled_features_are_always_false
    ENV["RANDOM_FEATURE"] = "disabled"
    refute FeatureCop.allows?(:random_feature, "SOME IDENTIFIER")
  end
end
