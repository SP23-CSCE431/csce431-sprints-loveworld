# location: spec/feature/integration_spec.rb
require 'rails_helper'

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in "user[full_name]", with: 'harry potter'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('harry potter')
  end
end