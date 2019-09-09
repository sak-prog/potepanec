require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:product) { create(:product) }

  before do
    visit potepan_product_path(id: product.id)
  end

  it "products show page" do
    expect(page).to have_title "#{product.name} | BIGBAG Store"
    within(".breadcrumb") do
      expect(page).to have_link "Home"
      expect(page).to have_content product.name
    end
    within(".navbar-right") do
      expect(page).to have_link "Home"
    end
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_content product.description
  end
end
