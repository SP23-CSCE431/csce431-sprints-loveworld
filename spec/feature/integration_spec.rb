# location: spec/feature/integration_spec.rb
require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Creating a user', type: :feature do
  scenario 'valid inputs' do
    visit new_user_path
    fill_in "user[full_name]", with: 'harry potter'
    fill_in "user[email]", with: 'harrypotter@mybusiness.com'
    fill_in "user[phone_number]", with: '0123456789'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('harry potter')
    expect(page).to have_content('harrypotter@mybusiness.com')
    expect(page).to have_content('0123456789')
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

RSpec.describe 'Creating a group', type: :feature do
  scenario 'valid inputs' do
    visit new_group_path
    fill_in "group[name]", with: 'Year 7 Hufflepuff'
    fill_in "group[description]", with: 'Hufflepuff students in their seventh year at Hogwarts'
    
    click_on 'Create Group'
    visit groups_path
    expect(page).to have_content('Year 7 Hufflepuff')
    expect(page).to have_content('Hufflepuff students in their seventh year at Hogwarts')
  end
end