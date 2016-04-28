require 'test_helper'

class FeatureBoardTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::FeatureBoard::VERSION
  end

  def test_features_can_be_enabled_created_using_env
    ENV["RANDOM_FEATURE"] = "enabled"
    assert FeatureBoard.show_random?("SOME IDENTIFIER")
    assert FeatureBoard.show_random_feature?("SOME IDENTIFIER")
  end

  def test_features_are_disabled_by_default
    refute FeatureBoard.show_unspecified_feature?("SOME IDENTIFIER")
    refute FeatureBoard.unspecified?("SOME IDENTIFIER")
  end

  def test_features_can_be_set_as_white_list
    ENV["WHITELIST_FEATURE"] = "whitelist"
    assert FeatureBoard.show_whitelist_feature?("SOME IDENTIFIER")
    assert FeatureBoard.whitelist?("SOME IDENTIFIER")
  end

  def test_features_can_be_set_as_sample10
    ENV["SAMPLE10_FEATURE"] = "sample10"
    assert FeatureBoard.show_sample10_feature?("d")
    assert FeatureBoard.show_sample10_feature?("d")

    refute FeatureBoard.show_sample10_feature?("a")
    refute FeatureBoard.show_sample10_feature?("a")
  end

  def test_features_can_be_set_as_sample25
    ENV["SAMPLE25_FEATURE"] = "sample25"
    assert FeatureBoard.show_sample25_feature?("d")
    assert FeatureBoard.show_sample25_feature?("d")

    refute FeatureBoard.show_sample25_feature?("a")
    refute FeatureBoard.show_sample25_feature?("a")
  end

  def test_features_can_be_set_as_sample50
    ENV["SAMPLE50_FEATURE"] = "sample50"
    assert FeatureBoard.show_sample50_feature?("d")
    assert FeatureBoard.show_sample50_feature?("d")


    refute FeatureBoard.show_sample50_feature?("a")
    refute FeatureBoard.show_sample50_feature?("a")
  end

  def test_parses_features_by_convention
    ENV["TEST_FEATURE"] = "enabled"
    FeatureBoard.reset_features
    assert_equal FeatureBoard.features["TEST_FEATURE"], "enabled"
    assert_nil FeatureBoard.features["SOME_KEY"]
  end

  def test_to_json
    ENV["JSON_FEATURE"] = "sample50"
    FeatureBoard.reset_features
    assert FeatureBoard.to_json("d").include?("\"JSON_FEATURE\":true")
  end

end
