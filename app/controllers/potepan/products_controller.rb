class Potepan::ProductsController < ApplicationController
  MAX_RELATED_PRODUCTS = 4

  def show
    @product = Spree::Product.find(params[:id])
    @related_products = @product.related_products.limit(MAX_RELATED_PRODUCTS)
  end

  def search
    @search_word = params[:search]
    @products = Spree::Product.search(@search_word)
  end
end
