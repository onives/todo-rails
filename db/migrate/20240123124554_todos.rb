# frozen_string_literal: true

class Todos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos
  end
end