namespace :expenses do

  desc "Adds user id to expenses"

  task add_user_id_to_expenses: :environment do
    List.all.each do |list|
      list.expenses.each do |expense|
        expense.user_id = list.user_id if expense.user_id.nil?
        expense.save!
      end
    end
  end

end
