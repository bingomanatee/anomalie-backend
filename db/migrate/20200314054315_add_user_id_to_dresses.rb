class AddUserIdToDresses < ActiveRecord::Migration[6.0]
  def change
    add_column :dresses, :user_id, :integer
  end
end
