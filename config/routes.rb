Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      post 'driver/register', to: 'drivers#create'
      post 'driver/:id/sendLocation', to: 'drivers#save_location'
      post 'passenger/available_cabs', to: 'drivers#available_cabs'

    end
  end

end
