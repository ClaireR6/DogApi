Rails.application.routes.draw do
  get "handle_random_dog_image", to: "home#handle_random_dog_image"
  get "handle_breeds", to: "home#handle_breeds"
  root "home#index"
end
