require 'rails_helper'

RSpec.describe "Home", type: :system do
  let(:taxon) { create(:taxon) }
  let!(:new_product) { create(:product, available_on: 1.day.ago, taxons: [taxon]) }

  before do
    visit potepan_root_path
  end

  it "products show page" do
    expect(page).to have_title "Home | BIGBAG Store"
    within ".featuredProductsSlider" do
      expect(page).to have_content new_product.name
      expect(page).to have_content new_product.display_price
    end
  end

  it "redirect to new_product page" do
    click_link new_product.name
    expect(current_path).to eq potepan_product_path(new_product.id)
  end
end
