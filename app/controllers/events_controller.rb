require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # private_constant
  CALENDAR_ID = 'c_6fa3a48d19f0d7d599da305fe3e3b26ca3ed3102a85a870552b0f4dbf80c0c07@group.calendar.google.com'.freeze
  private_constant :CALENDAR_ID

  # GET /events or /events.json
  def index
    @current_id = User.where('email' => current_admin.email).first
    @events = Event.all
    @user_event_array = Event.select('id').joins(:event_members).where('event_members.user_id' => @current_id.id).to_a.map(&:id)

    # add to env later
    @calendar_url = 'https://calendar.google.com/calendar/embed?src=c_6fa3a48d19f0d7d599da305fe3e3b26ca3ed3102a85a870552b0f4dbf80c0c07%40group.calendar.google.com&ctz=America%2FChicago'
  end

  # GET /events/1 or /events/1.json
  def show
    # on showing event, get user names that belong to that event, and make global variable to be used in html
    @users = User.select('full_name').joins(:event_members).where('event_members.event_id' => params[:id])
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    unless @event.valid?
      respond_to do |format|
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
      return
    end

    begin
      # create event in google calendar
      client = get_google_calendar_client(current_admin)

      if client.blank?
        flash[:error] = 'Failed to create the client. Your token has been expired. Please login again with google.'
        redirect_to('/admins/sign_out')
        return
      end

      google_event = create_google_event(@event)

      if google_event.blank?
        flash[:error] = 'Failed to create google event.'
        redirect_to(new_event_url)
        return
      end

      result, err = client.insert_event(CALENDAR_ID, google_event)

      if err.present?
        flash[:error] = 'Failed to insert google event into calendar.'
        redirect_to(new_event_url)
        return
      end

      @event.google_event_id = result.id
    rescue StandardError => e
      flash[:error] = 'Error occurred. Contact admin for details.'
      if e.message == 'Unauthorized'
        redirect_to('/admins/sign_out')
      else
        redirect_to(new_event_url)
      end
      return
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to(events_url, info: 'Successfully created a new event.') }
        format.json { render(:show, status: :created, location: @event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    updated_event = Event.new(event_params)

    begin
      # create event in google calendar
      client = get_google_calendar_client(current_admin)

      if client.blank?
        flash[:error] = 'Your token has been expired. Please login again with google.'
        redirect_to('/admins/sign_out')
        return
      end

      google_event = create_google_event(updated_event)

      if google_event.blank?
        flash[:error] = 'Failed to update google event.'
        redirect_to(new_event_url)
        return
      end

      _result, err = client.update_event(CALENDAR_ID, @event.google_event_id, google_event)

      if err.present?
        flash[:error] = 'Failed to update google event in calendar.'
        redirect_to(event_url)
        return
      end
    rescue StandardError => _e
      flash[:error] = 'Error occurred. Contact admin for details.'
      redirect_to(event_url)
      return
    end

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to(events_url, info: 'Successfully updated event.') }
        format.json { render(:show, status: :ok, location: @event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    begin
      # create event in google calendar
      client = get_google_calendar_client(current_admin)

      if client.blank?
        flash[:error] = 'Your token has been expired. Please login again with google.'
        redirect_to('/admins/sign_out')
        return
      end

      result, err = client.delete_event(CALENDAR_ID, @event.google_event_id)

      if err.present? || result.present?
        flash[:error] = 'Failed to delete google event into calendar.'
        redirect_to(event_url)
        return
      end
    rescue StandardError => _e
      flash[:error] = 'Error occurred. Contact admin for details.'
      redirect_to(event_url)
      return
    end

    @event.destroy!

    respond_to do |format|
      format.html { redirect_to(events_url, info: 'Successfully deleted event.') }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:name, :start, :end)
  end

  def create_google_event(event)
    Google::Apis::CalendarV3::Event.new(
      summary: event.name,
      description: event.name,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.start.in_time_zone('Central Time (US & Canada)').to_datetime,
        time_zone: 'UTC'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.end.in_time_zone('Central Time (US & Canada)').to_datetime,
        time_zone: 'UTC'
      ),
      anyone_can_add_self: true,
      attendees_omitted: false,
      created: DateTime.now,
      notification_settings: {
        notifications: [{ type: 'event_cancellation', method: 'email' }]
      }
    )
  end

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new

    access_token = current_user.access_token
    refresh_token = current_user.refresh_token

    begin
      return if current_user.blank? || access_token.blank? || refresh_token.blank?

      secrets = Google::APIClient::ClientSecrets.new({
        'web' => {
          'access_token' => access_token,
          'refresh_token' => refresh_token,
          'client_id' => ENV.fetch('GOOGLE_OAUTH_CLIENT_ID', nil),
          'client_secret' => ENV.fetch('GOOGLE_OAUTH_CLIENT_SECRET', nil)
        }
      }
                                                    )

      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'

      if current_user.blank?
        client.authorization.refresh!
        current_user.update!(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: Integer(client.authorization.expires_at, 10)
        )
        current_user.save!
      end
    rescue StandardError => _e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to('/admins/sign_out')
    end
    client
  end
end
