class CreateListPermissions < ActiveRecord::Migration
  def change
    create_table :list_permissions do |t|
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
