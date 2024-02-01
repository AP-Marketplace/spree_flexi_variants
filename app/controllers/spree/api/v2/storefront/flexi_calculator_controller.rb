module Spree
  module Api
    module V2
      module Storefront
        class FlexiCalculatorController < ::Spree::Api::V2::ResourceController

          def calculate
            calculator = Spree::Calculator.find_by(type: params[:calculator])

            result = calculator.calculate(params[:value])

            render_serialized_payload(200) { { result: result } }
          rescue 
            render_error_payload(result)
          end
        end
      end
    end
  end
end
