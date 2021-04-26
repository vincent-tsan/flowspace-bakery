class AddStatusToCookies < ActiveRecord::Migration[5.1]
  def up 
  	add_column :cookies, :status, :integer
  end
  def down
  	remove_column :cookies, :status
  end
end
