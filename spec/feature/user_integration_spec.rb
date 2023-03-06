require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('User', type: :controller) do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_on 'Sign in with Google'

    fake_user = Rails.application.env_config['omniauth.auth']

    visit new_user_path
    fill_in 'user[full_name]', with: fake_user.info.name
    fill_in 'user[email]', with: fake_user.info.email
    fill_in 'user[phone_number]', with: '0123456789'
    click_on 'Create User'
  end

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
end
