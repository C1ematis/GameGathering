class RenamePathColumToGameComents < ActiveRecord::Migration[5.2]
  def change
    rename_column :game_coments, :path , :ancestry
    add_index :game_coments, :ancestry
  end
end
