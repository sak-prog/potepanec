class Potepan::HomeController < ApplicationController
  MAX_NEW_PRODUCTS = 8

  def index
    @new_products = Spree::Product.includes(master: [:default_price, :images]).order(available_on: :desc).limit(MAX_NEW_PRODUCTS)
  end
end
