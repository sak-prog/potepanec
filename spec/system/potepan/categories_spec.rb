require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:product) { create(:product, taxons: [taxon]) }

  before do
    visit potepan_category_path(id: taxon.id)
  end

  it "categories show page" do
    expect(page).to have_title "#{taxon.name} | BIGBAG Store"
    within ".breadcrumb" do
      expect(page).to have_link "Home"
      expect(page).to have_content taxon.name
    end
    within ".navbar-right" do
      expect(page).to have_link "Home"
    end
    within ".side-nav" do
      expect(page).to have_content taxon.name
      expect(page).to have_content taxonomy.name
      expect(page).to have_content "(#{taxon.products.count})"
    end
    within ".productBox" do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
    end
  end

  it "redirect to product page" do
    expect(page).to have_link product.name
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end
end
