class RemoveTokensFromAdmin < ActiveRecord::Migration[7.0]
  def change
    remove_column :admins, :access_token, :string
    remove_column :admins, :expires_at, :datetime
    remove_column :admins, :refresh_token, :string
  end
end
