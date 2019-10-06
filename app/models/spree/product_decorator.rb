Spree::Product.class_eval do
  def related_products
    Spree::Product.in_taxons(taxons).includes(master: [:default_price, :images]).distinct.where.not(id: id)
  end

  def self.count_products_with_option_value(taxon, option_value)
    Spree::Product.in_taxon(taxon).includes(option_types: :option_values).where(spree_option_values: { name: option_value }).count
  end

  scope :filter_by_taxon, -> (taxon) { in_taxon(taxon).includes(master: [:default_price, :images]).includes(option_types: :option_values).distinct }

  scope :filter_by_option_value, -> (value) do
    includes(master: [:default_price, :images]).includes(option_types: :option_values).where(spree_option_values: { name: value })
  end
end
