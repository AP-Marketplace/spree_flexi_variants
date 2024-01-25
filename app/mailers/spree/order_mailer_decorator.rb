module Spree::OrderMailerDecorator
  def self.prepended(base)
    base.helper Spree::BaseHelper
  end
end

Spree::OrderMailer.prepend ::Spree::OrderMailerDecorator
