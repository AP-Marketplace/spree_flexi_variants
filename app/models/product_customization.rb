class ProductCustomization < ActiveRecord::Base
  belongs_to :product_customization_type
  belongs_to :line_item
  has_many :customized_product_options, :dependent => :destroy

  # TODO: Jeff, add 'required'

  def price
    amount = product_customization_type.calculator.compute(self)
  end

  def calculator
    product_customization_type.calculator
  end
end
