class AddAdminNameToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :admin_name, :string
  end
end
