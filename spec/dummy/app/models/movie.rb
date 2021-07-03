# frozen_string_literal: true

# == Schema Information
#
# Table name: movies
#
#  id           :integer          not null, primary key
#  imdb_id      :string
#  popularity   :decimal(5, 2)
#  budget       :decimal(, )
#  revenue      :decimal(, )
#  title        :string
#  runtime      :decimal(3, )
#  release_date :date
#
class Movie < ApplicationRecord
end
