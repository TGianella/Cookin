require 'rails_helper'

RSpec.describe "Masterclasses", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/masterclasses/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/masterclasses/show"
      expect(response).to have_http_status(:success)
    end
  end

end
