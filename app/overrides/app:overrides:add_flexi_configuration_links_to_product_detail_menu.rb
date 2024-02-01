Deface::Override.new(
  virtual_path: "spree/admin/shared/_product_tabs",
  name: "converted_admin_product_tabs_983418929",
  insert_after: "erb[silent]:contains('can?(:admin, Spree::Variant)')",
  partial: "spree/admin/products/additional_product_tabs"
)