module Spree
  module Admin
    class VariantConfigurationsController < BaseController
      helper 'spree/products'

      def configure
        load_variant
        respond_to { |wants| wants.js { render 'spree/shared/variant_configurations/configure' } }
      end

      private

      def load_variant
        @variant = Variant.find(params[:variant_id])
      end
    end
  end
end
