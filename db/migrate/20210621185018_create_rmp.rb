# frozen_string_literal: true

class CreateRmp < ActiveRecord::Migration[6.1]
  def change
    create_table :rmp_profiled_requests do |t|
      t.string :user_id
      t.datetime :start
      t.datetime :finish
      t.integer :duration
      t.integer :allocations
      t.integer :response_status
      t.json :response_body
      t.json :response_headers
      t.json :request_headers
      t.json :request_body

      t.timestamps
    end

    create_table :rmp_traces do |t|
      t.references :rmp_profiled_requests, null: false, foreign_key: true
      t.datetime :start
      t.datetime :finish
      t.integer :duration
      t.integer :allocations
      t.json :payload
      t.json :backtrace

      t.timestamps
    end
  end
end
