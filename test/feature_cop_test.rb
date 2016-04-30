require 'test_helper'

class FeatureCopTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::FeatureCop::VERSION
  end

  def test_enabled_features_are_always_true
    ENV["RANDOM_FEATURE"] = "enabled"
    assert FeatureCop.allows?(:random_feature, "SOME IDENTIFIER")
    assert FeatureCop.allows?(:random_feature)
  end

  def test_disabled_features_are_always_false
    ENV["RANDOM_FEATURE"] = "disabled"
    refute FeatureCop.allows?(:random_feature, "SOME IDENTIFIER")
  end

  def test_unidentified_features_are_always_false
    refute FeatureCop.allows?(:unidentified_feature, "SOME IDENTIFIER")
  end

  def test_whitelisted_features_are_true_when_they_are_in_the_white_list
    ENV["WHITELIST_FEATURE"] = "whitelist_only"
    refute FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")

    FeatureCop.whitelist = ["GOOD_GUY"] 
    assert FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")
  end

  def test_blacklisted_features_are_true_when_they_are_not_in_the_white_list
    ENV["BLACKLIST_FEATURE"] = "all_except_blacklist"
    assert FeatureCop.allows?(:blacklist_feature, "BAD GUY")

    FeatureCop.blacklist = ["BAD GUY"] 
    refute FeatureCop.allows?(:blacklist_feature, "BAD GUY")
  end

  def test_sample10_features_are_true_1_out_10_times
    ENV["SAMPLE10_FEATURE"] = "sample10"
    assert FeatureCop.allows?(:sample10_feature, "d")
    refute FeatureCop.allows?(:sample10_feature, "a")
  end

  def test_sample30_features_are_true_1_out_4_times
    ENV["SAMPLE30_FEATURE"] = "sample30"
    assert FeatureCop.allows?(:sample30_feature, "c")
    refute FeatureCop.allows?(:sample30_feature, "a")
  end

  def test_sample50_features_are_true_1_out_2_times
    ENV["SAMPLE50_FEATURE"] = "sample50"
    assert FeatureCop.allows?(:sample50_feature, "c")
    refute FeatureCop.allows?(:sample50_feature, "b")
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
    FeatureCop.to_json("d").include?("\"jsonFeature\":true")
  end

  def test_whitelist_can_be_configured_from_yml_with_custom_path
    FeatureCop.whitelist_from_yaml(File.join(__dir__, "sample_access_list.yml"))
    assert FeatureCop.whitelist.include?("user_1")
  end

  def test_blacklist_can_be_configured_from_yml
    FeatureCop.blacklist_from_yaml(File.join(__dir__, "sample_access_list.yml"))
    assert FeatureCop.blacklist.include?("user_1")
  end
end
