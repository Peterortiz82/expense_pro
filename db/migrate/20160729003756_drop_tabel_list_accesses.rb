class DropTabelListAccesses < ActiveRecord::Migration

  def up
    drop_table :list_accesses
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
