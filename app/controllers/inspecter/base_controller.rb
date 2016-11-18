class Inspecter::BaseController < ApplicationController
  layout 'inspecter'

  before_action :authenticate_user!

  def dashboard
    @farms = Farm.all
  end
end
