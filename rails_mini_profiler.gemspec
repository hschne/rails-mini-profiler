# frozen_string_literal: true

require_relative 'lib/rails_mini_profiler/version'

Gem::Specification.new do |spec|
  spec.name        = 'rails_mini_profiler'
  spec.version     = RailsMiniProfiler::VERSION
  spec.authors     = ['hschne']
  spec.email       = ['hans.schnedlitz@gmail.com']

  spec.summary = 'An improved version  of rack-mini-profiler, tailed to Ruby on Rails applications'
  spec.description = 'Hands-on performance profiling for your Rails applications'
  spec.homepage = 'https://github.com/hschne/rails_mini_profiler'
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.add_dependency 'inline_svg'
  spec.add_dependency 'rails', '~> 6.1.3', '>= 6.1.3.1'
end
