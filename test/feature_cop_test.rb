require 'test_helper'

class FeatureCopTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::FeatureCop::VERSION
  end

  def test_features_are_taken_from_env
    ENV["TEST_FEATURE"] = "enabled"
    FeatureCop.reset_features
    assert_equal FeatureCop.features["test_feature"], "enabled"
    assert_nil FeatureCop.features["SOME_KEY"]
  end

  def test_features_match_as_json_and_allows?
    ENV["JSON_FEATURE"] = "whitelist_only"
    FeatureCop.reset_features

    whitelist_yaml = { "json_feature" => "TESTING_ATTENTION_PLEASE" }
    FeatureCop.whitelist = whitelist_yaml

    assert FeatureCop.allows?(:json_feature, "TESTING_ATTENTION_PLEASE")
    assert FeatureCop.as_json("TESTING_ATTENTION_PLEASE")["jsonFeature"]
  end

  def test_features_can_be_converted_to_json
    ENV["JSON_FEATURE"] = "sample50"
    FeatureCop.reset_features
    refute FeatureCop.as_json("d")['jsonFeature']
  end

  def test_features_can_be_converted_to_json
    ENV["JSON_FEATURE"] = "sample50"
    FeatureCop.reset_features
    assert FeatureCop.to_json("d").include?("\"jsonFeature\":false")
  end
end
