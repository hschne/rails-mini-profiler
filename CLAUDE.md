# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Testing
- `bundle exec rake spec` - Run RSpec test suite
- `bundle exec rspec spec/path/to/specific_spec.rb` - Run single test file
- `bundle exec rake` - Run default task (spec + rubocop)

### Linting and Code Quality
- `bundle exec rake lint` - Run all linters (Ruby, JS, CSS, commit messages)
- `bundle exec rubocop` - Ruby linting
- `npm run lint` - JavaScript linting
- `npm run lint:scss` - SCSS linting
- `npm run lint:commit` - Commit message linting

### Asset Building
- `npm run build` - Build production assets with Rollup
- `npm run watch` - Development mode with BrowserSync and file watching

### Multi-Version Testing
- `bundle exec appraisal install` - Install dependencies for all Rails versions
- `bundle exec appraisal rails-8.0 rake spec` - Test against specific Rails version

## Architecture Overview

### Core Components

**Engine Integration**: Rails Mini Profiler is implemented as a Rails Engine (`lib/rails_mini_profiler/engine.rb`) that injects middleware into the host application.

**Middleware Flow**: The core profiling happens in `lib/rails_mini_profiler/middleware.rb` which:
1. Wraps requests with `RequestWrapper` and creates `RequestContext`
2. Uses `Guard` to determine if request should be profiled
3. Sets up tracing with thread-local storage for traces
4. Records flamegraphs via `FlamegraphGuard` if enabled
5. Saves profiling data and optionally renders badges/redirects

**Tracer System**: Modular event-based tracing in `lib/rails_mini_profiler/tracers/`:
- `Registry` - Manages available tracers
- `Subscriptions` - Sets up ActiveSupport::Notifications listeners
- Individual tracers: `ControllerTracer`, `ViewTracer`, `SequelTracer`, `InstantiationTracer`, `RmpTracer`
- `TraceFactory` - Creates trace objects from events
- Uses thread-local storage to collect traces during request

**Configuration**: Centralized in `lib/rails_mini_profiler/configuration.rb` with sub-configurations:
- `Storage` - Database table names and connection settings
- `UserInterface` - Badge position, page size, base controller
- Environment-aware defaults (enabled in dev/test, disabled in production)

**Data Models**: ActiveRecord models in `app/models/rails_mini_profiler/`:
- `ProfiledRequest` - Main request record with timing and metadata
- `Trace` - Individual trace events (DB queries, view renders, etc.)
- `Flamegraph` - StackProf flamegraph data

**Web Interface**: Full MVC stack in `app/` with:
- Controllers for viewing profiled requests and flamegraphs
- Presenters for trace formatting and display logic
- Search functionality for filtering requests and traces
- Stimulus controllers for interactive JavaScript features

### Key Design Patterns

**Thread Safety**: Uses thread-local storage (`Thread.current`) to isolate trace collection per request without blocking concurrent requests.

**Guard Pattern**: `Guard` and `FlamegraphGuard` classes encapsulate profiling decision logic and flamegraph recording.

**Event-Driven**: Leverages Rails' `ActiveSupport::Notifications` for non-intrusive instrumentation.

**Presenter Pattern**: Separates data formatting logic from models in `app/presenters/` for different trace types.

## Development Notes

### Dummy Application
The `spec/dummy/` directory contains a minimal Rails app for testing. Use this for manual testing and development.

### Asset Pipeline
- Uses Rollup for JavaScript bundling (replaces Webpacker as of Rails 8 update)
- Stimulus controllers in `app/javascript/js/` for interactive features
- SCSS stylesheets compiled via Rollup pipeline
- Static Speedscope assets in `public/rails_mini_profiler/speedscope/`

### Database Adapters
The `app/adapters/rails_mini_profiler/database_adapter.rb` handles database-specific optimizations and queries.

### Testing Strategy
- RSpec with dummy Rails application
- Appraisal gem for testing against multiple Rails versions
- SimpleCov for coverage reporting
- Focused on integration testing of middleware and tracing behavior