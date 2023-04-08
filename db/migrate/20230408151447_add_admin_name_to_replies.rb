class AddAdminNameToReplies < ActiveRecord::Migration[7.0]
  def change
    add_column :replies, :admin_name, :string
  end
end
