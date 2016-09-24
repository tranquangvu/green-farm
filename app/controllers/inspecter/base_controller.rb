class Inspecter::BaseController < ApplicationController
  layout 'inspecter'
  before_filter :authenticate_user!
  
  def dashboard
  end
end