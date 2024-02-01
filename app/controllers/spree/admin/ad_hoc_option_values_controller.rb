module Spree
  module Admin
    class AdHocOptionValuesController < ResourceController
      def update_positions
        update_positions_params

        respond_to do |format|
          format.js { render text: 'Ok' }
        end
      end

      def destroy
        ad_hoc_option_value = find_ad_hoc_option_value
        ad_hoc_option_value.destroy
        redirect_to edit_admin_product_ad_hoc_option_type_path(
          ad_hoc_option_value.ad_hoc_option_type.product_id,
          ad_hoc_option_value.ad_hoc_option_type_id)
      end

      private

      def update_positions_params
        params[:positions].each do |id, index|
          Spree::AdHocOptionValue.where(id: id).update_all(position: index)
        end
      end

      def find_ad_hoc_option_value
        Spree::AdHocOptionValue.find(params[:id])
      end
    end
  end
end
