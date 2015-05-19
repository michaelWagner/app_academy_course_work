class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.string :live_or_studio
      t.integer :band_id

      t.timestamps null: false
    end
  end
end
