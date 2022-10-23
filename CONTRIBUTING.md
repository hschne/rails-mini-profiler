# Contributing to Rails Mini Profiler

Thank you for helping out with Rails Mini Profiler! :heart:

We welcome all support, whether on bug reports, code, design, reviews, tests,
documentation, translations or just feature requests.

If you are interested in what's planned for the future, check the [Next Release](https://github.com/hschne/rails-mini-profiler/projects/1) and [Backlog](https://github.com/hschne/rails-mini-profiler/projects/2) projects to get an overview.

## Using the Issue Tracker

Please use [GitHub issues](https://github.com/hschne/rails-mini-profiler/issues) to submit bugs or feature requests. 

## Development

Thanks for considering to help make Rails Mini Profiler better! :raised_hands:

### Setting Up

Create a fork of Rails Mini Profiler and clone it locally. Create a new branch for your change, e.g.

```shell
git checkout -b add-awesome-new-feature
```

Setup RMP locally by executing:

```bash
# Setup Rails
bundle install
bin/rails db:setup

# Install Node and build assets
npm install
npm run build
```

Then code away!

### Testing Local Changes

Rails Mini Profiler is a Rails Engine and can be tested out by mounting it in a 'real' Rails app. The `Dummy` application
is such an app and  resides in `spec/dummy`. 

To manually test your changes simply run `bin/rails server` on the root level of your application. To execute the test suite
run 

```bash
bin/rspec
```

To locally test against multiple Rails versions use [Appraisal](https://github.com/thoughtbot/appraisal):

```bash
bin/appraisal install
bin/appraisal rspec
```

#### Working with Assets

Javascript and CSS are packaged as a separate node module and bundled using [Rollup](https://rollupjs.org/guide/en/). 
For continuous compilation and live preview first start your Rails server and then run:

```bash
npm run watch
```

### Prepping your PR

Before opening your PR make sure to adhere to the repository code style and verify that all tests
still pass. Run `bin/rake` to execute both tests and [Rubocop](https://github.com/rubocop/rubocop)

Rails Mini Profiler uses [convential commits](https://www.conventionalcommits.org/en/v1.0.0/#summary). Before opening your pull request,
consider updating your commit messages accordingly. If your commits don't adhere to conventional commits maintainers will squash your commits to adhere to the guidelines.

Finally, go to [GitHub](https://github.com/hschne/rails-mini-profiler) and create a new Pull Request! :rocket:

### Other

#### Annotate

RMP uses [Annotate](https://github.com/ctran/annotate_models) to annotate models. When making changes to the schema, run

```bash
bin/annotate -i --models --exclude tests,fixtures 
```

to update model annotations.


#### Speedscope

RMP uses [Speescope](https://github.com/jlfwong/speedscope) for Flamegraph rendering. To update to the latest release of
Speedscope run

```bash
bin/rake speedscope:update
```

#### Database Support

RMP _should_ work out with any database that Rails officially supports. To run tests or the dummy application with a
specific database use the `DATABASE` environment variable:
```base
DATABASE=sqlite rails s
DATABASE=postgres rails s
```