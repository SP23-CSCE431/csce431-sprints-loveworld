class AddAdminIdToForumPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :forum_posts, :admin_id, :integer
  end
end
