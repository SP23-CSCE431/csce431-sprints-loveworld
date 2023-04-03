class DashboardsController < ApplicationController
  skip_before_action :authenticate_admin!
  def show
    if current_admin.present?
      email = current_admin.email
      user = User.where('email' => email).first

      if user.blank?
        flash[:info] = 'New LoveWorld user account created. Click on the \'People\' tab to edit your profile.'
        new_user = User.new

        new_user.email = email
        new_user.full_name = current_admin.full_name
        new_user.phone_number = 'None provided'
        new_user.save!

      end
    end
  end
end
