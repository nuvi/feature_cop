# FeatureCop

Feature cop is a simple feature toggling system for Ruby. All features are configured in the ENV, following the guidelines of a [12-Factor App](http://12factor.net/config)

## Basic Usage - Ruby

#### Step 1 - Add a features to your ENV

```
MY_COOL_FEATURE = enabled
LOGIN_V2_FEATURE = disabled
MENUBAR_V3_FEATURE = sample10

```

NOTE:
Adding key values pairs to your ENV can be done in a number of ways. The above way is using .env file in conjuction with the [dot-env gem](https://github.com/bkeepers/dotenv)


#### Step 2 - Start using Feature Cop

```ruby

if FeatureCop.allows?(:my_cool_feature)
   # execute new feature code
else
   # execute old feature code
end
```


## Basic Usage - Javascript

If you want use your feature flags in your client side javascript, you can call ```FeatureCop.to_json```.  This will serialize all of the feature flag values to json so they can be sent to the client.  Notice that it inflects the names to make them javascript friendly.  Also, it simply puts assigns the value of the boolean value to that you don't have to do any string comparison in your client side code.  You can simply check to see if you should show the feature or not.

```
FeatureCop.to_json
#=>
{

  "myCoolFeature"     : true
  "loginV1Feature"    : false
   "menubarV3Feature" : true
}

```

Boom! Now you have feature flags!


## Installation

Using Bundler

```ruby
gem 'feature_cop'

```

Or install it yourself as:

    $ gem install feature_cop



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/feature_cop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

