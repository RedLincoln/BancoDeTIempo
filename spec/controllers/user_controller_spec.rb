require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to be_successful
    end
  end

end
