class RemoveTagCountModelFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :tag_count_model, :integer
  end
end
