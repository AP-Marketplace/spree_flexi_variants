module Spree
  module Admin
    class VariantConfigurationsController < BaseController
      helper 'spree/products'

      def configure
        @variant = Variant.find(params[:variant_id])

        respond_to do |wants|
          wants.js { render '/spree/shared/variant_configurations/configure' }
        end
      end
    end
  end
end
