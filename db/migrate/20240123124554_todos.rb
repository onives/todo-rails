# frozen_string_literal: true

# some comment here
class Todos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos # rubocop:disable Rails/CreateTableWithTimestamps
  end
end
