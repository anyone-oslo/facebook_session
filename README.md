# FacebookSession [![Build Status](https://travis-ci.org/manualdesign/facebook_session.svg?branch=master)](https://travis-ci.org/manualdesign/facebook_session) [![Code Climate](https://codeclimate.com/github/manualdesign/facebook_session/badges/gpa.svg)](https://codeclimate.com/github/manualdesign/facebook_session) [![Test Coverage](https://codeclimate.com/github/manualdesign/facebook_session/badges/coverage.svg)](https://codeclimate.com/github/manualdesign/facebook_session)

FacebookSession is a simple Rails plugin that complements the Facebook
Javascript SDK. It is capable of loading the API, handling Facebook
logins and parsing signed requests.

## Installation

Add it to your Gemfile and run `bundle install`:

```ruby
gem 'facebook_session'
```

Then run the generator:

```
rails g facebook_session:install
```

## Configuration

The default configuration relies on two environment variables being
set, `FACEBOOK_APPLICATION_ID` and `FACEBOOK_APPLICATION_SECRET`.

If you'd like, you can configure these directly in
config/initializers/facebook_session.rb:

```ruby
FacebookSession.configure(
  application_id:     '12345678',
  application_secret: 'myapplication_secret'
)
```

## Loading the Facebook SDK

Requiring `facebook_session` in your assets pipeline will
automatically load the Facebook JS SDK asynchronously. It will also
make sure it works between page loads if you have Turbolinks enabled.

```javascript
//= require facebook_session
```

It also provides a method named `window.withFacebookAPI` that takes a
function and runs it as soon as the Facebook SDK is available (or
immediately if it's already loaded).

Example (in CoffeeScript):

```coffeescript
$('.my-button').click -> withFacebookAPI -> FB.login(...)
```

You can skip loading the `facebook_session` script if you already have
the SDK set up.

## Facebook login

In your controllers, helpers and views, you can now do:

```ruby
if facebook_session?
  facebook_session.user_id # => Facebook user ID
end
```

## Parsing signed requests

```ruby
if facebook_signed_request?
  logger.info facebook_signed_request.app_data
end
```

## Copyright

Copyright (c) 2012 Manual design. See LICENSE for details.
