# RailsMiniProfiler

[![Gem Version](https://badge.fury.io/rb/graphql-groups.svg)](https://badge.fury.io/rb/graphql-groups)
[![Build Status](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability)](https://codeclimate.com/github/hschne/graphql-groups/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/test_coverage)](https://codeclimate.com/github/hschne/graphql-groups/test_coverage)

Rails performance profiling, made simple.

## What's this? 

Rails Mini Profiler is a fully-featured, simple performance profiler for your Rails applications. It is a spiritual successor
to [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler), aimed at extending it's functionality and
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

### Profiling in Production

### Configuration

## Development

To annotate models run 

```
bundle exec annotate --models --exclude tests,fixtures
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
