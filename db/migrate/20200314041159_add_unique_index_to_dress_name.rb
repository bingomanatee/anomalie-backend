class AddUniqueIndexToDressName < ActiveRecord::Migration[6.0]
  def change
    add_index :dress_types, :name, :unique => true
  end
end
