class CreateRmp < ActiveRecord::Migration[6.1]
  def change
    create_table :rails_mini_profiler_profiled_request_records do |t|
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

    create_table :rails_mini_profiler_trace_records do |t|
      t.references :request_id, null: false, foreign_key: true
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
