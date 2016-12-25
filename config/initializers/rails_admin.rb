RailsAdmin.config do |config|
  ## Admin devise auth
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## Change main app name
  config.main_app_name = ["SGardern", "Admin"]

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end
end
