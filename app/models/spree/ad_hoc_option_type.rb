module Spree
  class AdHocOptionType < Spree::Base
    belongs_to :option_type
    belongs_to :product
    # before_save :attach_option_values
    has_many :ad_hoc_option_values, dependent: :destroy
    alias :option_values :ad_hoc_option_values

    accepts_nested_attributes_for :ad_hoc_option_values, allow_destroy: true

    # currently no controller for normal users present
    #attr_accessible :is_required, :ad_hoc_option_values_attributes, :product_id, :option_type_id, :position

    default_scope -> { order(:position) }

    # price_modifier_type
    # is_required
    def has_price_modifier?
      !(price_modifier_type.nil? || price_modifier_type.downcase=~/none/)
    end

    def name
      option_type.name
    end

    def presentation
      option_type.presentation
    end

    def attach_option_values
      self.option_type.option_values.each do |ov|
        ahot = AdHocOptionValue.new()
        ahot.option_value_id = ov.id
        ahot.position = ov.position
        ahot.save
        self.ad_hoc_option_values << ahot
      end
    end
  end
end
