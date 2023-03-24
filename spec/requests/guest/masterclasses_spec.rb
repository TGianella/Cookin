require 'rails_helper'

RSpec.describe "Guest::Masterclasses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/guest/masterclasses/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/guest/masterclasses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
