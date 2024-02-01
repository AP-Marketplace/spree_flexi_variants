module Spree
  module V2
    module Storefront
      class AdHocVariantExclusionSerializer < BaseSerializer
        set_type :ad_hoc_variant_exclusions

        attributes :excluded_ad_hoc_option_values
      end
    end
  end
end
