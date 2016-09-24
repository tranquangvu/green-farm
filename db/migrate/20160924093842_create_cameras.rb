class CreateCameras < ActiveRecord::Migration[5.0]
  def change
    create_table :cameras do |t|
      t.string :ip
      t.string :port
      t.string :access_token

      t.timestamps
    end
  end
end
