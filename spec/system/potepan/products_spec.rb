require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxon1) { create(:taxon) }
  let(:taxon2) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon1], option_types: [option_type1, option_type2], variants: [variant1]) }
  let!(:product2) { create(:product, taxons: [taxon1], option_types: [option_type2]) }
  let!(:related_product) { create(:product, taxons: [taxon1]) }
  let!(:ruby_product) { create(:product, name: "RUBY BAG") }
  let!(:rails_product) { create(:product, name: "RAILS BAG") }
  let!(:variant1) { create(:variant, option_values: [option_value2]) }
  let!(:option_type1)  { create(:option_type, presentation: 'Size', position: 1, option_values: [option_value1]) }
  let!(:option_type2)  { create(:option_type, presentation: 'Color', position: 1, option_values: [option_value2]) }
  let!(:option_value1)  { create(:option_value, presentation: 'XL') }
  let!(:option_value2)  { create(:option_value, presentation: 'Red') }

  before do
    visit potepan_product_path(id: product.id)
  end

  it "products show page" do
    expect(page).to have_title "#{product.name} | BIGBAG Store"
    within ".breadcrumb" do
      expect(page).to have_link "Home"
      expect(page).to have_content product.name
    end
    within ".navbar-right" do
      expect(page).to have_link "Home"
    end
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_content product.description
  end

  it "redirect to category page" do
    expect(page).to have_link "一覧ページへ戻る"
    click_link "一覧ページへ戻る"
    expect(current_path).to eq potepan_category_path(taxon1.id)
  end

  it "redirect to related_product page" do
    expect(page).to have_content related_product.display_price
    expect(page).to have_link related_product.name
    click_link related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
  end

  it "User accesses search page" do
    visit search_potepan_products_path(search: "RUBY")
    within ".page-title" do
      expect(page).to have_content("RUBY")
    end
    within ".productsContent" do
      expect(page).to have_link ruby_product.name, href: potepan_product_path(ruby_product.id)
      expect(page).to have_content ruby_product.display_price
      expect(page).not_to have_link rails_product.name, href: potepan_product_path(rails_product.id)
    end
  end
end
