require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
require('pry')
require('./lib/shoe_brand')
require('./lib/shoe_shop')
require('./lib/brand_shop')

also_reload('lib/**/*.rb')
require("pg")

get("/") do
    @shoe_brands = ShoeBrand.all
    @shoe_shops = ShoeShop.all
    erb(:index)
end

post("/") do
    name = params.fetch("name").capitalize
    if name != ""
        shoe_brand = ShoeBrand.new({:name => name})
        shoe_brand.save
    end
    @shoe_brands = ShoeBrand.all
    redirect to ('/')
end

get('/about') do
    erb(:about)
end

get('/shoe_brand/:id/edit') do
    @shoe = ShoeBrand.find(params.fetch("id").to_i)
    erb(:shoe_brand_edit)
end

patch("/shoe_brand/:id") do
    name = params.fetch("name").capitalize
    @shoe = ShoeBrand.find(params.fetch("id").to_i)
    @shoe.update({:name => name})
    @shoe_brand = ShoeBrand.all
    redirect to ('/')
end

get("/shoe_brand_info/:id") do
    @shoe = ShoeBrand.find(params.fetch("id").to_i)
    @shoe_shops = ShoeShop.all

    erb(:shoe_brand_info)
end

patch("/shoe_brand_info/:id") do
    shoe_brand_id = params.fetch("id").to_i
    @shoe_brand = ShoeBrand.find(shoe_brand_id)

    shoe_shop_ids = params[:shoe_shops_ids]
    if shoe_shop_ids != nil
        shoe_shop_ids.each do |x|
            shop = ShoeShop.find(x)
            BrandShop.find_or_create_by({:shoe_brand => @shoe_brand, :shoe_shop => shop })
        end
    end

    @shoe_shop = ShoeShop.all
    redirect to("/shoe_brand_info/#{shoe_brand_id}")
end


get("/shoe_shops") do
    @shoe_shops = ShoeShop.all
    erb(:shoe_shops)
end

post("/shoe_shops") do
    shop_name = params.fetch("name").capitalize
    if shop_name != ""
      @shoe_shop = ShoeShop.new({:name => shop_name})
      @shoe_shop.save
    end
    redirect to ('/')
end

get('/shoe_shop/:id/edit') do
    @shoe = ShoeShop.find(params.fetch("id").to_i)
    erb(:shoe_shop_edit)
end

delete('/shoe_shop/:id/edit') do
    @shoe_shop = ShoeShop.find(params.fetch("id").to_i)
    @shoe_shop.delete
    @shoe_shops = ShoeShop.all
    redirect to ('/')
end

patch("/shoe_shop/:id") do
    shoe_name = params.fetch("name").capitalize
    @shoe = ShoeShop.find(params.fetch("id").to_i)
    @shoe.update({:name => shoe_name})
    redirect to ('/')
end

get('/shoe_shop_info/:id') do
    @shoe = ShoeShop.find(params.fetch("id").to_i)
    @shoe_brands = ShoeBrand.all
    erb(:shoe_shop_info)
end

patch("/shoe_shop_info/:id") do
    shoe_shop_id = params.fetch("id").to_i
    @shoe_shop = ShoeShop.find(shoe_shop_id)
    shoe_brand_ids = params[:shoe_brands_ids]
    if shoe_brand_ids != nil
        shoe_brand_ids.each do |x|
            brand = ShoeBrand.find(x)
            BrandShop.find_or_create_by({:shoe_brand => brand, :shoe_shop => @shoe_shop })
        end
    end
    @shoe_brand = ShoeBrand.all
    redirect to("/shoe_shop_info/#{shoe_shop_id}")
end
