class CreateComents < ActiveRecord::Migration[5.2]
  def change
    create_table :coments do |t|

      t.string    :name
      t.text      :body
      t.string    :path
      t.string    :page

      t.timestamps
    end
  end
end
