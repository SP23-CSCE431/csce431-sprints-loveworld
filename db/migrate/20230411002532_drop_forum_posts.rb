class DropForumPosts < ActiveRecord::Migration[7.0]
  def change
    drop_table :forum_posts, force: :cascade, if_exists: true
    drop_table :replies, force: :cascade, if_exists: true
  end
end
