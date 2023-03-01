require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('User') do
  context 'when using valid input' do
    it 'creates an account' do
      visit new_user_path
      fill_in 'user[full_name]', with: 'harry potter'
      fill_in 'user[email]', with: 'harrypotter@mybusiness.com'
      fill_in 'user[phone_number]', with: '0123456789'
      click_on 'Create User'
      visit users_path
      expect(page).to(have_content('harry potter'))
      expect(page).to(have_content('harrypotter@mybusiness.com'))
      expect(page).to(have_content('0123456789'))
    end
  end

  context 'when using invalid full name' do
    it 'creates an account' do
      visit new_user_path
      fill_in 'user[email]', with: 'harrypotter@mybusiness.com'
      fill_in 'user[phone_number]', with: '0123456789'
      click_on 'Create User'
      
      expect(page).to(have_content('All data fields must be filled out.'))
    end
  end

  context 'when using invalid email' do
    it 'creates an account' do
      visit new_user_path
      fill_in 'user[full_name]', with: 'harry potter'
      fill_in 'user[phone_number]', with: '0123456789'
      click_on 'Create User'
      
      expect(page).to(have_content('All data fields must be filled out.'))
    end
  end

  context 'when using invalid phone number' do
    it 'creates an account' do
      visit new_user_path
      fill_in 'user[full_name]', with: 'harry potter'
      fill_in 'user[email]', with: 'harrypotter@mybusiness.com'
      click_on 'Create User'
      
      expect(page).to(have_content('All data fields must be filled out.'))
    end
  end
end
