require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Event') do
  context 'when using valid input' do
    it 'creates an event' do
      visit new_event_path
      fill_in 'event[name]', with: 'Wizarding Magic'
      fill_in 'event[start]', with: Time.now.utc
      fill_in 'event[end]', with: Time.now.utc + 1.day
      click_on 'Create Event'
      visit events_path
      expect(page).to(have_content('Wizarding Magic'))
    end
  end
end
