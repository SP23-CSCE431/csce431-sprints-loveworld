require 'rails_helper'
require 'capybara/rspec'

RSpec.describe EventMembersController, type: :controller do
  let(:event) { Event.create!(name: 'Finals week', start: Time.now.utc, end: Time.now.utc + 1.day) }
  let(:user) { User.create!(email: 'howdy@gmail.com', full_name: 'Tony Staark', phone_number: '0000000000') }
  # let(:event_member) { EventMember.create!(user: user, event: event) }

  before(:each) do 
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_admin).and_return(user)

    default_url_options[:host] = 'localhost:3000'
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
    expect { post :create, params: { event_member: { event_id: event.id, user_id: user.id } } }.to change { EventMember.count }.by(1)
    expect(response).to redirect_to event_member_url(EventMember.last)
  end

  it 'should not create event_member' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end

  it 'should show event_member' do
    get event_member_url(@event_member)
    assert_response :success
  end

  it 'should get edit' do
    get edit_event_member_url(@event_member)
    assert_response :success
  end

  it 'should update event_member' do
    patch event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: @event_member.user_id } }
    assert_redirected_to event_member_url(@event_member)
  end

  it 'should not update event' do
    patch event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: nil } }
    assert_response :unprocessable_entity
  end

  it 'should destroy event_member' do
    assert_difference('EventMember.count', -1) do
      delete event_member_url(@event_member)
    end

    assert_redirected_to event_members_url
  end

  ###

  it 'should not create event_member with invalid user_id' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end

  it 'should not create event_member with invalid event_id' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    end

    assert_response :unprocessable_entity
  end

  it 'should return all event members in index action' do
    get event_members_url
    expect(EventMember.all.count).to(eq(assigns(:event_members).count))
  end

  it 'should not update event_member with invalid user_id' do
    patch event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    assert_response :unprocessable_entity
  end

  it 'should not update event_member with invalid event_id' do
    patch event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    assert_response :unprocessable_entity
  end

  it 'should view event_member details' do
    get event_member_url(@event_member)
    expect(@event_member).to(eq(assigns(:event_member)))
  end

  it 'should edit event_member' do
    get edit_event_member_url(@event_member)
    assert_response :success
  end

  it 'should not destroy event_member with invalid user_id' do
    assert_no_difference('EventMember.count') do
      delete event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    end

    assert_response :unprocessable_entity
  end

  it 'should not destroy event_member with invalid event_id' do
    assert_no_difference('EventMember.count') do
      delete event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end
end
