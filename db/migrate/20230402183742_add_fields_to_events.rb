class AddFieldsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :location, :string
    add_column :events, :description, :string
  end
end
