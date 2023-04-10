require 'rails_helper'
require 'capybara/rspec'

RSpec.describe(UsersController, type: :controller) do
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

  # it 'creates user' do
  #   expect { post(:create, params: { user: { email: 'howdy@.gmail.com', full_name: 'Tony Staark', phone_number: '0000000000' } }) }.to(change(User, :count).by(1))
  #   expect(response).to(redirect_to(user_url))
  # end

  it 'does not create user' do
    expect { post(:create, params: { user: { email: 'howdy@gmail.com', full_name: nil, phone_number: nil } }) }.not_to(change(User, :count))
    expect(response).to(have_http_status(:unprocessable_entity))
  end

  it 'shows user' do
    get :show, params: { id: user.id }
    assert_response :success
  end

  it 'gets edit' do
    get :edit, params: { id: user.id }
    assert_response :success
  end

  # it 'updates user' do
  #   patch :update, params: { id: user.id }
  #   assert_redirected_to user_url(user)
  # end

  # it 'does not update user' do
  #   patch :update, params: { id: user.id }
  #   assert_response :unprocessable_entity
  # end

  # it 'should destroy user' do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
