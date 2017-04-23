class CreateBrandShops < ActiveRecord::Migration
  def change
  	create_table(:brand_shops) do |t|
        t.column(:shoe_shop_id, :integer)
        t.column(:shoe_brand_id, :integer)
        t.timestamps
      end
  end
end
