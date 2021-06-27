# frozen_string_literal: true

class CreateRmp < ActiveRecord::Migration[6.1]
  def change
    create_table :rmp_profiled_requests do |t|
      t.string :user_id
      t.integer :start
      t.integer :finish
      t.integer :duration
      t.integer :allocations
      t.integer :response_status
      t.json :response_body
      t.json :response_headers
      t.string :request_path
      t.json :request_headers
      t.json :request_body

      t.timestamps
    end

    create_table :rmp_traces do |t|
      t.belongs_to :rmp_profiled_request, null: false, foreign_key: true
      t.string :name
      t.integer :start
      t.integer :finish
      t.integer :duration
      t.integer :allocations
      t.json :payload
      t.json :backtrace

      t.timestamps
    end

    create_table :rmp_flamegraphs do |t|
      t.belongs_to :rmp_profiled_request, null: false, foreign_key: true
      t.json :data

      t.timestamps
    end
  end
end
