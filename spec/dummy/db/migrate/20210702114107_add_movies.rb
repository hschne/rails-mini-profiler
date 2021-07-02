# frozen_string_literal: true

class AddMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies, force: :cascade do |t|
      t.string :imdb_id
      t.decimal :popularity, precision: 5, scale: 2
      t.decimal :budget
      t.decimal :revenue
      t.string :title
      t.decimal :runtime, precision: 3
      t.date :release_date
    end
  end
end
