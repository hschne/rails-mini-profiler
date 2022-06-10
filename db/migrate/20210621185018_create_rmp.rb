# frozen_string_literal: true

class CreateRmp < ActiveRecord::Migration[6.0]
  def change
    create_table :rmp_profiled_requests, charset: 'utf8' do |t|
      t.string :user_id
      t.bigint :start
      t.bigint :finish
      t.integer :duration
      t.bigint :allocations
      t.string :request_path
      t.string :request_query_string
      t.string :request_method
      t.json :request_headers
      t.text :request_body
      t.integer :response_status
      t.text :response_body
      t.json :response_headers
      t.string :response_media_type

      t.timestamps

      t.index :created_at
    end

    create_table :rmp_traces, charset: 'utf8' do |t|
      t.belongs_to :rmp_profiled_request, null: false, foreign_key: true
      t.string :name
      t.bigint :start
      t.bigint :finish
      t.integer :duration
      t.bigint :allocations
      t.json :payload
      t.json :backtrace

      t.timestamps
    end

    create_table :rmp_flamegraphs, charset: 'utf8' do |t|
      t.belongs_to :rmp_profiled_request, null: false, foreign_key: true
      t.binary :data

      t.timestamps
    end
  end
end
