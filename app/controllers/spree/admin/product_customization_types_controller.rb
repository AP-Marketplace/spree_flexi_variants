module Spree
  module Admin
    class ProductCustomizationTypesController < ResourceController
      before_action :load_product, only: [:selected, :available, :remove]
      before_action :load_calculators, only: [:new, :edit]

      def load_calculators
        @calculators = ProductCustomizationType.calculators.sort_by(&:name)
      end

      def edit
        @product_customization_type = find_product_customization_type(params[:id])

        initialize_calculator_default_options if @product_customization_type.customizable_product_options.empty?
      end

      def available
        set_available_product_customization_types
        render layout: false
      end

      def selected
        @product_customization_types = @product.product_customization_types
      end

      def remove
        @product.product_customization_types.delete(@product_customization_type)
        @product.save
        flash.notice = I18n.t("spree.notice_messages.product_customization_type_removed")
        redirect_to selected_admin_product_product_customization_types_url(@product)
      end

      def select
        @product = find_product(params[:product_id])

        @product.product_customization_types << find_product_customization_type(params[:id])
        @product.save
        @product_customization_types = @product.product_customization_types
        set_available_product_customization_types
      end

      protected

      def location_after_save
        if params[:action] == "update"
          admin_product_customization_types_url
        else
          edit_admin_product_customization_type_url(@product_customization_type)
        end
      end

      private

      def load_product
        @product = find_product(params[:product_id])
      end

      def find_product_customization_type(id)
        ProductCustomizationType.find(id)
      end

      def find_product(id)
        Product.friendly.find(id)
      end

      def initialize_calculator_default_options
        return unless @product_customization_type.calculator

        options = @product_customization_type.calculator.create_options
        @product_customization_type.customizable_product_options.concat(options) if options
      end

      def set_available_product_customization_types
        @available_product_customization_types = ProductCustomizationType.all.to_a
        selected_product_customization_types = @product.product_customization_types.to_a
        @available_product_customization_types -= selected_product_customization_types
      end
    end
  end
end
