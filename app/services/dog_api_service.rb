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

  def self.get_breed_data
    uri = URI("https://dog.ceo/api/breeds/list/all")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response, symbolize_names: true)
    if parsed_response[:status] == "success"
      parsed_response[:message]
    else
      raise "Error calling dog API: #{parsed_response[:message]}"
    end
  end

  def self.get_breed_array
    breeds = get_breed_data

    # Flatten the data into a single array
    breeds_array = breeds.flat_map do |breed, subbreeds|
      if subbreeds.any?
        subbreeds.map { |subbreed| "#{subbreed} #{breed}" }
      else
        breed.to_s
      end
    end
    breeds_array
  end
end
