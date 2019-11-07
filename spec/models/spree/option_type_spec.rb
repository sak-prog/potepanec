require 'rails_helper'

RSpec.describe Spree::OptionType, type: :model do
  describe "colors" do
    let!(:option_value) { create(:option_value) }
    let!(:option_type) { create(:option_type, option_values: [option_value], presentation: "Color") }

    it "matches colors" do
      Spree::OptionType.colors == Spree::OptionType.find_by(presentation: 'Color').option_values
    end
  end

  describe "sizes" do
    let!(:option_value) { create(:option_value) }
    let!(:option_type) { create(:option_type, option_values: [option_value], presentation: "Size") }

    it 'matches sizes' do
      Spree::OptionType.sizes == Spree::OptionType.find_by(presentation: 'Size').option_values
    end
  end
end
