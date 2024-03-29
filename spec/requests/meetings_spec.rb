require 'rails_helper'

RSpec.describe "Meetings", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/meetings/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/meetings/show"
      expect(response).to have_http_status(:success)
    end
  end

end
