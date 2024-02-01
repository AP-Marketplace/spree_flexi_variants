module Spree
  module V2
    module Storefront
      class AdHocOptionTypeSerializer < BaseSerializer
        set_type :ad_hoc_option_type

        attributes :option_type, :price_modifier_type, :is_required, :position, :ad_hoc_option_values

        # belongs_to :option_type,
        #             serializer: ::Spree::V2::Storefront::OptionTypeSerializer
        # has_many :ad_hoc_option_values,
        #           serializer: ::Spree::V2::Storefront::AdHocOptionValuesSerializer
      end
    end
  end
end
