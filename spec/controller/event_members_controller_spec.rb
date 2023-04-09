require 'rails_helper'
require 'capybara/rspec'

RSpec.describe EventMembersController, type: :controller do
  let(:event) { Event.create!(name: 'Finals week', start: Time.now.utc, end: Time.now.utc + 1.day) }
  let(:user) { User.create!(email: 'howdy@gmail.com', full_name: 'Tony Staark', phone_number: '0000000000') }
  let(:user2) { User.create!(email: 'howdy@tamu.com', full_name: 'Tony Stark', phone_number: '0000010000') }
  let(:event_member) { EventMember.create!(user: user2, event: event) }

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

  it 'should create event_member' do
    expect { post :create, params: {  event_id: event.id, user_id: user.id  } }.to change { EventMember.count }.by(1)
    expect(response).to redirect_to events_url
  end

  it 'should not create event_member' do
    expect {
      post :create, params: { event_id: nil, user_id: nil  }
    }.not_to change { EventMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should show event_member' do
    get :show, params: { id: event_member.id }
    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { id: event_member.id }
    assert_response :success
  end

  it 'should update event_member' do
    patch :update, params: { id: event_member.id  }
    assert_redirected_to event_member_url(event_member)
  end

  it 'should not update event' do
    patch :update, params: { id: event_member.id, event_id: nil }
    assert_response :unprocessable_entity
  end

  it 'should destroy event_member' do
    expect { post :create, params: {  event_id: event.id, user_id: user.id  } }.to change { EventMember.count }.by(1)
    expect { delete :destroy, params: { id: event_member.id } }.to change { EventMember.count }.by(-1)
    expect(response).to redirect_to events_url
  end

  it 'should not create event_member with invalid user_id' do
    expect {
      post :create, params: { event_id: event.id, user_id: nil  }
    }.not_to change { EventMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should not create event_member with invalid event_id' do
    expect {
      post :create, params: { event_id: nil, user_id: user.id  }
    }.not_to change { EventMember.count }
  
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should return all event members in index action' do
    get :index
    expect(EventMember.all.count).to(eq(assigns(:event_members).count))
  end

  it 'should not update event_member with invalid user_id' do
    patch :update, params: { id: event_member.id, user_id: nil }
    assert_response :unprocessable_entity
  end

  it 'should not update event_member with invalid event_id' do
    patch :update, params: { id: event_member.id, event_id: nil }
    assert_response :unprocessable_entity
  end

  it 'should view event_member details' do
    get :show, params: { id: event_member.id }
    expect(event_member).to(eq(assigns(:event_member)))
  end

  it 'should edit event_member' do
    get :edit, params: { id: event_member.id}
    assert_response :success
  end
end
