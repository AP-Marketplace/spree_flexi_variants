module Spree
  class Calculator
    class AmountTimesConstant < Calculator
      preference :multiplier, :decimal

      preference :min_amount, :integer, default: 0
      preference :max_amount, :integer, default: 100

      #attr_accessible :preferred_multiplier, :preferred_min_amount, :preferred_max_amount

      def self.description
        "Amount Times Constant Calculator"
      end

      def self.register
        super
        ProductCustomizationType.register_calculator(self)
      end

      def create_options
        # This calculator knows that it needs one CustomizableOption named amount
        [
         CustomizableProductOption.create(name: "amount", presentation: "Amount")
        ]
      end

      def compute(product_customization, variant=nil)
        return 0 unless valid_configuration? product_customization

        opt = product_customization.customized_product_options.first
        opt.value.to_i * preferred_multiplier
      rescue
        0.0
      end

      def calculate(value = nil)
        value.to_i * preferred_multiplier
      rescue
        0.0
      end

      def valid_configuration?(product_customization)
        true
      end
    end
  end
end
