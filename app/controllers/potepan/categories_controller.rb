class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:root)
    @colors = Spree::OptionValue.option_values_all("Color")

    if params[:color].present?
      @products = Spree::Product.filter_by_taxon(@taxon).filter_by_option_value(params[:color])
    else
      @products = Spree::Product.filter_by_taxon(@taxon)
    end
  end
end
