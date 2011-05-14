class CreateArtistsTable < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string  :name
      t.string  :details_link
      t.string  :shows_link
      t.integer :show_count
    end

    add_index :artists, :name
  end

  def self.down
    drop_table :artists
  end
end
