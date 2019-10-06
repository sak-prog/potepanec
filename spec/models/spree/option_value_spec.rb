require 'rails_helper'

RSpec.describe Spree::OptionValue, type: :model do
  let!(:option_type) { create(:option_type, option_values: [option_value], presentation: "Color") }
  let!(:option_value) { create(:option_value) }

  describe "colors" do
    it "matches colors" do
      expect(Spree::OptionValue.option_values_all("Color")).to contain_exactly(option_value)
    end
  end
end
