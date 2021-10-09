class CreateGenreRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :genre_relations do |t|

      t.references :game, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
