require 'test_helper'

class SamplingTest < Minitest::Test
  def test_sample10_features_are_true_for_roughly_ten_percent_of_users
    ENV["SAMPLE10_FEATURE"] = "sample10"

    true_count = 0

    1000.times do |count|
      true_count += 1 if FeatureCop.allows?(:sample10_feature, SecureRandom.hex)
    end

    assert  true_count  > 70, "Count: #{true_count} is less than 70"
    assert  true_count < 130, "Count: #{true_count} is greater than 130"
  end

  def test_sample30_features_are_true_for_roughty_thirty_percent_of_users
    ENV["SAMPLE30_FEATURE"] = "sample30"

    true_count = 0

    1000.times do |count|
      true_count += 1 if FeatureCop.allows?(:sample30_feature, SecureRandom.hex)
    end

    assert  true_count  > 240, "Count: #{true_count} is less than 240"
    assert  true_count  < 360, "Count: #{true_count} is greater than 360"
  end

  def test_sample50_features_are_true_for_roughly_50_percent_of_users
    ENV["SAMPLE50_FEATURE"] = "sample50"

    true_count = 0

    1000.times do |count|
      true_count += 1 if FeatureCop.allows?(:sample50_feature, SecureRandom.hex)
    end

    assert  true_count > 440
    assert  true_count < 560
  end

end
