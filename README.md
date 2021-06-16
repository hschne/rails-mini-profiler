# RailsMiniProfiler

[![Gem Version](https://badge.fury.io/rb/graphql-groups.svg)](https://badge.fury.io/rb/graphql-groups)
[![Build Status](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)](https://github.com/hschne/graphql-groups/workflows/Build/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/maintainability)](https://codeclimate.com/github/hschne/graphql-groups/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/692d4125ac8548fb145e/test_coverage)](https://codeclimate.com/github/hschne/graphql-groups/test_coverage)

Rails performance profiling, made simple.

## Installation

Add this line to your application's Gemfile and install and setup Rails Mini Profiler:

```ruby
gem 'rails-mini-profiler'
```

```bash
$ bundle install
```

Add the following to your `routes.rb`

```ruby
mount RailsMiniProfiler::Engine => '/profiler'
```

## Usage

Rails Mini Profiler is a fully-featured, simple performance profiler for your Rails application. It is a spiritual successor
to [Rack Mini Profiler](https://github.com/MiniProfiler/rack-mini-profiler), providing additional functionality while being
dead simple to use.

### 

### Profiling in Production

### Configuration

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
