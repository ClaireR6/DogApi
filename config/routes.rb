Rails.application.routes.draw do
  get "handle_click", to: "home#handle_click"
  root "home#index"
end
