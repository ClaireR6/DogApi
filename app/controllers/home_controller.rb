class HomeController < ApplicationController
  def index
  end

  def handle_click
    begin
      @image_url = DogApiService.get_random_dog_image
      Rails.logger.debug "FORMAT: #{request.format}"
      respond_to do |format|
        format.js
      end

    rescue StandardError => e
      puts "#{e.message}"
      flash.now[:error] = "Failed to fetch a dog image. Please try again."
      respond_to do |format|
          format.js
      end
    end
  end
end
