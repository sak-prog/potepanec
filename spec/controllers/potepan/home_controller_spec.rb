require 'rails_helper'

RSpec.describe Potepan::HomeController, type: :controller do
  describe "GET #index" do
    let!(:product_1) { create(:product, available_on: 1.day.ago) }
    let!(:product_2) { create(:product, available_on: 2.day.ago) }
    let!(:product_3) { create(:product, available_on: 3.day.ago) }
    let!(:product_4) { create(:product, available_on: 4.day.ago) }
    let!(:product_5) { create(:product, available_on: 5.day.ago) }
    let!(:product_6) { create(:product, available_on: 6.day.ago) }
    let!(:product_7) { create(:product, available_on: 7.day.ago) }
    let!(:product_8) { create(:product, available_on: 8.day.ago) }
    let!(:product_9) { create(:product, available_on: 9.day.ago) }

    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render the :index template" do
      expect(response).to render_template :index
    end

    it "assigns @new_products" do
      expect(assigns(:new_products).first).to eq product_1
    end

    it "shows 8 new_products" do
      expect(assigns(:new_products).length).to eq 8
    end
  end
end
