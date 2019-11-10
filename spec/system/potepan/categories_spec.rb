require 'rails_helper'

RSpec.describe "Categories", type: :system do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon1) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:taxon2) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let(:taxon3) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  let!(:product1) { create(:product, taxons: [taxon1]) }
  let!(:product2)  { create :product,  name: 'Skinny-denim', taxons: [taxon3], option_types: [option_type1, option_type2], variants: [variant1] }
  let!(:variant1)  { create :variant,  option_values: [option_value1, option_value2] }
  let!(:option_type1)  { create(:option_type,  presentation: 'Size', position: 1, option_values: [option_value1]) }
  let!(:option_type2)  { create(:option_type,  presentation: 'Color', position: 1, option_values: [option_value2]) }
  let!(:option_value1) { create(:option_value, presentation: 'XL') }
  let!(:option_value2) { create(:option_value, presentation: 'Red') }
  let!(:other_color_product) { create(:product, taxons: [taxon1]) }

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
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price
    end
    expect(page).to have_content other_color_product.name
  end

  it "redirect to product page" do
    expect(page).to have_link product1.name
    click_link product1.name
    expect(current_path).to eq potepan_product_path(product1.id)
  end

  it "other product is not show category page" do
    visit potepan_category_path(id: taxon2.id)
    expect(page).not_to have_content product1.name
    expect(page).not_to have_content product1.display_price
  end

  it "filter by sort arrivals_desc" do
    select("新着順", from: "sort")
    expect(page).to have_select("sort", selected: "新着順")
  end

  it "filter by sort arrivals_asc" do
    select("古い順", from: "sort")
    expect(page).to have_select("sort", selected: "古い順")
  end

  it "filter by sort low_price" do
    select("安い順", from: "sort")
    expect(page).to have_select("sort", selected: "安い順")
  end

  it "filter by sort high_price" do
    select("高い順", from: "sort")
    expect(page).to have_select("sort", selected: "高い順")
  end

  it "filter by option_values" do
    expect(page).to have_content "サイズから探す"
    expect(page).to have_content "色から探す"
    expect(page).to have_content "XL"
    expect(page).to have_content "Red"
  end
end
