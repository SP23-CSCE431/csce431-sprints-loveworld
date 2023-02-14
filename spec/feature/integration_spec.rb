# location: spec/feature/integration_spec.rb
require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in "user[full_name]", with: 'harry potter'
    click_on 'Create User'
    expect(page).to have_content('harry potter')
  end
end

RSpec.describe 'Creating a event', type: :feature do
  scenario 'valid inputs' do
    visit new_event_path
    fill_in "event[name]", with: 'Wizarding Magic'
    fill_in "event[start]", with: Time.now
    fill_in "event[end]", with: Time.now + 1.day
    click_on 'Create Event'
    visit events_path
    expect(page).to have_content('Wizarding Magic')
  end
end