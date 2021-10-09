class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|

      t.string  :name
      t.string  :kana
      t.text    :body
      t.string  :cero
      t.text    :official
      t.text    :wiki
      t.string  :day

      t.timestamps
    end
  end
end
