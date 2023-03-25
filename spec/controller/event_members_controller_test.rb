require 'rails_helper'
require 'capybara/rspec'

class EventMembersControllerTest < ActionDispatch::IntegrationTest
  before do
    @event_member = event_members(:one)
  end

  test 'should get index' do
    get event_members_url
    assert_response :success
  end

  test 'should get new' do
    get new_event_member_url
    assert_response :success
  end

  test 'should create event_member' do
    assert_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: @event_member.event_id, user_id: @event_member.user_id } }
    end

    assert_redirected_to event_member_url(EventMember.last)
  end

  test 'should not create event_member' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show event_member' do
    get event_member_url(@event_member)
    assert_response :success
  end

  test 'should get edit' do
    get edit_event_member_url(@event_member)
    assert_response :success
  end

  test 'should update event_member' do
    patch event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: @event_member.user_id } }
    assert_redirected_to event_member_url(@event_member)
  end

  test 'should not update event' do
    patch event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: nil } }
    assert_response :unprocessable_entity
  end

  test 'should destroy event_member' do
    assert_difference('EventMember.count', -1) do
      delete event_member_url(@event_member)
    end

    assert_redirected_to event_members_url
  end

  ###

  test 'should not create event_member with invalid user_id' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end

  test 'should not create event_member with invalid event_id' do
    assert_no_difference('EventMember.count') do
      post event_members_url, params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should return all event members in index action' do
    get event_members_url
    expect(EventMember.all.count).to(eq(assigns(:event_members).count))
  end

  test 'should not update event_member with invalid user_id' do
    patch event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    assert_response :unprocessable_entity
  end

  test 'should not update event_member with invalid event_id' do
    patch event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    assert_response :unprocessable_entity
  end

  test 'should view event_member details' do
    get event_member_url(@event_member)
    expect(@event_member).to(eq(assigns(:event_member)))
  end

  test 'should edit event_member' do
    get edit_event_member_url(@event_member)
    assert_response :success
  end

  test 'should not destroy event_member with invalid user_id' do
    assert_no_difference('EventMember.count') do
      delete event_member_url(@event_member), params: { event_member: { event_id: nil, user_id: @event_member.user_id } }
    end

    assert_response :unprocessable_entity
  end

  test 'should not destroy event_member with invalid event_id' do
    assert_no_difference('EventMember.count') do
      delete event_member_url(@event_member), params: { event_member: { event_id: @event_member.event_id, user_id: nil } }
    end

    assert_response :unprocessable_entity
  end
end
