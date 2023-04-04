require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Group') do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_on 'Sign in with Google'
  end

  context 'when using valid input' do
    it 'creates a group' do
      visit new_group_path
      fill_in 'group[name]', with: 'Year 7 Hufflepuff'
      fill_in 'group[description]', with: 'Hufflepuff students in their seventh year at Hogwarts'

      click_on 'Create Group'
      visit groups_path
      expect(page).to(have_content('Year 7 Hufflepuff'))
      expect(page).to(have_content('Hufflepuff students in their seventh year at Hogwarts'))
    end
  end

  context 'when using invalid name' do
    it 'creates a group' do
      visit new_group_path
      fill_in 'group[description]', with: 'Hufflepuff students in their seventh year at Hogwarts'

      click_on 'Create Group'
      expect(page).to(have_content('Name can\'t be blank'))
    end
  end

  context 'when using invalid description' do
    it 'creates a group' do
      visit new_group_path
      fill_in 'group[name]', with: 'Year 7 Hufflepuff'

      click_on 'Create Group'
      expect(page).to(have_content('Description can\'t be blank'))
    end
  end
end
