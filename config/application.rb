require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module GreenFarm
  class Application < Rails::Application
    config.eager_load_paths << "#{Rails.root}/lib"
  end
end
