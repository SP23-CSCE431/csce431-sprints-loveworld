require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Reply') do
    context 'when using valid input' do
        it 'creates a reply' do
          visit new_reply_path
          fill_in 'reply[body]', with: 'This is an example reply.'
    
          click_on 'Create Reply'
          visit replies_path
          expect(page).to(have_content('This is an example reply.'))
        end
    end

    context 'when using invalid body' do
        it 'creates a reply' do
          visit new_reply_path
    
          click_on 'Create Reply'
          
          expect(page).to(have_content('All data fields must be filled out.'))
        end
    end
end