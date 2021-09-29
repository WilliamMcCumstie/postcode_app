require 'rails_helper'

RSpec.describe "Postcodes", type: :request do
  describe "GET /postcodes/:code" do
    it 'congratulates known postcodes' do
      post "/postcodes", params: { code: Settings.allowed_postcodes.first}
      expect(response).to render_template(:show)
      expect(response.body).to include("Congratulations")
    end

    it 'is sorry for unknown postcodes' do
      post "/postcodes", params: { code: "OX1 1AA"}
      expect(response).to render_template(:show)
      expect(response.body).to include("Sorry")
    end
  end
end
