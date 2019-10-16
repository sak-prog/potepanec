require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  let(:taxon1) { create(:taxon) }
  let(:taxon2) { create(:taxon) }

  describe 'related_product' do
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

  describe "sort_in_order" do
    let!(:option_type) { create(:option_type) }
    let!(:option_value) { create(:option_value) }
    let!(:variant) { create(:variant, option_values: [option_value], product: old_product) }
    let!(:product) { create(:product, id: 1, taxons: [taxon1], available_on: Time.current.ago(1.hour), price: 10.00) }
    let!(:old_product) { create(:product, id: 2, taxons: [taxon1], available_on: Time.current.ago(2.hour), price: 9.00) }

    it "order by desc" do
      expect(taxon1.all_products.sort_in_order("arrivals_desc").map(&:id)).to eq [1, 2]
    end

    it "order by asc" do
      expect(taxon1.all_products.sort_in_order("arrivals_asc").map(&:id)).to eq [2, 1]
    end

    it "order by price_asc" do
      expect(taxon1.all_products.sort_in_order("low_price").map(&:id)).to eq [2, 1]
    end

    it "order by price_desc" do
      expect(taxon1.all_products.sort_in_order("high_price").map(&:id)).to eq [1, 2]
    end
  end
end
