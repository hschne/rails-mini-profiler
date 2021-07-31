# Contributing to Rails Mini Profiler

Thank you for helping out with Rails Mini Profiler! :heart:

We welcome all support, whether on bug reports, code, design, reviews, tests,
documentation, translations or just feature requests.

## Using the Issue Tracker

Please use [GitHub issues](https://github.com/wagtail/wagtail/issues) to submit bugs or feature requests. 

## Development

Thanks for considering to help make Rails Mini Profiler better! :raised_hands:

### Setting Up

Create a fork of Rails Mini Profiler and clone your fork locally. Create a new branch for your change, e.g.

```shell
git checkout -b add-awesome-new-feature
```

Setup RMP locally by executing 

```
bundle install
rails db:setup
```

Then code away!

### Testing Local Changes

Rails Mini Profiler is a Rails Engine and can be tested out by mounting it in a 'real' Rails app. The `Dummy` application
is such an app and  resides in `spec/dummy`. 

To manually test your changes simply run `rails server` on the root level of your application. To execute the test suite
run 

```ruby
bundle exec rspec
```

### Prepping your PR

We care about quality. Before opening your PR make sure to adhere to the repository code style and verify that all tests
still pass. Run `rake` to execute both tests and [Rubocop](https://github.com/rubocop/rubocop)

Finally, go to [GitHub](https://github.com/hschne/rails-mini-profiler) and create a new Pull Request! :rocket:


### Other

RMP uses [Annotate](https://github.com/ctran/annotate_models) to annotate models. When making changes to the schema, run

```
bundle exec annotate -i --models --exclude tests,fixtures 
```

to update model annotations.

