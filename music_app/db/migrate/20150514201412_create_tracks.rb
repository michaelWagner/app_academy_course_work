class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id
      t.string :song_name, null: false
      t.text :lyrics
      t.string :bonus_or_regular

      t.timestamps null: false
    end
  end
end
