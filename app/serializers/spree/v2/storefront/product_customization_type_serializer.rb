module Spree
  module V2
    module Storefront
      class ProductCustomizationTypeSerializer < BaseSerializer
        set_type :product_customization_type

        attributes :customizable_product_options

        attribute :calculator do |product_customization_type|
          product_customization_type.calculator.type rescue ""
        end
      end
    end
  end
end
