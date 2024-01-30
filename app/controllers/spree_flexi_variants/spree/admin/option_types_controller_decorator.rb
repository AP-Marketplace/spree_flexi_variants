module SpreeFlexiVariants
  module Spree
    module Admin
      module OptionTypesControllerDecorator
        def self.prepended(base)
          # not sure if I have to repeat the 'before_action' for the original option_types account
          base.before_action :load_product_decorator, only: [:select_ad_hoc, :available_ad_hoc]
        end

        def available_ad_hoc
          set_available_ad_hoc_option_types
          render layout: false
        end

        # AJAX method for selecting an existing option type and associating with the current product
        def select_ad_hoc
          ad_hoc_option_type = AdHocOptionType.new()

          option_type = OptionType.find params[:id]
          ad_hoc_option_type.option_type = option_type
          ad_hoc_option_type.position = option_type.position

          @product.ad_hoc_option_types << ad_hoc_option_type

          redirect_to edit_admin_ad_hoc_option_type_url(ad_hoc_option_type)
        end

        private

        def set_available_ad_hoc_option_types
          @available_option_types = OptionType.all.to_a
          selected_option_types = []
          @product.ad_hoc_option_types.each do |option|
            selected_option_types << option.option_type
          end
          @available_option_types.delete_if {|ot| selected_option_types.include? ot}
        end

        def load_product_decorator
          # load_product # fix in progress https://github.com/spree/spree/pull/6220
          @product = Product.friendly.find(params[:product_id])
        end
      end
    end
  end
end

::Spree::Admin::OptionTypesController.prepend ::SpreeFlexiVariants::Spree::Admin::OptionTypesControllerDecorator
