require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module GreenFarm
  class Application < Rails::Application
    config.eager_load_paths << "#{Rails.root}/lib"

    # api config
    config.api_only = true

    # rack-cors
    # config.middleware.insert_before 0, "Rack::Cors" do
    #   allow do
    #     origins '*'
    #     resource '*', :headers => :any, :methods => [:get, :post, :options, :delete, :put]
    #   end
    # end

    # rack-attack
    # config.middleware.use Rack::Attack

    #assets path bower
    config.assets.paths << Rails.root.join('vendor', 'assets', 'components')

    # timezone config
    config.time_zone = "Hanoi"
  end
end
