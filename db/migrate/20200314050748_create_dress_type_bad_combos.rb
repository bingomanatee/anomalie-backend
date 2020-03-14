class CreateDressTypeBadCombos < ActiveRecord::Migration[6.0]
  def change
    create_table :dress_type_bad_combos do |t|
      t.integer :dress_type_id
      t.jsonb :combination

      t.timestamps
    end
  end
end
