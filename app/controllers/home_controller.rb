class HomeController < ApplicationController
  def index
  end

  def handle_random_dog_image
    puts request.format
    begin
      @image_url = DogApiService.get_random_dog_image
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

  def handle_breeds
    puts "HERE!"
    begin
      @breeds = DogApiService.get_breed_array
      respond_to do |format|
        format.js
      end

    rescue StandardError => e
      puts "#{e.message}"
      flash.now[:error] = "Failed to fetch dog breeds. Please try again."
      respond_to do |format|
          format.js
      end
    end
  end
end
