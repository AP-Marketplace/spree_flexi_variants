module Spree
  module Cart
    module AddItemDecorator
      
      private

      def add_to_line_item(order:, variant:, quantity: nil, public_metadata: {}, private_metadata: {}, options: {})
        options ||= {}
        quantity ||= 1

        line_item = Spree::Dependencies.line_item_by_variant_finder.constantize.new.execute(order: order, variant: variant, options: options)

        line_item_created = line_item.nil?
        if line_item.nil?
          opts = ::Spree::PermittedAttributes.line_item_attributes.flatten.each_with_object({}) do |attribute, result|
            result[attribute] = options[attribute]
          end.merge(currency: order.currency).delete_if { |_key, value| value.nil? }

          line_item = order.line_items.new(quantity: quantity,
                                            variant: variant)
        else
          line_item.quantity += quantity.to_i
        end

        line_item.target_shipment = options[:shipment] if options.key? :shipment
        line_item.public_metadata = public_metadata.to_h if public_metadata
        line_item.private_metadata = private_metadata.to_h if private_metadata

        return failure(line_item) unless line_item.save

        update_flexi_variants(line_item, options, order, variant)

        line_item.reload.update(price: line_item.reload.update_price)

        ::Spree::TaxRate.adjust(order, [line_item]) if line_item_created
        success(order: order, line_item: line_item, line_item_created: line_item_created, options: options)
      end

      def update_flexi_variants(line_item, options, order, variant)
        product_customizations_values = options[:product_customizations] || {}
        update_product_customizations(product_customizations_values, line_item) if product_customizations_values.present?

        ad_hoc_option_value_ids = options[:ad_hoc_option_values] ? options[:ad_hoc_option_values].values : []
        update_ad_hoc_option_values(ad_hoc_option_value_ids, line_item) if ad_hoc_option_value_ids.present?
      end

      def update_ad_hoc_option_values(ad_hoc_option_value_ids, line_item)
        product_option_values = Spree::AdHocOptionValue.where(id: ad_hoc_option_value_ids).compact

        line_item.ad_hoc_option_values = product_option_values
      end

      def update_product_customizations(product_customizations, line_item)
        product_customizations.each do |customization_type_id, customization_pair_value|
          next if customization_pair_value.empty?

          product_customization = line_item.product_customizations.new(product_customization_type_id: customization_type_id.to_i)
          
          if product_customization.save
            customized_product_option = product_customization.customized_product_options.new

            if customization_pair_value.is_a? String
              customized_product_option.value = customization_pair_value
            else
              customized_product_option.value = "" # TODO revisit. What should be here
              customized_product_option.customization_image = customization_pair_value["customization_image"]
            end

            return failure(line_item) unless customized_product_option.save
          else
            return failure(line_item)
          end
        end
      end
    end
  end
end

::Spree::Cart::AddItem.prepend Spree::Cart::AddItemDecorator
