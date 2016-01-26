class RequireUserFields < ActiveRecord::Migration
  def change
    change_column :users, :name, :string, null: false
    change_column :users, :email, :string, null: false
  end
end
