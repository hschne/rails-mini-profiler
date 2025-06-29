<div align="center">

# Rails Mini Profiler

<img alt="logo" src="docs/images/logo.png" width="300px" height="auto">

### Performance profiling for Rails, made simple.

[![Gem Version](https://badge.fury.io/rb/rails_mini_profiler.svg)](https://badge.fury.io/rb/rails_mini_profiler)
[![Main](https://github.com/hschne/rails-mini-profiler/actions/workflows/main.yml/badge.svg)](https://github.com/hschne/rails-mini-profiler/actions/workflows/main.yml)
[![License](https://img.shields.io/github/license/hschne/rails-mini-profiler)](https://img.shields.io/github/license/hschne/rails-mini-profiler)

[![Maintainability](https://api.codeclimate.com/v1/badges/1fcc2f4d01ab5bf7a260/maintainability)](https://codeclimate.com/github/hschne/rails-mini-profiler/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1fcc2f4d01ab5bf7a260/test_coverage)](https://codeclimate.com/github/hschne/rails-mini-profiler/test_coverage)

</div>

## What's this?

Rails Mini Profiler is an easy-to-use performance profiler for your Rails applications. It is heavily inspired by [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler) and other APM tools. To find out how it stacks up against those check out [Why Rails Mini Profiler](#why-rails-mini-profiler)?

To see it in action view the preview below:

<div align="center">

[![Rails Mini Profiler Preview](http://img.youtube.com/vi/fSR8fCcsO8Q/0.jpg)](https://www.youtube.com/watch?v=fSR8fCcsO8Q)

</div>

## Getting Started

Add Rails Mini Profiler to your Gemfile:

```ruby
gem 'rails_mini_profiler'
```

Install the gem and run the installer:

```bash
bundle install
rails rails_mini_profiler:install
```

Inspect the generated migration in `db/migrate` and run it:

```
rails db:migrate
```

Start your Rails application and perform some requests. You can either click the little hedgehog 🦔 on the top
left or navigate to `/rails_mini_profiler` to view collected performance metrics.

## Usage

Rails Mini Profiler provides detailed information about your requests to help you figure out why certain requests perform poorly.

Installing it will generate a new initializer `config/initializers/rails_mini_profiler.rb` and add a new
route:

```ruby
# routes.rb
Rails.application.routes.draw do
  mount RailsMiniProfiler::Engine => '/rails_mini_profiler'
end
```

Once you perform requests against your applications you can inspect them using that route, or by clicking the badge on the
top right that is injected into your pages.

### Request Overview

![overview](docs/images/overview.png)

Requests to your application will be profiled automatically. You can view and search all stored requests by navigating to `yourapp/rails_mini_profiler/profiled_requests`.

### Request Details

<p align="center">
  <img alt="Light" src="docs/images/trace.png" width="45%">
&nbsp; &nbsp; &nbsp; &nbsp;
  <img alt="Dark" src="docs/images/trace-details.png" width="45%">
</p>

This view shows you how your requests spend their time. How much of it is spent in the DB, how much in rendering views?
May can filter and clicking on individual traces to gain deeper insights and see detailed information.

### Flamegraphs

Rails Mini Profiler automatically records Flamegraphs for profiled requests. To enable this feature, add [Stackprof](https://github.com/tmm1/stackprof)
to your Gemfile:

```ruby
gem 'stackprof'
```

For convenience, Flamegraphs are recorded for every request. This may incur a significant performance penalty. To change the default behavior see [Configuration](#Configuration).

Flamegraphs are rendered using [Speedscope](https://github.com/jlfwong/speedscope). See [Troubleshooting](#Troubleshooting) if Flamegraphs are not rendering correctly.

## Configuration

Rails Mini Profiler provides a wide array of configuration options. You can find details below. For an example configuration check `initializers/rails_mini_profiler.rb` (or [the template file](https://github.com/hschne/rails-mini-profiler/blob/main/lib/generators/rails_mini_profiler/templates/rails_mini_profiler.rb.erb)).

| Name                     | Default                      | Description                                                                 |
| ------------------------ | ---------------------------- | --------------------------------------------------------------------------- |
| `enabled`                | `true` (dev)/ `false` (prod) | Whether or not RMP is enabled                                               |
| `flamegraph_enabled`     | `true`                       | Should flamegraphs be recorded automatically?                               |
| `flamegraph_sample_rate` | `0.5`                        | The flamegraph sample rate. How many snapshots per millisecond are created. |
| `skip_paths`             | `[]`                         | An array of request paths that should not be profiled. Regex allowed.       |
| `storage`                | `Storage.new`                | Storage configuration. See [Storage](#Storage).                             |
| `ui`                     | `UserInterface.new`          | UI configuration. See [UI](#UI).                                            |
| `user_provider`          | `Rack::Request.new(env).ip`  | How to identify users. See [Authorization](#Authorization)                  |

### Storage

Rails Mini Profiler stores profiling information in your database per default. You can configure various details of how
traces and requests are stored.

| Name                      | Default                 | Description                                                                                               |
| ------------------------- | ----------------------- | --------------------------------------------------------------------------------------------------------- |
| `database`                | `nil`                   | Set a custom database to be used for storing profiler information. Uses `connect_to` for profiler records |
| `profiled_requests_table` | `rmp_profiled_requests` | The table to be used to store profiled requests.                                                          |
| `flamegraphs_table`       | `rmp_flamegraphs`       | The table to be used to store flamegraphs.                                                                |
| `traces_table`            | `rmp_traces`            | The table to be used to store traces.                                                                     |

Rails Mini Profiler does not offer an automatic way to clean up old profiling information. It is recommended you add a sweeper job to clean up old profiled requests periodically (e.g. using [clockwork](https://github.com/adamwiggins/clockwork). For example, with ActiveJob:

```ruby
# Clockwork
every(1.month, 'purge rails mini profiler') do
    ProfiledRequestCleanupJob.perform_later
end

# ActiveJob
class ProfiledRequestCleanupJob < ApplicationJob
  queue_as :default

  def perform
    RailsMiniProfiler::ProfiledRequest.where('created_at < ?', 1.month.ago).destroy_all
  end
end
```

### UI

Rails Mini Profiler allows you to configure various UI features.

| Name              | Default                 | Description                                                                                     |
| ----------------- | ----------------------- | ----------------------------------------------------------------------------------------------- |
| `badge_enabled`   | `true`                  | Should the hedgehog 🦔 badge be injected into pages?                                            |
| `badge_position`  | `'top-left'`            | Where to display the badge. Options are `'top-left', 'top-right', 'bottom-left, 'bottom-right'` |
| `base_controller` | `ApplicationController` | Which controller UI controllers should inherit from.                                            |
| `page_size`       | `25`                    | The page size for lists shown in the UI.                                                        |

### Request Configuration

You may override static configuration on a per-request by attaching request parameters. For example, `https://myapp.com/api/mydata?rmp_flamegraph=false`

| Name             | Description                                                                                  |
| ---------------- | -------------------------------------------------------------------------------------------- |
| `rmp_flamegraph` | Overrides `flamegraph_enabled` If set to `true` will redirect to the flamegraph immediately. |

### Authorization

Profiling information is segregated by user ID. That means users cannot see each other's profiled requests. Per default, individual users are identified by their IP adress.

You may change this by setting a custom user provider:

```ruby
config.user_provider = proc { |env| Rack::Request.new(env).ip }
```

You may also explicitly set the user by modifying your application controller (or the controller you have configured as UI base controller):

```ruby
class ApplicationController < ActionController::Base
  before_action do
    RailsMiniProfiler::User.authorize(current_user.id)
  end
end
```

`ApplicationController` is used as the default base class for UI controllers. To change it, you may use `configuration.ui.base_controller`.

### Profiling in Production

Rails Mini Profiler is not intended for performance monitoring. There are other tools for that ( [RorVsWild](https://www.rorvswild.com/), [AppSignal](https://www.appsignal.com/), [Skylight](https://www.skylight.io/),
[New Relic](https://newrelic.com/), [DataDog](https://www.datadoghq.com/)...). But you can still use RMP in production to profile specific requests.

Per default, _no requests will be profiled_ in production, and the Rails Mini Profiler UI will be inaccessible.

#### Enabling Profiling

Since profiling impacts performance, it is recommended that you limit which requests are being profiled:

```ruby
RailsMiniProfiler.configure do |config|
  config.enabled = proc { |env| env.headers['RMP_ENABLED'].present? }
end
```

#### Authorizing Users

You must explicitly authorize profiling for users, as well as authenticate them to the UI:

```ruby
class ApplicationController < ActionController::Base
  before_action do
    RailsMiniProfiler::User.authorize(current_user.id) # Requests by this user will now be profiled, and they get access to the UI
  end
end
```

## Why Rails Mini Profiler?

Improving the performance of any application is a 3-step process. You have to answer these questions:

1. What is slow?
2. Why is it slow?
3. Did my solution fix the slowness?

I'm a huge fan of [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler), and APM tools such as [Skylight](https://www.skylight.io/) or [Scout APM](https://scoutapm.com). Each of these tools has its own areas where it succeeds.

APM tools are excellent for profiling your app in production - aka. they show you what is slow - and offer _some_ hints as to what causes the slowdown. `rack-mini-profiler` can do some sampling in production, but excels at providing detailed insight into _why_ something is slow by providing Flamegraphs and detailed query information.

Rails Mini Profiler improves upon `rack-mini-profiler` in the latter regard. It is a developer tool, rather than a monitoring tool, and sets a big focus on developer experience. Simply put, it aims to be the best tool available to help you figure out _why_ specific requests are slow.

As such, compared to `rack-mini-profiler`, it does not support non-Rails apps (e.g. Sinatra) or production sampling, but provides a much better user experience and better support for API-only applications.

## Troubleshooting

### Upgrading

Rails Mini Profiler is in early development. As such, breaking changes may still be introduced on a regular basis. While Rails Mini Profiler is in pre-release we do not offer upgrade migrations.

If an upgrade to Rails Mini Profiler breaks your application, we recommend that you clean house and start over. Re-run the initializer and overwrite existing files:

```bash
rails rails_mini_profiler:install
```

If only the DB schema is out of date, drop the offending tables and re-run migrations for the latest version:

```
rails rails_mini_profiler:install:migrations
rails db:migrate
```

### Support for API-Only Apps

Rails Mini Profiler supports API-only apps, but you have to make some small adjustments to use it. At the top of `application.rb` add [Sprockets](https://github.com/rails/sprockets-rails):

```ruby
require "sprockets/railtie"
```

Then, modify `application.rb`:

```ruby
module ApiOnly
  class Application < Rails::Application

    config.api_only = true # Either set this to false
    config.middleware.use ActionDispatch::Flash # Or add this
  end
end
```

**Note**: Sprockets and flash are currently required for some of Rails Mini Profiler's UI features. These modifications may no longer be needed in the future.

### No Flamegraphs are being recored?

Make sure you have added [StackProf](https://github.com/tmm1/stackprof) to your Gemfile.

```ruby
gem 'stackprof'
```

### Flamegraphs are not rendering?

Flamegraphs are loaded into [Speedscope](https://github.com/jlfwong/speedscope) using an Iframe and URI Encoded blobs (see [source](https://github.com/hschne/rails-mini-profiler/blob/main/app/views/rails_mini_profiler/flamegraphs/show.html.erb))
If your browser gives you warnings about blocking content due to CSP you _must_ enable `blob` as default source:

```ruby
Rails.application.config.content_security_policy do |policy|
    policy.default_src :self, :blob
    ...
end
```

### Some requests have no Flamegraphs attached?

[StackProf](https://github.com/tmm1/stackprof), which is used for recording Flamegraphs, does not work on concurrent requests.
Because of this, concurrent requests may skip recording a Flamegraph.

It is recommended that you resend _only_ the request you wish to build a Flamegraph for.

## Credit

This project was heavily inspired by projects such as [rack-mini-profiler](https://github.com/MiniProfiler/rack-mini-profiler) and
[rack-profiler](https://github.com/dawanda/rack-profiler). [Skylight](https://www.skylight.io/) was also a huge influence.

[Lena Schnedlitz](https://github.com/LenaSchnedlitz) designed the Logo and provided great support. Without her supreme CSS skills this project would not have been possible 🙌

## Contributing

See [Contributing](CONTRIBUTING.md)

## License

This gem is available as open source under the terms of the [MIT License](LICENSE).
