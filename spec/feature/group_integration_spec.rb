require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Group') do
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
end
