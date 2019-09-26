require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:taxon) { create(:taxon) }
  let!(:product) { create(:product, taxons: [taxon]) }
  let!(:related_product) { create(:product, taxons: [taxon]) }

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
    expect(current_path).to eq potepan_category_path(taxon.id)
  end

  it "redirect to related_product page" do
    within ".productBox" do
      expect(page).to have_content related_product.display_price
    end
    expect(page).to have_link related_product.name
    click_link related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
  end
end
