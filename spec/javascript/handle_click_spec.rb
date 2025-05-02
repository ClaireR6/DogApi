require "rails_helper"
require "webmock/rspec"

RSpec.describe HomeController, type: :request do
    describe "GET #handle_click" do
      let(:fake_image_url) { "https://example.com/dog.jpg" }

      before do
        # Stub the service for all tests except the error handling one
        allow(DogApiService).to receive(:get_random_dog_image).and_return(fake_image_url)
      end

      it "renders the correct template" do
        get handle_click_path, headers: { "ACCEPT" => "text/javascript" }
        expect(response).to render_template(:handle_click)
      end

      it "assigns @image_url" do
        get handle_click_path
        expect(assigns(:image_url)).not_to be_nil
      end

      it "handles errors gracefully" do
        allow(DogApiService).to receive(:get_random_dog_image).and_raise(StandardError.new("API error"))
        get handle_click_path
        expect(flash[:error]).to eq("Failed to fetch a dog image. Please try again.")
      end
    end
end
