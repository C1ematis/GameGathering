class RenamePathColumnToComents < ActiveRecord::Migration[5.2]
  def change
    rename_column :coments, :path , :ancestry
    add_index :coments, :ancestry
  end
end
