require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "GET #show" do
    let(:taxon) { create(:taxon, taxonomy: taxonomy) }
    let(:taxonomy) { create(:taxonomy) }
    let(:product) { create(:product, taxons: [taxon]) }

    before do
      get :show, params: { id: taxon.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "render the :show template" do
      expect(response).to render_template :show
    end

    it 'assigns @taxon' do
      expect(assigns(:taxon)).to eq(taxon)
    end

    it 'assigns @taxonomies' do
      expect(assigns(:taxonomies)).to match_array(taxonomy)
    end

    it 'assigns @products' do
      expect(assigns(:products)).to match_array(product)
    end
  end
end
