class CreateGameComents < ActiveRecord::Migration[5.2]
  def change
    create_table :game_coments do |t|

      t.references :game, foreign_key: true
      t.string     :name
      t.text       :body
      t.string     :path

      t.timestamps
    end
  end
end
