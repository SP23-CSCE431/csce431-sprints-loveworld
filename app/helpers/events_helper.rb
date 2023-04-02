require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'date'
require 'google/api_client/client_secrets'

module EventsHelper
  def fetch_client
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = authorize
    service
  end

  def authorize
    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: StringIO.new(ENV.fetch('GOOGLE_SERVICE_ACCOUNT_JSON', nil)),
      scope: 'https://www.googleapis.com/auth/calendar'
    )
    authorizer.fetch_access_token!
    authorizer
  end

  def create_google_event(event)
    Google::Apis::CalendarV3::Event.new(
      summary: event.name,
      description: event.description,
      location: event.location,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.start.in_time_zone('Central Time (US & Canada)').to_datetime,
        time_zone: 'UTC'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: event.end.in_time_zone('Central Time (US & Canada)').to_datetime,
        time_zone: 'UTC'
      ),
      created: DateTime.now
    )
  end
end
