class Potepan::CategoriesController < ApplicationController
  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:root)
    @colors = Spree::OptionValue.option_values_all("Color")

    @products =
      if params[:color].present?
        Spree::Product.filter_by_taxon(@taxon).filter_by_option_value(params[:color])
      elsif params[:sort].present?
        Spree::Product.filter_by_taxon(@taxon).sort_in_order(params[:sort])
      else
        Spree::Product.filter_by_taxon(@taxon).order(available_on: :desc)
      end
  end
end
