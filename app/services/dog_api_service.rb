class DogApiService
  require "net/http"
  require "json"

  DOG_API_URL = "https://dog.ceo/api/breeds/image/random".freeze

  private_class_method
  def self.call_random_dog_image
    uri = URI(DOG_API_URL)
    Net::HTTP.get(uri)
  end

  def self.get_random_dog_image
    response = call_random_dog_image
    parsed_response = JSON.parse(response, symbolize_names: true)
    if parsed_response[:status] == "success"
      parsed_response[:message]
    else
      raise "Error calling dog API: #{parsed_response[:message]}"
    end
  end
end
