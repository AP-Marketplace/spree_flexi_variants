class CreateAdHocVariantExclusions < ActiveRecord::Migration[4.2]
  def self.up
    create_table :ad_hoc_variant_exclusions do |t|
      t.integer :product_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :ad_hoc_variant_exclusions
  end
end
