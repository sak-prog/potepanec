require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:taxon2) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:product) { create(:product, taxons: [taxon1], option_types: [option_type_color]) }
  let!(:other_color_product) { create(:product, taxons: [taxon1]) }
  let(:option_type_color) { create(:option_type, presentation: "Color", option_values: [option_value_color]) }
  let(:option_value_color) { create(:option_value, name: "Red") }

  before do
    visit potepan_category_path(id: taxon1.id)
  end

  it "category show page" do
    expect(page).to have_title "#{taxon1.name} | BIGBAG Store"
    within ".breadcrumb" do
      expect(page).to have_link "Home"
      expect(page).to have_content taxon1.name
    end
    within ".navbar-right" do
      expect(page).to have_link "Home"
    end
    within ".side-nav" do
      expect(page).to have_content taxon1.name
      expect(page).to have_content taxonomy.name
      expect(page).to have_content "(#{taxon1.products.count})"
    end
    within ".productBox", match: :first do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
    end
    expect(page).to have_content other_color_product.name
  end

  it "redirect to product page" do
    expect(page).to have_link product.name
    click_link product.name
    expect(current_path).to eq potepan_product_path(product.id)
  end

  it "other product is not show category page" do
    visit potepan_category_path(id: taxon2.id)
    expect(page).not_to have_content product.name
    expect(page).not_to have_content product.display_price
  end

  it "filter by color" do
    within ".filter-by-color" do
      expect(page).to have_content("Red(1)")
      click_link "Red"
    end
    expect(page).to have_content product.name
    expect(page).not_to have_content other_color_product.name
  end
end
