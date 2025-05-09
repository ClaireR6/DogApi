require "rails_helper"
require "webmock/rspec"

RSpec.describe HomeController, type: :request do
    describe "GET #handle_breeds" do
      let(:fake_dog_breed_list) {  [ "bulldog", "poodle" ] }
      before do
        # Stub the service for all tests except the error handling one
        allow(DogApiService).to receive(:get_breed_array).and_return(fake_dog_breed_list)
      end

      it "renders the correct template" do
        get handle_breeds_path, headers: { "ACCEPT" => "text/javascript" }
        expect(response).to render_template(:handle_breeds)
      end

      it "assigns @breeds" do
        get handle_breeds_path
        expect(assigns(:breeds)).not_to be_nil
      end

      it "handles errors gracefully" do
        allow(DogApiService).to receive(:get_breed_array).and_raise(StandardError.new("API error"))
        get handle_breeds_path
        expect(flash[:error]).to eq("Failed to fetch dog breeds. Please try again.")
      end
    end
end
