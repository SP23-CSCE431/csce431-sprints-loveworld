require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Post') do
    context 'when using valid input' do
        it 'creates a post' do
          visit new_post_path
          fill_in 'post[title]', with: 'Example post.'
          fill_in 'post[body]', with: 'This is an example post.'
    
          click_on 'Create Post'
          visit posts_path
          expect(page).to(have_content('Example post.'))
          expect(page).to(have_content('This is an example post.'))
        end
    end

    context 'when using invalid title' do
        it 'creates a post' do
          visit new_post_path
          fill_in 'post[body]', with: 'This is an example post.'
    
          click_on 'Create Post'
          
          expect(page).to(have_content('All data fields must be filled out.'))
        end
    end

    context 'when using invalid body' do
        it 'creates a post' do
          visit new_post_path
          fill_in 'post[title]', with: 'Example post.'
    
          click_on 'Create Post'
          
          expect(page).to(have_content('All data fields must be filled out.'))
        end
    end
end