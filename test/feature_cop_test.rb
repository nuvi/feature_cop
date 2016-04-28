require 'test_helper'

class FeatureCopTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::FeatureCop::VERSION
  end

  def test_features_can_be_enabled_created_using_env
    ENV["RANDOM_FEATURE"] = "enabled"
    assert FeatureCop.show_random?("SOME IDENTIFIER")
    assert FeatureCop.show_random_feature?("SOME IDENTIFIER")
  end

  def test_features_are_disabled_by_default
    refute FeatureCop.show_unspecified_feature?("SOME IDENTIFIER")
    refute FeatureCop.unspecified?("SOME IDENTIFIER")
  end

  def test_features_can_be_set_as_white_list
    ENV["WHITELIST_FEATURE"] = "whitelist"
    assert FeatureCop.show_whitelist_feature?("SOME IDENTIFIER")
    assert FeatureCop.whitelist?("SOME IDENTIFIER")
  end

  def test_features_can_be_set_as_sample10
    ENV["SAMPLE10_FEATURE"] = "sample10"
    assert FeatureCop.show_sample10_feature?("d")
    assert FeatureCop.show_sample10_feature?("d")

    refute FeatureCop.show_sample10_feature?("a")
    refute FeatureCop.show_sample10_feature?("a")
  end

  def test_features_can_be_set_as_sample25
    ENV["SAMPLE25_FEATURE"] = "sample25"
    assert FeatureCop.show_sample25_feature?("d")
    assert FeatureCop.show_sample25_feature?("d")

    refute FeatureCop.show_sample25_feature?("a")
    refute FeatureCop.show_sample25_feature?("a")
  end

  def test_features_can_be_set_as_sample50
    ENV["SAMPLE50_FEATURE"] = "sample50"
    assert FeatureCop.show_sample50_feature?("d")
    assert FeatureCop.show_sample50_feature?("d")


    refute FeatureCop.show_sample50_feature?("a")
    refute FeatureCop.show_sample50_feature?("a")
  end

  def test_parses_features_by_convention
    ENV["TEST_FEATURE"] = "enabled"
    FeatureCop.reset_features
    assert_equal FeatureCop.features["TEST_FEATURE"], "enabled"
    assert_nil FeatureCop.features["SOME_KEY"]
  end

  def test_to_json
    ENV["JSON_FEATURE"] = "sample50"
    FeatureCop.reset_features
    assert FeatureCop.to_json("d").include?("\"JSON_FEATURE\":true")
  end

end
