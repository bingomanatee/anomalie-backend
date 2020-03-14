class CreateDressTypeFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :dress_type_features do |t|
      t.integer :dress_type_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
