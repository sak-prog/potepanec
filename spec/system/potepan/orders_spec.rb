require 'rails_helper'

describe "Orders", type: :system do
  let!(:store) { create(:store) }
  let(:taxon) { create(:taxon) }
  let!(:product1) { create(:product, name: 'RUBY BAG', taxons: [taxon], price: 100) }
  let!(:product2) { create(:product, name: 'RAILS BAG', taxons: [taxon], price: 200) }

  before do
    visit potepan_product_path(product1.id)
    click_on 'カートに入れる'
    visit potepan_product_path(product2.id)
    click_on 'カートに入れる'
  end

  it "orders edit page" do
    within(".cartListInner") do
      expect(current_path).to eq potepan_cart_path
      expect(page).to have_content "RUBY BAG"
      expect(page).to have_content "RAILS BAG"
      expect(page).to have_content "300"
    end
  end

  it "destroy lineitem" do
    within(".cartListInner") do
      click_on '×', match: :first
      expect(page).not_to have_content "RUBY BAG"
      expect(page).to have_content "RAILS BAG"
      expect(page).to have_content "200"
      click_on '×'
      expect(page).to have_content "カートは空です。"
    end
  end
end
