# FeatureCop

Feature cop is a simple feature toggling system for Ruby. All features are configured in the ENV, following the guidelines of a [12-Factor App](http://12factor.net/config)

## Installation

Using Bundler

```ruby
gem 'feature_cop'

```
Or install it yourself as:

    $ gem install feature_cop


## Basic Usage - Ruby

Add a features to your ENV

```
MY_COOL_FEATURE = enabled
LOGIN_V2_FEATURE = disabled
```

NOTE:
Adding key values pairs to your ENV can be done in a number of ways. The above way is using .env file in conjuction with the [dot-env gem](https://github.com/bkeepers/dotenv)


## Use FeatureCop.allows? in your ruby code

```ruby

if FeatureCop.allows?(:my_cool_feature)
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




## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/feature_cop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

