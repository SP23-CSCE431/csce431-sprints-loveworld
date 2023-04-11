require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Event') do
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
    it 'creates an event' do
      visit new_event_path
      fill_in 'event[name]', with: 'Wizarding Magic'
      fill_in 'event[start]', with: Time.now.utc
      fill_in 'event[end]', with: Time.now.utc + 1.day
      click_on 'Create Event'
      expect(page).to(have_content('Wizarding Magic'))
    end
  end

  context 'when using invalid name' do
    it 'creates an event' do
      visit new_event_path
      fill_in 'event[start]', with: Time.now.utc
      fill_in 'event[end]', with: Time.now.utc + 1.day
      click_on 'Create Event'
      expect(page).to(have_content('Name can\'t be blank'))
    end
  end

  context 'when using invalid start time' do
    it 'creates an event' do
      visit new_event_path
      fill_in 'event[name]', with: 'Wizarding Magic'
      fill_in 'event[end]', with: Time.now.utc + 1.day
      click_on 'Create Event'
      expect(page).to(have_content('Start can\'t be blank'))
    end
  end

  context 'when using invalid end time' do
    it 'creates an event' do
      visit new_event_path
      fill_in 'event[name]', with: 'Wizarding Magic'
      fill_in 'event[start]', with: Time.now.utc
      click_on 'Create Event'
      expect(page).to(have_content('End can\'t be blank'))
    end
  end
end
