class AddColumnsToTodos < ActiveRecord::Migration[7.1]
  def change
    add_column :todos, :title, :string
    add_column :todos, :body, :text
  end
end
