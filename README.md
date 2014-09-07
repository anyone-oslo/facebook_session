# FacebookSession [![Build Status](https://travis-ci.org/manualdesign/facebook_session.svg?branch=master)](https://travis-ci.org/manualdesign/facebook_session) [![Code Climate](https://codeclimate.com/github/manualdesign/facebook_session/badges/gpa.svg)](https://codeclimate.com/github/manualdesign/facebook_session) [![Test Coverage](https://codeclimate.com/github/manualdesign/facebook_session/badges/coverage.svg)](https://codeclimate.com/github/manualdesign/facebook_session)

FacebookSession is a bare bones Facebook session authentication plugin for
Rails, intended to complement the Javascript SDK.

## Installation

Add it to your Gemfile:

```ruby
gem 'facebook_session'
```

Then, create config/initializers/facebook_session.rb and add your API details:

```ruby
FacebookSession.configure(
  application_id:     '12345678',
  application_secret: 'myapplication_secret'
)
```

## Usage

In your controllers, helpers and views, you can now do:

```ruby
if facebook_session?
  facebook_session.user_id # => Facebook user ID
end
```

You probably want to pass your application ID to the frontend layer,
which you can find in:

```ruby
FacebookSession.application_id
```

FacebookSession can also parse signed requests.

```ruby
if facebook_signed_request?
  logger.info facebook_signed_request.app_data
end
```

## Copyright

Copyright (c) 2012 Manual design. See LICENSE for details.
