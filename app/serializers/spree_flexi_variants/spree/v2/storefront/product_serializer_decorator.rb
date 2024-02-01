module SpreeFlexiVariants
  module Spree
    module V2
      module Storefront
        module ProductSerializerDecorator
          def self.prepended(base)
            base.has_many :ad_hoc_option_types,
                          serializer: ::Spree::V2::Storefront::AdHocOptionTypeSerializer

            base.has_many :product_customization_types,
                          serializer: ::Spree::V2::Storefront::ProductCustomizationTypeSerializer

            base.has_many :ad_hoc_variant_exclusions,
                          serializer: ::Spree::V2::Storefront::AdHocVariantExclusionSerializer
          end 
        end
      end
    end
  end
end

::Spree::V2::Storefront::ProductSerializer.prepend ::SpreeFlexiVariants::Spree::V2::Storefront::ProductSerializerDecorator
