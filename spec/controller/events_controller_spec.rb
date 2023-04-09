require 'rails_helper'
require 'capybara/rspec'

RSpec.describe EventsController, type: :controller do
  let(:event) { Event.create!(name: 'Finals week', description: 'Finals', location: 'Homeroom', start: Time.now.utc, end: Time.now.utc + 1.day) }
  let(:user) { User.create!(email: 'howdy@tamu.edu', full_name: 'Tony Staark', phone_number: '0000000000') }

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

  it 'should create event' do
    expect { post :create, params: { event: { name: 'test event', description: 'test description', location: 'test location', start: Time.now.utc, end: Time.now.utc + 1.day } } }.to change { Event.count }.by(1)
    expect(response).to redirect_to events_url
  end

  it 'should not create event' do
    expect { post :create, params: { event: {name: 'test event', description: nil, location: nil, start: nil, end: Time.now.utc + 1.day } } }.not_to change { Event.count }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'should show event' do
    get :show, params: { id: event.id }
    assert_response :success
  end

  it 'should get edit' do
    get :edit, params: { id: event.id }
    assert_response :success
  end

  it 'should update event' do
    patch :update, params: { id: event.id }
    assert_redirected_to event_url(event)
  end

  it 'should not update event' do
    patch :update, params: { id: event.id, start: nil  }
    assert_response :unprocessable_entity
  end

  # it 'should destroy event' do
  #   assert_difference('Event.count', -1) do
  #     delete event_url(@event)
  #   end

  #   assert_redirected_to events_url
  # end
end
