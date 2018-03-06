Rails.application.routes.draw do
  get "/first_contact_url" => "contacts#first_contact_method"
  get "/second_contact_url" => "contacts#second_contact_method"
  get "/third_contact_url" => "contacts#third_contact_method"
end
