require 'rails_helper'
require 'capybara/rspec'

RSpec.describe('Reply') do
  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    visit '/'
    click_on 'Sign in with Google'
  end

  context 'when using valid input' do
    it 'creates a reply' do
      fake_user = Rails.application.env_config['omniauth.auth']

      user = User.create!({ 'full_name' => fake_user.info.name, 'email' => fake_user.info.email, 'phone_number' => '0123456789' })
      post = Post.create!({ 'title' => 'Example post.', 'body' => 'This is an example post.', 'user_id' => user.id })

      visit new_reply_path
      fill_in 'reply[body]', with: 'This is an example reply.'
      fill_in 'reply[user_id]', with: user.id
      fill_in 'reply[post_id]', with: post.id
      click_on 'Create Reply'

      visit replies_path
      expect(page).to(have_content('This is an example reply.'))
    end
  end

  context 'when using invalid body' do
    it 'creates a reply' do
      fake_user = Rails.application.env_config['omniauth.auth']

      user = User.create!({ 'full_name' => fake_user.info.name, 'email' => fake_user.info.email, 'phone_number' => '0123456789' })
      post = Post.create!({ 'title' => 'Example post.', 'body' => 'This is an example post.', 'user_id' => user.id })

      visit new_reply_path
      fill_in 'reply[user_id]', with: user.id
      fill_in 'reply[post_id]', with: post.id

      click_on 'Create Reply'

      expect(page).to(have_content('Body can\'t be blank'))
    end
  end
end
