# FeatureCop

FeatureCop is a simple feature toggling system for Ruby. It provides progressive roll out of features. A common (and my opinion, bad) practice is for developers to use branching as feature control.  Feature Branching leads to large pull requests, messy merges, and long integration cycles.  With continous integration and feature toggling everyone can make small, short lived branches off the mainline, continually merge code, and get code in production, even when it isn't ready for launch. 

The following roll out strategies is available:

1. **disabled** - during development, a feature can be completely disabled so it isn't seen or executed.
2. **whitelist_only** - features can be turned on for specific users or groups.
3. **sample10** - feature is enabled for roughly 10% of users
4. **sample30** - feature is enabled for rougly 30% of users
5. **sample50** - feature is enabled for rougly 50% of users
6. **all_except_blacklist** - feature is enabled for everyone except a specified list of customers.  These customers could be enterprise clients that must be notified before enabling new features, etc.
6. **enabled** - enabled for all customers.  At this point it is recommended to remove the feature flag from the system since the roll out is complete.


## Installation

Using Bundler

```ruby
gem 'feature_cop'

```
Or install it yourself as:

    $ gem install feature_cop


## Basic Usage - Ruby

Features are configured in your applications ENV per [12-Factor App](http://12factor.net/config) guidelines.

```
MY_COOL_FEATURE = enabled
LOGIN_V2_FEATURE = disabled
```

NOTE:
Adding key values pairs to your ENV can be done in a number of ways. The above way is using .env file in conjuction with the [dot-env gem](https://github.com/bkeepers/dotenv)


Use FeatureCop.allows? in your ruby code

```ruby

if FeatureCop.allows?(:my_cool_feature)
   # execute new feature code
else
   # execute old feature code
end
```

You can also pass a string identifier to FeatureCop.  Identifiers can be anything but are typicall a user_id or a group_id.  Identifiers are used for the whitelist, sample10, sample30, sample50, and blacklist feature types.

```ruby

if FeatureCop.allows?(:my_cool_feature, "USERID_123")
   # execute new feature code
else
   # execute old feature code
end
```

## Basic Usage - Javascript

To use features in client side javascript, use  the ```FeatureCop.to_json``` helper.  This creates a JSON representation of the features so they can be sent to the client.  

Notice: Feature names are converted to camelcase.  Also, values are converted to boolean values.

```
FeatureCop.to_json
#=>
{

  "myCoolFeature"     : true
  "loginV1Feature"    : false
   "menubarV3Feature" : true
}

```

You can pass an identifier to the to_json method and it will output the correct feature values for that identifier.

```
FeatureCop.to_json("USERID_1234")
#=>
{

  "myCoolFeature"     : true
  "loginV1Feature"    : false
   "menubarV3Feature" : true
}

```

Because javascript patterns & frameworks vary wildly and change often, we have opted not to provide any furtuer javascript helpers.  The easiset way to use FeatureCop in your client side is to get features into window.env, then you can use simple if statements to control features.

```javascript
 if(window.env.features.myCoolFeature === true) {
   // execute new feature code
 }else
 {
   // execute new feature code
 }
```

Boom! Now you have feature flags!

For more advanced usage, [see our wiki](https://github.com/nuvi/feature_cop/wiki)!




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/feature_cop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

