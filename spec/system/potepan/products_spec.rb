require 'rails_helper'

RSpec.describe "Products", type: :system do
  let(:product) { create(:product) }

  before do
    visit potepan_product_path(id: product.id)
  end

  it "products show page" do
    expect(page).to have_title "#{product.name} | BIGBAG Store"
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_content product.description
  end

  it "redirects to potepan_root_path when 'Home' is clicked in light section" do
    within(".breadcrumb") do
      click_link "Home"
      expect(current_path).to eq potepan_root_path
    end
  end

  it "redirects to potepan_root_path when 'Home' is clicked in header section" do
    within(".navbar-right") do
      click_link "Home"
      expect(current_path).to eq potepan_root_path
    end
  end

  it "redirects to potepan_root_path when 'logo' is clicked in header section" do
    within(".navbar-header") do
      click_link "logo"
      expect(current_path).to eq potepan_root_path
    end
  end
end
