class CreateFarms < ActiveRecord::Migration[5.0]
  def change
    create_table :farms do |t|
      t.string :address
      t.integer :section_index
      t.integer :user_id

      t.timestamps
    end
  end
end
