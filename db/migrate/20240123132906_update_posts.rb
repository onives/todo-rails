class UpdatePosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :description, :text
  end
end
