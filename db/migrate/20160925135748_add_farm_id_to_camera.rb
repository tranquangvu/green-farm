class AddFarmIdToCamera < ActiveRecord::Migration[5.0]
  def change
    add_column :cameras, :farm_id, :integer
  end
end
