Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    # get "/first_contact_url" => "contacts#first_contact_method"
    # get "/second_contact_url" => "contacts#second_contact_method"
    # get "/third_contact_url" => "contacts#third_contact_method"
    get "/contacts" => "contacts#index"
    post "/contacts" => "contacts#create"
    get "/contacts/:id" => "contacts#show"
    patch "/contacts/:id" => "contacts#update"
    delete "/contacts/:id" => "contacts#destroy"

    post "/users" => "users#create"
  end
end
