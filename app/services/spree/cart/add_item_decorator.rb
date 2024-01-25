module Spree::Cart::AddItemDecorator
  private
  #this whole thing needs a refactor!

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
                                        variant: variant,
                                        options: opts)

      product_customizations_values = options[:product_customizations] || []
      line_item.product_customizations = product_customizations_values
      product_customizations_values.each { |product_customization| product_customization.line_item = line_item }
      product_customizations_values.map(&:save) # it is now safe to save the customizations we built

      # find, and add the configurations, if any.  these have not been fetched from the db yet.              line_items.first.variant_id
      # we postponed it (performance reasons) until we actually know we needed them
      ad_hoc_option_value_ids = ( !!options[:ad_hoc_option_values] ? options[:ad_hoc_option_values] : [] )
      product_option_values = ad_hoc_option_value_ids.map do |cid|
        AdHocOptionValue.find(cid) if cid.present?
      end.compact
      line_item.ad_hoc_option_values = product_option_values

      offset_price = product_option_values.map(&:price_modifier).compact.sum + product_customizations_values.map {|product_customization| product_customization.price(variant)}.compact.sum
      if order.currency
        line_item.currency = order.currency unless order.currency.nil?
        line_item.price    = variant.price_in(order.currency).amount + offset_price
      else
        line_item.price    = variant.price + offset_price
      end
    else
      line_item.quantity += quantity.to_i
    end

    line_item.target_shipment = options[:shipment] if options.key? :shipment
    line_item.public_metadata = public_metadata.to_h if public_metadata
    line_item.private_metadata = private_metadata.to_h if private_metadata

    return failure(line_item) unless line_item.save

    line_item.reload.update_price

    ::Spree::TaxRate.adjust(order, [line_item]) if line_item_created
    success(order: order, line_item: line_item, line_item_created: line_item_created, options: options)
  end
end
Spree::Cart::AddItem.prepend Spree::Cart::AddItemDecorator