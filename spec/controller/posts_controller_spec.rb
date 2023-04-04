require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'PostController', type: :controller do
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get posts_url
    assert_response :success
  end

  it 'should get new' do
    get new_post_url
    assert_response :success
  end

  it 'should create post' do
    assert_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  it 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  it 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  it 'should update post' do
    patch post_url(@post), params: { post: { body: @post.body, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  it 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
