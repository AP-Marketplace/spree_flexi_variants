require_dependency 'spree/calculator'

module Spree
  class Calculator::CustomizationImage < Calculator
    preference :price, :decimal
    #attr_accessible :preferred_price, :decimal

    def self.description
      "Product Customization Image Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named customization_image
      [
       CustomizableProductOption.create(name: "customization_image", presentation: "Customization Image")
      ]
    end

    def compute(product_customization,variant=nil)
      return 0 unless valid_configuration? product_customization

      # expecting only one CustomizedProductOption
      opt = product_customization.customized_product_options.first

      if opt && opt.customization_image?
        preferred_price
      else
        0.00   # no image was uploaded
      end
    rescue
      0.00
    end

    def valid_configuration?(product_customization)
      true
    end
  end
end
