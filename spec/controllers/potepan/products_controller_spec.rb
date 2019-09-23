require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let(:taxon) { create(:taxon) }
    let(:product) { create(:product, taxons: [taxon]) }
    let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }

    before do
      get :show, params: { id: product.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render the :show template" do
      expect(response).to render_template :show
    end

    it "assigns @product" do
      expect(assigns(:product)).to eq(product)
    end

    it "shows 4 related_products" do
      expect(assigns(:related_products).length).to eq 4
    end
  end
end
