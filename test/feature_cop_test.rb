require 'test_helper'

class FeatureCopTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::FeatureCop::VERSION
  end

  def test_enabled_features_are_always_true
    ENV["RANDOM_FEATURE"] = "enabled"
    assert FeatureCop.allows?(:random_feature, "SOME IDENTIFIER")
  end

  def test_unidentified_features_are_always_false
    refute FeatureCop.allows?(:unidentified_feature, "SOME IDENTIFIER")
  end

  def test_whitelisted_features_are_true_when_they_are_in_the_white_list
    ENV["WHITELIST_FEATURE"] = "whitelist"
    refute FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")

    FeatureCop.whitelist = ["GOOD_GUY"] 
    assert FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")
  end

  def test_blacklisted_features_are_true_when_they_are_not_in_the_white_list
    ENV["BLACKLIST_FEATURE"] = "blacklist"
    assert FeatureCop.allows?(:blacklist_feature, "BAD GUY")

    FeatureCop.blacklist = ["BAD GUY"] 
    refute FeatureCop.allows?(:blacklist_feature, "BAD GUY")
  end

  def test_sample10_features_are_true_1_out_10_times
    ENV["SAMPLE10_FEATURE"] = "sample10"
    assert FeatureCop.allows?(:sample10_feature, "d")
    refute FeatureCop.allows?(:sample10_feature, "a")
  end

  def test_sample25_features_are_true_1_out_4_times
    ENV["SAMPLE25_FEATURE"] = "sample25"
    assert FeatureCop.allows?(:sample25_feature, "d")
    refute FeatureCop.allows?(:sample25_feature, "a")
  end

  def test_sample50_features_are_true_1_out_2_times
    ENV["SAMPLE50_FEATURE"] = "sample50"
    assert FeatureCop.allows?(:sample50_feature, "d")
    refute FeatureCop.allows?(:sample50_feature, "a")
  end

  def test_features_are_taken_from_env
    ENV["TEST_FEATURE"] = "enabled"
    FeatureCop.reset_features
    assert_equal FeatureCop.features["TEST_FEATURE"], "enabled"
    assert_nil FeatureCop.features["SOME_KEY"]
  end

  def test_features_can_be_converted_to_json
    ENV["JSON_FEATURE"] = "sample50"
    FeatureCop.reset_features
    assert FeatureCop.to_json("d").include?("\"JSON_FEATURE\":true")
  end

  def test_whitelist_can_be_configured_from_yml
    FeatureCop.whitelist_from_yaml(File.join(__dir__, "sample_feature_cop.yml"))
    assert FeatureCop.whitelist("user_1")
  end


  def test_blacklist_can_be_configured_from_yml
    FeatureCop.blacklist_from_yaml(File.join(__dir__, "sample_feature_cop.yml"))
    refute FeatureCop.blacklist("user_1")
  end

end
