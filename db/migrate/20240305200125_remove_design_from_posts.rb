class RemoveDesignFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :design, :integer
  end
end
