class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :amount
      t.text :description
      t.integer :category_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
