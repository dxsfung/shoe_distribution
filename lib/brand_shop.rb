class BrandShop < ActiveRecord::Base 
	belongs_to :shoe_brand
	belongs_to :shoe_shop
end