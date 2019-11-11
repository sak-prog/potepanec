require 'rails_helper'

RSpec.describe Potepan::OrdersController, type: :controller do
  let!(:store) { create(:store) }

  describe "GET #edit" do
    let!(:order) { create(:order, guest_token: "abc") }

    before do
      cookies.signed[:guest_token] = "abc"
      get :edit
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "view edit" do
      expect(response).to render_template :edit
    end

    it "assigns @order" do
      expect(assigns(:order)).to eq order
    end
  end

  describe "GET #update" do
    let!(:order) { create(:order_with_line_items) }
    let!(:line_item) { order.line_items.first }
    let! :order_params do
      { order: { line_items_attributes: { quantity: 2, id: line_item.id } }, number: line_item.order.number }
    end

    it "update quantity" do
      expect(line_item.quantity).to eq(1)
      patch :update, params: order_params
      line_item.reload
      expect(line_item.quantity).to eq(2)
    end
  end
end
