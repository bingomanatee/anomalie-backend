class CreateDresses < ActiveRecord::Migration[6.0]
  def change
    create_table :dresses do |t|
      t.integer :dress_type_id
      t.integer :user

      t.timestamps
    end
  end
end
