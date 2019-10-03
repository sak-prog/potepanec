Spree::OptionValue.class_eval do
  scope :option_values_all, -> (value) { includes(:option_type).where(spree_option_types: { presentation: value }) }
end
