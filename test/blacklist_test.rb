require 'test_helper'

class BlacklistTest < Minitest::Test
  def test_blacklisted_features_are_false_when_they_are_in_the_black_list
    ENV["BLACKLIST_FEATURE"] = "all_except_blacklist"
    assert FeatureCop.allows?(:blacklist_feature, "BAD GUY")

    FeatureCop.blacklist = ["BAD GUY"] 
    refute FeatureCop.allows?(:blacklist_feature, "BAD GUY")
    assert FeatureCop.allows?(:blacklist_feature, "GOOD_GUY")
  end

  def test_sample_features_are_exclude_blacklist_users
    ENV["SAMPLE10_FEATURE"] = "sample10"
    ENV["SAMPLE30_FEATURE"] = "sample30"
    ENV["SAMPLE50_FEATURE"] = "sample50"

    FeatureCop.blacklist = ["BAD_GUY"] 

    refute FeatureCop.allows?(:sample10_feature, "BAD_GUY")
    refute FeatureCop.allows?(:sample30_feature, "BAD_GUY")
    refute FeatureCop.allows?(:sample50_feature, "BAD_GUY")
  end

  def test_blacklist_can_be_configured_from_yml
    current_directory = File.dirname(File.realpath(__FILE__))
    FeatureCop.blacklist_from_yaml(File.join(current_directory, "sample_access_list.yml"))
    assert FeatureCop.blacklist.include?("user_1")
  end
end
