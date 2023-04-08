class CreateForumPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_posts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
