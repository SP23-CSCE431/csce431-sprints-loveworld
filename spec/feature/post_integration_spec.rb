require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Post') do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_on 'Sign in with Google'
  end

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
    it 'fails to create a post' do
      visit new_post_path
      fill_in 'post[body]', with: 'This is an example post.'

      click_on 'Create Post'

      expect(page).to(have_content('Title can\'t be blank'))
    end
  end

  context 'when using invalid body' do
    it 'fails to create a post' do
      visit new_post_path
      fill_in 'post[title]', with: 'Example post.'

      click_on 'Create Post'

      expect(page).to(have_content('Body can\'t be blank'))
    end
  end
end
