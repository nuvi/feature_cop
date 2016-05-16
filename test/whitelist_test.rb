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
    FeatureCop.whitelist_from_yaml(File.join(__dir__, "sample_access_list.yml"))
    assert FeatureCop.whitelist.include?("user_1")
  end

end
