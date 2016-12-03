class LandingController < ApplicationController
  def home
    if user_signed_in?
      @farm = current_user.farms.first
      redirect_to inspecter_dashboard_path(@farm)
    else
      @contact = Contact.new
    end
  end
end
