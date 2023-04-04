require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'GroupController', type: :controller do
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get groups_url
    assert_response :success
  end

  it 'should get new' do
    get new_group_url
    assert_response :success
  end

  it 'should create group' do
    assert_difference('Group.count') do
      post groups_url, params: { group: { description: @group.description, name: @group.name } }
    end

    assert_redirected_to group_url(Group.last)
  end

  it 'should show group' do
    get group_url(@group)
    assert_response :success
  end

  it 'should get edit' do
    get edit_group_url(@group)
    assert_response :success
  end

  it 'should update group' do
    patch group_url(@group), params: { group: { description: @group.description , name: @group.name } }
    assert_redirected_to group_url(@group)
  end

  it 'should destroy group' do
    assert_difference('Group.count', -1) do
      delete group_url(@group)
    end

    assert_redirected_to groups_url
  end
end
