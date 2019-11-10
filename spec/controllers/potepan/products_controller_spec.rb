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

  describe '#search' do
    let!(:products) do
      [
        create(:product, name: "RUBY BAG", description: "This is a ruby bag"),
        create(:product, name: "ROR MUG", description: "This is a ruby on rails mug"),
        create(:product, name: "SHIRT", description: "This is a shirt"),
      ]
    end

    before do
      get :search, params: { search: "RUBY" }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render search view" do
      expect(response).to render_template :search
    end

    it "assigns @products" do
      expect(assigns(:products)).to include products[0]
      expect(assigns(:products)).to include products[1]
      expect(assigns(:products)).not_to include products[2]
    end

    context "when params[:search] has metacharacter" do
      let(:metacharacter_product) { create(:product, name: 'RAILS BAG') }
      let(:no_metacharacter_product) { create(:product, name: 'BAG') }

      before do
        get :search, params: { search: "RAILS" }
      end

      it "has the product includes metacharacter" do
        expect(assigns(:products)).to include(metacharacter_product)
        expect(assigns(:products)).not_to include(no_metacharacter_product)
      end
    end
  end
end
