module Spree
  module V2
    module Storefront
      class AdHocOptionTypeSerializer < BaseSerializer
        set_type :ad_hoc_option_type

        attributes :price_modifier_type, :is_required, :position, :option_type, :ad_hoc_option_values
      end
    end
  end
end
