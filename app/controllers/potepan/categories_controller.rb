class Potepan::CategoriesController < ApplicationController
  helper_method :count_products_with_option_value

  def show
    @taxon = Spree::Taxon.find(params[:id])
    @taxonomies = Spree::Taxonomy.includes(:root)
    @option_types = Spree::OptionType.all
    @products =
      if params[:option].present?
        Spree::Product.filter_by_taxon(@taxon).filter_by_option_value(params[:option])
      elsif params[:sort].present?
        Spree::Product.filter_by_taxon(@taxon).sort_in_order(params[:sort])
      else
        Spree::Product.filter_by_taxon(@taxon).order(available_on: :desc)
      end
  end

  private

  def count_products_with_option_value(option_value)
    Spree::Product.includes(variants: :option_values).in_taxon(@taxon).where(spree_option_values: { name: option_value.name }).count
  end
end
