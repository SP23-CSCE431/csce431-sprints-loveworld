require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'ReplyController', type: :controller do
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get replies_url
    assert_response :success
  end

  it 'should get new' do
    get new_reply_url
    assert_response :success
  end

  it 'should create reply' do
    assert_difference('Reply.count') do
      post replies_url, params: { reply: { body: @reply.body, post_id: @reply.post_id, user_id: @reply.user_id } }
    end

    assert_redirected_to reply_url(Reply.last)
  end

  it 'should show reply' do
    get reply_url(@reply)
    assert_response :success
  end

  it 'should get edit' do
    get edit_reply_url(@reply)
    assert_response :success
  end

  it 'should update reply' do
    patch reply_url(@reply), params: { reply: { body: @reply.body, post_id: @reply.post_id, user_id: @reply.user_id } }
    assert_redirected_to reply_url(@reply)
  end

  it 'should destroy reply' do
    assert_difference('Reply.count', -1) do
      delete reply_url(@reply)
    end

    assert_redirected_to replies_url
  end
end
