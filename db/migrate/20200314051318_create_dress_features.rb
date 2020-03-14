class CreateDressFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :dress_features do |t|
      t.integer :dress_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
