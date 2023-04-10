require 'rails_helper'
require 'capybara/rspec'

RSpec.describe(GroupsController, type: :controller) do
  let(:group) { Group.create!(name: 'Finals week', description: 'Finals') }
  let(:user) { User.create!(email: 'howdy@tamu.edu', full_name: 'Tony Staark', phone_number: '0000000000') }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    allow(request.env['warden']).to(receive(:authenticate!).and_return(user))
    allow(controller).to(receive(:current_admin).and_return(user))

    default_url_options[:host] = 'test.host'
  end

  it 'gets index' do
    get :index
    expect(response).to(render_template(:index))
  end

  it 'gets new' do
    get :new
    expect(response).to(render_template(:new))
  end

  it 'creates group' do
    expect { post(:create, params: { group: { name: 'test group', description: 'test description' } }) }.to(change(Group, :count).by(1))
    expect(response).to(redirect_to(group_url(Group.all.last)))
  end

  it 'does not create group' do
    expect { post(:create, params: { group: { name: 'test group', description: nil } }) }.not_to(change(Group, :count))
    expect(response).to(have_http_status(:unprocessable_entity))
  end

  it 'shows group' do
    get :show, params: { id: group.id }
    assert_response :success
  end

  it 'gets edit' do
    get :edit, params: { id: group.id }
    assert_response :success
  end

  # it 'should update group' do
  #   patch :update, params: { id: group.id }
  #   assert_redirected_to group_url(group)
  # end

  # it 'should not update group' do
  #   patch :update, params: { id: group.id }
  #   assert_response :unprocessable_entity
  # end

  # it 'should destroy group' do
  #   assert_difference('Group.count', -1) do
  #     delete group_url(@group)
  #   end

  #   assert_redirected_to groups_url
  # end
end
