# Rails Mini Profiler

[![Gem Version](https://badge.fury.io/rb/graphql-groups.svg)](https://badge.fury.io/rb/graphql-groups)
[![Build Status](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability)](https://codeclimate.com/github/hschne/graphql-groups/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/test_coverage)](https://codeclimate.com/github/hschne/graphql-groups/test_coverage)

Rails performance profiling, made simple.

## What's this?

Rails Mini Profiler is a fully-featured performance profiler for your Rails applications. It is heavily inspired  
by [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler), and aims at extending its functionality while
being easy to use.

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

Inspect the generated migration in `migrate/YYYYmmDDHHMMSS_create_rmp.rb` and migrate:

```
rails db:migrate
```

Start your Rails application and perform some requests. You can either click the little hedgehog 🦔 on the top
right or navigate to `/rails_mini_profiler` to view request profiles.

## Usage

Rails Mini Profiler provides detailed information about your requests to help you figure out why certain requests perform poorly.

Installing it will generate a new initializer `config/initializers/rails_mini_profiler.rb` and add a new
route:

```ruby
# routes.rb
Rails.application.routes.draw do
  ...
  
  mount RailsMiniProfiler::Engine => '/rails_mini_profiler'
end
```

Once you perform requests against your applications you can inspect them using that route, or by clicking the badge on the
top right that is injected into your pages.

### Request Overview

TODO: Image goes here

Requests to your application will be profiled automatically. You can view all stored requests by navigating to `yourapp/rails_mini_profiler/profiled_requests`.

### Request Details

TODO: Image goes here

This view shows you how your requests spend their time. How much of it is spent in the DB, how much in rendering views?
By clicking on individual traces you can find out even more detailed information.

### Flamegraphs

Rails Mini Profiler per default records Flamegraphs for every profiled request for convenience. Note that Flamegraphs recording
incur a significant performance penalty, and can take a up a lot of space.

To change the default behaviour see [Configuration](#Configuration). 

Flamegraphs are rendered using [Speedscope](https://github.com/jlfwong/speedscope). If you notice that Flamegraphs are not rendering
you may have to amend your content security policy. See [Troubleshooting](#Troubleshooting)

## Configuration

You can set the following configuration options in Rails Mini Profiler:

| Option               | Default                      | Description                                                           |
|----------------------|------------------------------|-----------------------------------------------------------------------|
| `enabled`            | `true` (dev)/ `false` (prod) | Whether or not RMP is enabled                                         |
| `badge_enabled`      | `true`                       | Should the hedgehog 🦔 badge be injected into pages?                   |
| `flamegraph_enabled` | `true`                       | Should flamegraphs be recorded automatically?                         |
| `skip_paths`         | `[]`                         | An array of request paths that should not be profiled. Regex allowed. |
| `storage`            | `Storage`                    | Storage configuration. See [Storage](#Storage)                         |
| `user_provider`      | `Rack::Request.new(env).ip`  | How to identify users. See [Users](#Users)                            |

### Request Configuration

You may override the configuration by sending request parameters. The following parameters are available:

| Option           | Description                                                                                 |
|------------------|---------------------------------------------------------------------------------------------|
| `rmp_flamegraph` | Overrides `flamegraph_enabled` If set to `true` will redirect to the flamegraph immediatly. |

### Storage

Rails Mini Profiler stores profiling information in your database per default. You can configure various details of how
traces and requests are stored.

| Configuration            | Default                 | Description                                      |
|--------------------------|-------------------------|--------------------------------------------------|
| `profiled_request_table` | `rmp_profiled_requests` | The table to be used to store profiled requests. |
| `flamegraph_table`       | `rmp_flamegraphs`       | The table to be used to store flamegraphs.       |
| `trace_table`            | `rmp_traces`            | The table to be used to store traces.            |


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

Profiling information is segregated by user. That means users cannot see each other's profiled requests.

Per default, individual users are identified by their IP address. You may change this by setting a custom user provider:

```ruby
config.user_provider = proc { |env| Rack::Request.new(env).ip }
```

You may also explicitly set the user from the application itself:

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

## Troubleshooting

### Flamegraphs are not rendering?

Flamegraphs are loaded into [Speedscope](https://github.com/jlfwong/speedscope) using an Iframe and URI Encoded blobs (see [source](https://github.com/hschne/rails-mini-profiler/blob/main/app/views/rails_mini_profiler/flamegraphs/show.html.erb))
If your browser gives you warnings about blocking content due to CSP you _must_ enable `blob` as default source: 

```ruby
Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, :blob
    ...
end
```

## Development

Tests and development runs will use the `Dummy` application, which resides in `spec/dummy`. To run Rails Mini Profiler locally execute `rails s`. To run the tests execute:

```ruby
bundle exec rspec
```

RMP uses [Annotate](https://github.com/ctran/annotate_models) to annotate models. Run

```
bundle exec annotate --models --exclude tests,fixtures
```

## Credit

This project was heavily inspired by projects such as [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) and
[rack-profiler](https://github.com/dawanda/rack-profiler). [Skylight](https://www.skylight.io/) was also a huge influence.

[Lena Schnedlitz](https://github.com/LenaSchnedlitz) designed the Logo and provided great support. Without her supreme CSS skills this project would not have been possible :hands_raised:

## Contributing

Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
