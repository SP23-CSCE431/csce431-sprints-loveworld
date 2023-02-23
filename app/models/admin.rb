class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # return nil unless email =~ /@gmail.com || @tamu.edu\z/
    Rails.logger.debug('before ')
    Rails.logger.debug(email)
    Rails.logger.debug(full_name)
    Rails.logger.debug(uid)
    Rails.logger.debug(avatar_url)
    Rails.logger.debug('after')
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end
