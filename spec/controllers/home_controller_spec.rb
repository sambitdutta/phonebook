require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    
    before do
      @user = FactoryGirl.create(:user)
    end
    
    it "returns http success" do
      sign_in @user
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "returns a 302 response" do
      get :index
      expect(response).to have_http_status "302"
    end
  end

end
