class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.limit(MAX_RELATED_PRODUCTS)
  end

  def search
    @search_word = params[:search_word]
    @products = Spree::Product.search_word(@search_word)
  end
end
