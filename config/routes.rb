Rails.application.routes.draw do

  # forward non-namespaced routes to api namespace
  get 'auth/params' => "api/auth#auth_params"
  post "auth/sign_in" => "api/auth#sign_in"
  if ENV['REGISTERING_ALLOWED'] then post "auth" => "api/auth#register" end
  post "auth/update" => "api/auth#update"
  post "auth/change_pw" => "api/auth#change_pw"

  post "items/sync" => "api/items#sync"
  post "items/backup" => "api/items#backup"

  delete "items" => "api/items#destroy"

  resources "items", :controller => "api/items"

  # legacy support for clients which hardcoded the "api" path to the base url (iOS)
  namespace :api, defaults: {format: :json} do
    get 'auth/params' => "auth#auth_params"
    post "auth/sign_in" => "auth#sign_in"
    if ENV['REGISTERING_ALLOWED'] then post "auth" => "auth#register" end
    post "auth/change_pw" => "auth#change_pw"
    post "items/sync" => "items#sync"
  end

end
