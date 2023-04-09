require 'rails_helper'
require 'capybara/rspec'

RSpec.describe EventsController, type: :controller do
  let(:event) { Event.create!(name: 'Finals week', start: Time.now.utc, end: Time.now.utc + 1.day) }
  let(:user) { User.create!(email: 'howdy@gmail.com', full_name: 'Tony Staark', phone_number: '0000000000') }

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
    expect { post :create, params: { event: { name: 'test event', start: Time.now.utc, end: Time.now.utc + 1.day } } } .to change { Event.count }.by(1)
    expect(response).to redirect_to events_url
  end

  it 'should not create event' do
    expect { post :create, params: { name: 'test event', start: nil, end: Time.now.utc + 1.day } }.to change { Event.count }.by(0)
    expect(response).to redirect_to new_events_url
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
    patch :update, params: { id: event.id  }
    assert_redirected_to event_url(event)
  end

  it 'should not update event' do
    patch :update, params: { id: event.id, start: nil  }
    assert_redirected_to event_url(event)
  end

  # it 'should destroy event' do
  #   assert_difference('Event.count', -1) do
  #     delete event_url(@event)
  #   end

  #   assert_redirected_to events_url
  # end
end
