require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'UserController', type: :controller do
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get users_url
    assert_response :success
  end

  it 'should get new' do
    get new_user_url
    assert_response :success
  end

  it 'should create user' do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, full_name: @user.full_name, phone_number: @user.phone_number } }
    end

    assert_redirected_to user_url(User.last)
  end

  it 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  it 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end

  it 'should update user' do
    patch user_url(@user), params: { user: { email: @user.email, full_name: @user.full_name, phone_number: @user.phone_number } }
    assert_redirected_to user_url(@user)
  end

  it 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
