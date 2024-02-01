module Spree
  module V2
    module Storefront
      class AdHocOptionTypeSerializer < BaseSerializer
        set_type :ad_hoc_option_type

        attributes :option_type, :price_modifier_type, :is_required, :position, :ad_hoc_option_values

      end
    end
  end
end
