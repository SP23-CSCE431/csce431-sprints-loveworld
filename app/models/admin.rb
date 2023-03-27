class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:, access_token:, refresh_token:, expires_at:)
    create_with(uid:, full_name:, avatar_url:, access_token:, refresh_token:, expires_at:).find_or_create_by!(email:)
  end
end
