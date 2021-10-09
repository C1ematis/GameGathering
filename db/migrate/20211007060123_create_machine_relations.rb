class CreateMachineRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :machine_relations do |t|

      t.references :game, foreign_key: true
      t.references :machine, foreign_key: true

      t.timestamps
    end
  end
end
