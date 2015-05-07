class ShortenedUrl < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, presence: true, unique: true
      t.string :short_url, presence: true, unique: true
      t.integer :submitter_id

      t.timestamps
    end

    add_index :shortened_urls, :short_url, unique: true
  end
end
