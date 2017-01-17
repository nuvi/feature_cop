require 'test_helper'

class BlacklistTest < Minitest::Test
  def test_blacklisted_features_are_false_when_they_are_in_the_black_list
    ENV["BLACKLIST_FEATURE"] = "all_except_blacklist"
    FeatureCop.reset_features
    assert FeatureCop.allows?(:blacklist_feature, "BAD GUY")

    FeatureCop.blacklist = ["BAD GUY"] 
    refute FeatureCop.allows?(:blacklist_feature, "BAD GUY")
    assert FeatureCop.allows?(:blacklist_feature, "GOOD_GUY")
  end

  def test_sample_features_are_exclude_blacklist_users
    ENV["SAMPLE10_FEATURE"] = "sample10"
    ENV["SAMPLE30_FEATURE"] = "sample30"
    ENV["SAMPLE50_FEATURE"] = "sample50"
    FeatureCop.reset_features

    FeatureCop.blacklist = ["BAD_GUY"] 

    refute FeatureCop.allows?(:sample10_feature, "BAD_GUY")
    refute FeatureCop.allows?(:sample30_feature, "BAD_GUY")
    refute FeatureCop.allows?(:sample50_feature, "BAD_GUY")
  end

  def test_blacklist_can_be_configured_from_yml
    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.blacklist_from_yaml(File.join(current_directory, "sample_access_list.yml"))
    assert FeatureCop.blacklist["default"].include?("user_1")
  end

  def test_blacklist_can_be_configured_from_yml_with_custom_path
    ENV["SAMPLE10_FEATURE"] = "sample10"
    FeatureCop.reset_features
    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.blacklist_from_yaml(File.join(current_directory, "sample_access_list.yml"))
    assert FeatureCop.blacklist["default"].include?("user_1")
    refute FeatureCop.allows?(:sample10_feature, "user_1")
  end


  def test_blacklist_configuration_can_include_multiple_features
    ENV["FEATURE1_FEATURE"] = "all_except_blacklist"
    ENV["FEATURE2_FEATURE"] = "all_except_blacklist"
    FeatureCop.reset_features

    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.blacklist_from_yaml(File.join(current_directory, "sample_tiered_access_list.yml"))

    refute FeatureCop.allows?(:feature1_feature, "user_1")
    refute FeatureCop.allows?(:feature1_feature, "user_2")
    refute FeatureCop.allows?(:feature2_feature, "user_3")
    refute FeatureCop.allows?(:feature2_feature, "user_4")
  end
end
