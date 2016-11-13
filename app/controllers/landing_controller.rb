class LandingController < ApplicationController
  def home
    redirect_to inspecter_dashboard_path if user_signed_in?
  end
end
