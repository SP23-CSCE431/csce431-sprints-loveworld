class ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  protect_from_forgery with: :exception, prepend: true
  add_flash_types :info, :error, :warning
end
