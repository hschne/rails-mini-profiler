# frozen_string_literal: true

return if Movie.any?

require 'csv'
movies = CSV.read("#{File.dirname(__FILE__)}/movies.csv", headers: true).map(&:to_h)
           .each { |attrs| attrs['release_date'] = Date.strptime(attrs['release_date'], '%m/%d/%Y') }
           .map { |attrs| Movie.new(attrs) }

Movie.import(movies)
