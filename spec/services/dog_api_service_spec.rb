require "rails_helper"
require "webmock/rspec"
require_relative "../../app/services/dog_api_service"

RSpec.describe DogApiService, type: :service, wip: true do
  describe "call random dog api" do
    let(:api_url) { "https://dog.ceo/api/breeds/image/random" }

    it "returns a dog image URL when successful" do
      stub_request(:get, api_url).to_return(
        status: 200,
        body: { status: "success", message: "https://example.com/dog.jpg" }.to_json
      )

      result = DogApiService.get_random_dog_image

      expect(result).to eq("https://example.com/dog.jpg")
    end

    it "raises an error when the API request fails" do
        stub_request(:get, api_url).to_return(
          status: 500,
          body: { status: "error", message: "Internal Server Error" }.to_json,
          headers: { "Content-Type" => "application/json" }
        )

        expect { DogApiService.get_random_dog_image }.to raise_error(RuntimeError, "Error calling dog API: Internal Server Error")
      end
  end

  describe "get breed data" do
    let(:breed_list_url) { "https://dog.ceo/api/breeds/list/all" }
    it "returns a list of dog breeds when successful" do
        stub_request(:get, breed_list_url).to_return(
            status: 200,
            body: { status: "success", message: { bulldog: [], poodle: [] } }.to_json
        )

        result = DogApiService.get_breed_data

        expect(result).to eq({ bulldog: [], poodle: [] })
    end

    it "raises an error when the API request fails" do
        stub_request(:get, breed_list_url).to_return(
            status: 500,
            body: { status: "error", message: "Internal Server Error" }.to_json,
            headers: { "Content-Type" => "application/json" }
        )

        expect { DogApiService.get_breed_data }.to raise_error(RuntimeError, "Error calling dog API: Internal Server Error")
    end
  end

  describe "get breed array" do
    let(:fake_breed_data) { { "bulldog" => [], "poodle" => [ "miniature" ] } }

    before do
      # Stub the method get_breed_data to return fake_breed_data
      allow(DogApiService).to receive(:get_breed_data).and_return(fake_breed_data)
    end

    it "returns a flattened array of dog breeds" do
        result = DogApiService.get_breed_array

        # Expected flattened array: ["bulldog", "miniature poodle"]
        expect(result).to eq([ "bulldog", "miniature poodle" ])
      end
  end
end
