require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  describe 'related_product' do
    let(:taxon1) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let!(:product) { create(:product, taxons: [taxon1]) }
    let!(:related_product) { create(:product, taxons: [taxon1]) }
    let!(:other_related_product) { create(:product, taxons: [taxon2]) }

    it "product match related_product" do
      expect(product.related_products).to match_array related_product
    end

    it "product not match other_related_product" do
      expect(product.related_products).not_to match_array other_related_product
    end
  end
end
