# RailsMiniProfiler

[![Gem Version](https://badge.fury.io/rb/graphql-groups.svg)](https://badge.fury.io/rb/graphql-groups)
[![Build Status](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability)](https://codeclimate.com/github/hschne/graphql-groups/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/test_coverage)](https://codeclimate.com/github/hschne/graphql-groups/test_coverage)

Rails performance profiling, made simple.

## What's this? 

Rails Mini Profiler is a fully-featured, simple performance profiler for your Rails applications. It is heavily inspired  
by [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler), and aims at extending it's functionality while
being dead simple to use.


## Getting Started

Add Rails Mini Profiler to your Gemfile:

```ruby
gem 'rails-mini-profiler'
```

Install the gem and run the installer:

```bash
bundle install
rails rail_mini_profiler:install
```

That's it. Start your Rails application and perform some requests. You can either click the little hedgehog 🦔 on the top 
right or navigate to `/rails_mini_profiler` to view request profiles.

## Usage

Rails Mini Profiler makes it easy to understand why certain requests perform poorly. 

Installing it will generate a new initializer `config/initializers/rails_mini_profiler.rb` and add a new
route: 

```ruby
# routes.rb
Rails.application.routes.draw do
  ...
  
  mount RailsMiniProfiler::Engine => '/rails_mini_profiler'
end
```

### Request Overview
TODO: Image goes here

Requests to your application will be profiled automatically. You can all stored requests by navigating to `yourapp/rails_mini_profiler/profiled_requests`.

### Request Details

TODO: Image goes here

This view shows you how your requests spend their time. How much of it is spent in the DB, how much in rendering views? 
By clicking on individual traces you can find out even more detailed information.

### Configuration


Per default, individual users are identifed by their IP address. You may change this by setting a custom user provider: 

```sql
config.user_provider = proc { |env| Rack::Request.new(env).ip }
```

You may also explictly set the user from the application itself:

```ruby
class ApplicationController < ActionController::Base
  ...
  
  before_action do 
    RailsMiniProfiler::User.authorize(current_user.id)
  end
end
```

Note that you **must** set the current user when running Rails Mini Profiler in production. No profiles will be saved otherwise.

### Profiling in Production

Rails Mini Profiler is not intended for performance reporting. There are other tools for that ( [Skylight](https://www.skylight.io/), 
[New Relic](https://newrelic.com/), [DataDog](https://www.datadoghq.com/)...).

However, you can still use it in production to profile specific requests. Since profiling impacts performance, it is recommended
that you limit which requests are being profiled:

```ruby
RailsMiniProfiler.configure do |config|
  config.enabled = proc { |env| env.headers['RMP_ENABLED'].present? }
end
```

To configure which 



## Development

To annotate models run 

```
bundle exec annotate --models --exclude tests,fixtures
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
