class Visit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id, presence: true
      t.integer :shortened_url_id, presence: true

      t.timestamps
    end

    add_index :visits, :visitor_id
    add_index :visits, :shortened_url_id
  end
end

# always index foreign keys
# whenever we have a has many relationships
# mental model - back table sorted by column d, e, etc.
