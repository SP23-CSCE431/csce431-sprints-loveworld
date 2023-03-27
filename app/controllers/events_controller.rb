require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  CALENDAR_ID = 'primary'

  # GET /events or /events.json
  def index
    @current_id = User.where('email' => current_admin.email).first
    @events = Event.all
    @user_event_array = Event.select('id').joins(:event_members).where('event_members.user_id' => @current_id.id).to_a.map(&:id)

    user_email = ERB::Util.url_encode(current_admin.email)
    @calendar_url = "https://calendar.google.com/calendar/embed?src=c_6fa3a48d19f0d7d599da305fe3e3b26ca3ed3102a85a870552b0f4dbf80c0c07%40group.calendar.google.com&ctz=America%2FChicago"
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

    # create event in google calendar
    client = get_google_calendar_client current_admin

    google_event = create_google_event @event

    client.insert_event('primary', google_event)

    respond_to do |format|
      if @event.save
        format.html { redirect_to(events_url, notice: 'Event was successfully created.') }
        format.json { render(:show, status: :created, location: @event) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to(event_url(@event), notice: 'Event was successfully updated.') }
        format.json { render(:show, status: :ok, location: @event) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
        format.json { render(json: @event.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to(events_url, notice: 'Event was successfully destroyed.') }
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

  def create_google_event event
    event = Google::Apis::CalendarV3::Event.new(
      summary: event.name,
      location: '',
      description: event.name,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.start.to_s,
        time_zone: 'America/Chicago'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.end.to_s,
        time_zone: 'America/Chicago'
      ),
      recurrence: [
        'RRULE:FREQ=DAILY;COUNT=1'
      ],
      attendees: []
    )
  end

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new

    puts current_admin.methods
    puts "howdy ----"
    access_token = "here"
    refresh_token = "here"

    return unless (current_user.present? && access_token.present? && refresh_token.present?)
    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => access_token,
        "refresh_token" => refresh_token,
        "client_id" => "AIzaSyBXzTYpS3QHGVI5cYrMx4vOy39Nh0Gqz6E", # TODO: replace
        "client_secret" => "477074288964-jq2ouosnb87921jtofeuh23so0d0eej5.apps.googleusercontent.com" # TODO: replace
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if !current_user.present?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to :back
    end
    client
  end
end
