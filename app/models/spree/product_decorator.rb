module Spree::ProductDecorator
  def related_products
    Spree::Product.in_taxons(taxons).includes(master: [:default_price, :images]).distinct.where.not(id: id)
  end
  Spree::Product.prepend self
end
