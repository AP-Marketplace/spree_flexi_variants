module Spree
  module Admin
    class AdHocVariantExclusionsController < ResourceController
      before_action :load_product, only: [:index, :new, :create]
      before_action :build_ad_hoc_variant_exclusion, only: :create
      before_action :load_ad_hoc_variant_exclusion, only: :destroy

      def create
        return unless params["ad_hoc_option_type"]

        params["ad_hoc_option_type"].each_pair do |otid, ovid|
          next if ovid.empty?

          ExcludedAdHocOptionValue.create(ad_hoc_variant_exclusion: @ad_hoc_variant_exclusion, ad_hoc_option_value_id: ovid)
        end

        @ad_hoc_variant_exclusion.product = @product
        @ad_hoc_variant_exclusion.save

        redirect_to admin_product_ad_hoc_variant_exclusions_path(@product)
      end

      def destroy
        @product = @ad_hoc_variant_exclusion.product
        @ad_hoc_variant_exclusion.destroy

        redirect_to admin_product_ad_hoc_variant_exclusions_path(@product), notice: I18n.t("spree.notice_messages.ad_hoc_variant_exclusion_removed")
      end

      private

      def load_product
        @product = Product.friendly.find(params[:product_id])
      end

      def build_ad_hoc_variant_exclusion
        @ad_hoc_variant_exclusion = AdHocVariantExclusion.new
      end

      def load_ad_hoc_variant_exclusion
        @ad_hoc_variant_exclusion = AdHocVariantExclusion.find(params[:id])
      end
    end
  end
end
