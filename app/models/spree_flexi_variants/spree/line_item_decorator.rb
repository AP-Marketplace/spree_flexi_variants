module SpreeFlexiVariants
  module Spree
    module LineItemDecorator
      def self.prepended(base)
        base.has_many :ad_hoc_option_values_line_items, dependent: :destroy
        base.has_many :ad_hoc_option_values, through: :ad_hoc_option_values_line_items
        base.has_many :product_customizations, dependent: :destroy
      end

      def cost_price
        (variant.cost_price || 0) + ad_hoc_option_values.map(&:cost_price).inject(0, :+)
      end

      def cost_money
        Spree::Money.new(cost_price, currency: currency)
      end

      def update_price
        currency_price = variant.price_in(order.currency)

        offset_price = self.ad_hoc_option_values.map(&:price_modifier).compact.sum + self.product_customizations.map {|product_customization| product_customization.price(variant)}.compact.sum

        self.price = if currency_price.amount.present?
                       currency_price.price_including_vat_for(tax_zone: tax_zone) + offset_price
                     else
                       0
                     end
      end
    end
  end
end

::Spree::LineItem.prepend SpreeFlexiVariants::Spree::LineItemDecorator
