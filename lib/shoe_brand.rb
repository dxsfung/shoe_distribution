class ShoeBrand < ActiveRecord::Base
	has_many :brand_shops
	has_many :shoe_shops, through: :brand_shops

	
end