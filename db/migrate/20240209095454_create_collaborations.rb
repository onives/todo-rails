# frozen_string_literal: true

# Create collaborations Migration
class CreateCollaborations < ActiveRecord::Migration[7.1]
  def change
    create_table :collaborations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
