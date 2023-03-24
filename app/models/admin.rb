class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # return nil unless email =~ /@gmail.com || @tamu.edu\z/
    create_with(uid:, full_name:, avatar_url:).find_or_create_by!(email:)
  end
end
