class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    @current_id = User.where('email' => current_admin.email).first
    @events = Event.all
    @user_event_array = Event.select('id').joins(:event_members).where('event_members.user_id' => @current_id.id).to_a.map(&:id)

    user_email = ERB::Util.url_encode(current_admin.email)
    @calendar_url = "https://calendar.google.com/calendar/embed?src=#{user_email}&ctz=America%2FChicago"
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
end