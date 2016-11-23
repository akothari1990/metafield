class API::V1::MetafieldsController < ApplicationController
	def index
		shop_url = "https://71ce81d53393533f59abaf2c241ab2b6:c75f792a56754bd4e6bfde1174874e48@napura.myshopify.com/admin"
	    ShopifyAPI::Base.site = shop_url
	    shop = ShopifyAPI::Shop.current


	    @product_list = ShopifyAPI::Metafield.all(params: {resource: 'products', resource_id: 6721712071, fields: 'value'})
	    respond_to do |format|
      		format.json { render :json => @product_list }
    	end	
	 end
end
