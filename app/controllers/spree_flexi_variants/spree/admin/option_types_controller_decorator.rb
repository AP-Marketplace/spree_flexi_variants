module SpreeFlexiVariants
  module Spree
    module Admin
      module OptionTypesControllerDecorator
        def self.prepended(base)
          base.before_action :load_product_decorator, only: [:select_ad_hoc, :available_ad_hoc]
        end

        def available_ad_hoc
          set_available_ad_hoc_option_types
          render layout: false
        end

        def select_ad_hoc
          ad_hoc_option_type = create_ad_hoc_option_type(params[:id])

          @product.ad_hoc_option_types << ad_hoc_option_type

          redirect_to edit_admin_ad_hoc_option_type_url(ad_hoc_option_type)
        end

        private

        def set_available_ad_hoc_option_types
          @available_option_types = ::Spree::OptionType.all.to_a
          selected_option_types = @product.ad_hoc_option_types.map(&:option_type)
          @available_option_types -= selected_option_types
        end

        def load_product_decorator
          @product = ::Spree::Product.friendly.find(params[:product_id])
        end

        def create_ad_hoc_option_type(option_type_id)
          option_type = ::Spree::OptionType.find(option_type_id)
          ad_hoc_option_type = ::Spree::AdHocOptionType.new(option_type: option_type, position: option_type.position)
        end
      end
    end
  end
end

::Spree::Admin::OptionTypesController.prepend ::SpreeFlexiVariants::Spree::Admin::OptionTypesControllerDecorator
