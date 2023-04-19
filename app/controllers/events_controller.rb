require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

class EventsController < ApplicationController
  include EventsHelper
  before_action :set_event, only: %i[show edit update destroy]


  # GET /events or /events.json
  def index
    @current_id = User.where('email' => current_admin.email).first.id
    @events = Event.all
    @user_event_array = EventMember.where('user_id' => @current_id).to_a
    @calendar_url = ENV.fetch('GOOGLE_CALENDAR_URL', nil)
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
      client = fetch_client

      if client.blank?
        flash[:error] = 'Failed to fetch google service account. Contace admin for help.'
        redirect_to(new_event_url)
        return
      end

      google_event = create_google_event(@event)

      if google_event.blank?
        flash[:error] = 'Failed to create google event.'
        redirect_to(new_event_url)
        return
      end

      result, err = client.insert_event(ENV.fetch('GOOGLE_CALENDAR_ID', nil), google_event)

      if err.present?
        flash[:error] = 'Failed to insert google event into calendar.'
        redirect_to(new_event_url)
        return
      end

      @event.google_event_id = result.id
    rescue StandardError => _e
      flash[:error] = 'Error occurred. Contact admin for details.'
      redirect_to(new_event_url)
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
      client = fetch_client

      if client.blank?
        flash[:error] = 'Cannot access google service account. Contact admin for help.'
        redirect_to(event_url)
        return
      end

      google_event = create_google_event(updated_event)

      if google_event.blank?
        flash[:error] = 'Failed to update google event.'
        redirect_to(event_url)
        return
      end

      _result, err = client.update_event(ENV.fetch('GOOGLE_CALENDAR_ID', nil), @event.google_event_id, google_event)

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
      client = fetch_client

      if client.blank?
        flash[:error] = 'Failed to fetch google service account. Contact admin for help.'
        redirect_to(event_url)
        return
      end

      _result, err = client.delete_event(ENV.fetch('GOOGLE_CALENDAR_ID', nil), @event.google_event_id)

      if err.present?
        flash[:error] = 'Failed to delete google event from calendar.'
        redirect_to(event_url)
        return
      end
    rescue StandardError => _e
      # we dont error out here or return, we want to delete the event on our database if we can.
      flash[:error] = 'Potentially failed to delete google event from calendar. ----------------'
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
    params.require(:event).permit(:name, :description, :location, :start, :end)
  end
end
