# frozen_string_literal: true

# add user migration
class AddUserToTodos < ActiveRecord::Migration[7.1]
  def change
    # add_reference :todos, :user, null: false, foreign_key: true, index: true, default: User.first.id
    add_reference :todos, :user, foreign_key: true, index: true
  end
end
