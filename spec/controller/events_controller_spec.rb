require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'EventController', type: :controller do
  let(:event) { create(:event) }

  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  it 'should get index' do
    get events_url
    assert_response :success
  end

  it 'should get new' do
    get new_event_url
    assert_response :success
  end

  it 'should create event' do
    assert_difference('Event.count') do
      post events_url, params: { event: { end: @event.end, name: @event.name, start: @event.start } }
    end

    assert_redirected_to event_url(Event.last)
  end

  it 'should not create event' do
    assert_no_difference('Event.count') do
      post events_url, params: { event: { end: nil, name: @event.name, start: @event.start } }
    end

    assert_response :unprocessable_entity
  end

  it 'should show event' do
    get event_url(@event)
    assert_response :success
  end

  it 'should get edit' do
    get edit_event_url(@event)
    assert_response :success
  end

  it 'should update event' do
    patch event_url(@event), params: { event: { end: @event.end, name: @event.name, start: @event.start } }
    assert_redirected_to event_url(@event)
  end

  it 'should not update event' do
    patch event_url(@event), params: { event: { end: nil, name: nil, start: nil } }
    assert_response :unprocessable_entity
  end

  it 'should destroy event' do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
