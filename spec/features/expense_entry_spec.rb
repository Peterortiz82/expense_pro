require 'rails_helper'

describe 'Expense entry' do
  let(:user) { create :user }
  let(:category_one) { create :category, name: 'Food' }
  let(:category_two) { create :category, name: 'Other' }
  let(:sub_category_one) { create :sub_category, name: 'Fast Food' }
  let(:sub_category_two) { create :sub_category, name: 'Subscriptions' }
  let(:expense_one) { create :expense, category: category_one, sub_category: sub_category_one }
  let(:expense_one) { create :expense, category: category_two, sub_category: sub_category_two }

  before :each do
    login_as(user, :scope => :user)
    visit new_expense_path
  end

  describe 'new page' do
    it 'has a title' do
      within '.panel-heading' do
        expect(page).to have_content 'Enter Expense'
      end
    end

    context 'has select options for' do
      it 'categories' do
        expect(page).to have_select 'expense_category_id'
      end

      it 'sub categories' do
        expect(page).to have_select 'expense_sub_category_id'
      end
    end

    describe 'form submission' do
      context 'with incorrect data' do

        subject {
          select category_two.name, from: 'Select a category'
          fill_in 'Expense', with: ''
          fill_in 'Amount', with: ''
          click_on 'Submit'
        }

        it 'renders :new and displays all relevant error messages' do
          save_and_open_page
          subject
          expect(page).to have_content "Expense can't be blank"
          expect(page).to have_content "Amount can't be blank"
        end

      end

      context 'with correct data' do

        subject {
          select category_one, from: 'Select a category'
          select sub_category_one, from: 'Expense'
          fill_in 'Amount', with: 24
        }

      end
    end
  end
end