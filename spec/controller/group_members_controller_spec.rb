require 'rails_helper'
require 'capybara/rspec'

RSpec.describe GroupMembersController, type: :controller do
  let(:group) { Group.create!(name: 'test group', description: 'test description') }
  let(:user) { User.create!(email: 'howdy@gmail.com', full_name: 'Tony Staark', phone_number: '0000000000') }
  let(:user2) { User.create!(email: 'howdy@tamu.com', full_name: 'Tony Stark', phone_number: '0000010000') }
  let(:group_member) { GroupMember.create!(user: user2, group: group) }
  
  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_admin).and_return(user)

    default_url_options[:host] = 'test.host'
  end

  it 'should get index' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'should get new' do
    get :new
    expect(response).to render_template(:new)
  end

  it 'should create group_member' do
    expect { post :create, params: {  group_id: group.id, user_id: user.id  } }.to change { GroupMember.count }.by(1)
    expect(response).to redirect_to groups_url
  end

  it 'should not create group_member' do
    expect {
      post :create, params: { group_id: nil, user_id: nil  }
    }.not_to change { GroupMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should show group_member' do
    get :show, params: { id: group_member.id }
    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { id: group_member.id }
    assert_response :success
  end

  it 'should update group_member' do
    patch :update, params: { id: group_member.id  }
    assert_redirected_to group_member_url(group_member)
  end

  it 'should not update group' do
    patch :update, params: { id: group_member.id, group_id: nil }
    assert_response :unprocessable_entity
  end

  # it 'should destroy group_member' do
  #   expect { delete :destroy, params: { id: group_member.id } }.to change { GroupMember.count }.by(-1)
  #   expect(response).to redirect_to groups_url
  # end

  it 'should not create group_member with invalid user_id' do
    expect {
      post :create, params: { group_id: group.id, user_id: nil  }
    }.not_to change { GroupMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should not create group_member with invalid group_id' do
    expect {
      post :create, params: { group_id: nil, user_id: user.id  }
    }.not_to change { GroupMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should return all group members in index action' do
    get :index
    expect(GroupMember.all.count).to(eq(assigns(:group_members).count))
  end

  it 'should not update group_member with invalid user_id' do
    patch :update, params: { id: group_member.id, user_id: nil }
    assert_response :unprocessable_entity
  end

  it 'should not update group_member with invalid group_id' do
    patch :update, params: { id: group_member.id, group_id: nil }
    assert_response :unprocessable_entity
  end

  it 'should view group_member details' do
    get :show, params: { id: group_member.id }
    expect(group_member).to(eq(assigns(:group_member)))
  end

  it 'should edit group_member' do
    get :edit, params: { id: group_member.id}
    assert_response :success
  end
end
