# Contributing to Rails Mini Profiler

Thank you for helping out with Rails Mini Profiler! :heart:

We welcome all support, whether on bug reports, code, design, reviews, tests,
documentation, translations or just feature requests.

If you are interested in what's planned for the future, check the [Next Release](https://github.com/hschne/rails-mini-profiler/projects/1) and [Backlog](https://github.com/hschne/rails-mini-profiler/projects/2) projects to get an overview.

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

Rails Mini Profiler uses [convential commits](https://www.conventionalcommits.org/en/v1.0.0/#summary). Before opening your pull request,
consider updating your commit messages accordingly. This is not a must, but maintainers may squash your commits to adhere to the guidelines.

Finally, go to [GitHub](https://github.com/hschne/rails-mini-profiler) and create a new Pull Request! :rocket:

### Other

#### Annotate

RMP uses [Annotate](https://github.com/ctran/annotate_models) to annotate models. When making changes to the schema, run

```bash
bundle exec annotate -i --models --exclude tests,fixtures 
```

to update model annotations.

#### Speedscope

RMP uses [Speescope](https://github.com/jlfwong/speedscope) for Flamegraph rendering. To update to the latest release of
Speedscope run

```bash
rake speedscope:update
```
