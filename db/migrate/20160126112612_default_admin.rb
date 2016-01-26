class DefaultAdmin < ActiveRecord::Migration
  def up
    add_column :users, :deletable, :boolean, default: true
  end

  def down
    remove_column :users, :deletable
  end
end
