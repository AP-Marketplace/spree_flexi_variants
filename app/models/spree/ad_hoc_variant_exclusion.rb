module Spree
  class AdHocVariantExclusion < Spree::Base
    belongs_to :product
    has_many :excluded_ad_hoc_option_values, dependent: :destroy
  end
end
