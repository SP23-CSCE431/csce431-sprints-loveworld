require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'GroupMemberController', type: :controller do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:group_member) { create(:group_member, user: user, group: group) }
  
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get group_members_url
    assert_response :success
  end

  it 'should get new' do
    get new_group_member_url
    assert_response :success
  end

  it 'should create group_member' do
    assert_difference('GroupMember.count') do
      post group_members_url, params: { group_member: { group_id: @group_member.group_id, user_id: @group_member.user_id } }
    end

    assert_redirected_to group_member_url(GroupMember.last)
  end

  it 'should show group_member' do
    get group_member_url(@group_member)
    assert_response :success
  end

  it 'should get edit' do
    get edit_group_member_url(@group_member)
    assert_response :success
  end

  it 'should update group_member' do
    patch group_member_url(@group_member), params: { group_member: { group_id: @group_member.group_id, user_id: @group_member.user_id } }
    assert_redirected_to group_member_url(@group_member)
  end

  it 'should destroy group_member' do
    assert_difference('GroupMember.count', -1) do
      delete group_member_url(@group_member)
    end

    assert_redirected_to group_members_url
  end
end
