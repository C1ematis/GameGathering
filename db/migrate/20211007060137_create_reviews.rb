class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.references  :game, foreign_key: true
      t.references  :user, foreign_key: true
      t.text        :body
      t.string      :hour
      t.float       :story
      t.float       :system
      t.float       :total
      t.boolean     :is_spoiler, default: false

      t.timestamps
    end
  end
end
