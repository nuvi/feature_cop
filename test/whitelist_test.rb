require 'test_helper'

class WhitelistTest < Minitest::Test

  def test_whitelisted_features_are_true_when_they_are_in_the_white_list
    ENV["WHITELIST_FEATURE"] = "whitelist_only"
    FeatureCop.whitelist = []
    refute FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")

    FeatureCop.whitelist = ["GOOD_GUY"] 
    assert FeatureCop.allows?(:whitelist_feature, "GOOD_GUY")
  end

  def test_sample_features_are_include_whitelisted_users
    ENV["SAMPLE10_FEATURE"] = "sample10"
    ENV["SAMPLE30_FEATURE"] = "sample30"
    ENV["SAMPLE50_FEATURE"] = "sample50"

    FeatureCop.whitelist = ["GOOD_GUY"] 

    assert FeatureCop.allows?(:sample10_feature, "GOOD_GUY")
    assert FeatureCop.allows?(:sample30_feature, "GOOD_GUY")
    assert FeatureCop.allows?(:sample50_feature, "GOOD_GUY")
  end


  def test_whitelist_can_be_configured_from_yml_with_custom_path
    ENV["SAMPLE10_FEATURE"] = "sample10"
    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.whitelist_from_yaml(File.join(current_directory, "sample_access_list.yml"))
    assert FeatureCop.whitelist["default"].include?("user_1")
    assert FeatureCop.allows?(:sample10_feature, "user_1")
  end


  def test_whitelist_configuration_can_include_multiple_features
    ENV["FEATURE1"] = "whitelist_only"
    ENV["FEATURE2"] = "whitelist_only"

    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.whitelist_from_yaml(File.join(current_directory, "sample_tiered_access_list.yml"))

    assert FeatureCop.allows?(:feature1, "user_1")
    assert FeatureCop.allows?(:feature1, "user_2")
    assert FeatureCop.allows?(:feature2, "user_3")
    assert FeatureCop.allows?(:feature2, "user_4")
  end

end
