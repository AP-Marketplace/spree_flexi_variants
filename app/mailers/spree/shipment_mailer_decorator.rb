module Spree::ShipmentMailerDecorator
  def self.prepended(base)
    base.helper Spree::BaseHelper
  end
end

Spree::OrderMailer.prepend ::Spree::ShipmentMailerDecorator
