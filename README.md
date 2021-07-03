# Rails Mini Profiler

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

Start your Rails application and perform some requests. You can either click the little hedgehog 🦔 on the top 
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

Once you perform requests against your applications you can inspect them using that route. 

### Request Overview

TODO: Image goes here

Requests to your application will be profiled automatically. You can all stored requests by navigating to `yourapp/rails_mini_profiler/profiled_requests`.

### Request Details

TODO: Image goes here

This view shows you how your requests spend their time. How much of it is spent in the DB, how much in rendering views? 
By clicking on individual traces you can find out even more detailed information.

## Configuration

### Storage

Rails Mini Profiler uses the `RailsMiniProfiler::Memory` storage per default. This means that Profiles are not persisted
through server restarts or across multiple processes. 

It is recommended to use `RailsMiniProfiler::ActiveRecord` instead.

#### ActiveRecord

```
config.storage = RailsMiniProfiler::ActiveRecord
```

This will persist profiles in your database, so you have to run a migration:

```bash
rails rails_mini_profiler:install:migrations
rails db:migrate
```

The following further configuration options are available: 

| Configuration            | Description                                      |
|--------------------------|--------------------------------------------------|
| `profiled_request_table` | The table to be used to store profiled requests. |
| `flamegraph_table`       | The table to be used to store flamegraphs.       |
| `trace_table`            | The table to be used to store traces.            |


Rails Mini Profiler does not offer an automatic way to clean up old profiling information. It is recommended you add a sweeper job to clean up old profiled requests periodically (e.g. using [clockwork](https://github.com/adamwiggins/clockwork). For example, with ActiveJob:

```
# Clockwork
every(1.month, 'purge rails mini profiler' do
    ProfiledRequestCleanupJob.perform_later
end

# ActiveJob
class ProfiledRequestCleanupJob < ApplicationJob
  queue_as :default

  def perform(*guests)
    RailsMiniProfiler::ProfiledRequest.where('created_at < ?', 1.month.ago).destroy_all
  end
end
```

### Users

Profiling information is segregated by user. That means, you will never see another users profiled requests. 

Per default, individual users are identified by their IP address. You may change this by setting a custom user provider: 

```ruby
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

Only requests by explicitly set users will be stored. To configure how individual users are identified see [Users](#Users)

## Development

Tests and development runs will use the `Dummy` application, which resides in `spec/dummy`. To run Rails Mini Profiler locally 
run `rails s`. To run the tests execute: 

```ruby
bundle exec rspec
```

RMP uses [Annotate](https://github.com/ctran/annotate_models) to annotate models. Run

```
bundle exec annotate --models --exclude tests,fixtures
```

## Contributing

Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
