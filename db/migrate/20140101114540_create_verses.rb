class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.integer :position
      t.integer :surah_id

      t.timestamps
    end
  end
end
