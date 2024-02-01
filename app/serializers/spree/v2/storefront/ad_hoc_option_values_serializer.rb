module Spree
  module V2
    module Storefront
      class AdHocOptionValuesSerializer < BaseSerializer
        set_type :ad_hoc_option_values

        attributes :option_value_id, :price_modifier, :position, :selected, :cost_price_modifier
      end
    end
  end
end
