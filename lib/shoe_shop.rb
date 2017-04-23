class ShoeShop < ActiveRecord::Base
	has_many :brand_shops
	has_many :shoe_brands, through: :brand_shops
end