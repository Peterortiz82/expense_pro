class CreateMonthlyBills < ActiveRecord::Migration
  def change
    create_table :monthly_bills do |t|
      t.string :name
      t.string :person
      t.float :amount
      t.datetime :due_date
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
