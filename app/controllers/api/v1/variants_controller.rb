class API::V1::VariantsController < ApplicationController
	def create
		shop_url = "https://7d8179f9f2e1b8d8f0de77d4d334cb78:1230bebc99b982c5bf946ee111860e07@nick-90.myshopify.com/admin"
        ShopifyAPI::Base.site = shop_url
        shop = ShopifyAPI::Shop.current

		# Get a specific product
		# new_product = ShopifyAPI::Variant.find(19887283329)
  # 		new_product.option1 = "2ft"
  # 		new_product.option2 = "2ft"
  # 		new_product.option3 = "Silver"
  # 		new_product.save
		

		@variant_get = Variant.find_by_variant_id(variant_params[:variant_id])
		if @variant_get.nil?
			@variant = Variant.new(variant_params)
			respond_to do |format|
		      if @variant.save
		        format.json { render :json => @variant }
		      else
		        format.json { render :json => @variant.errors, status: :unprocessable_entity }
		      end
	    	end
		else	
			respond_to do |format|
				if @variant_get.update_attributes(:wood_type => params[:variant][:wood_type], :type_price => params[:variant][:type_price])
					format.json { render :json => @variant_get }
		      	else
		        	format.json { render :json => @variant_get.errors, status: :unprocessable_entity }
		      	end
		    end	
	    end

	    current_variant = Variant.find_by_variant_id(variant_params[:variant_id])
	    current_variant_price = current_variant.actual_price*current_variant.type_price
	   
	    variant_update = ShopifyAPI::Variant.find(params[:variant][:variant_id])
		variant_update.price = current_variant_price
		variant_update.save

		order_list = ShopifyAPI::Order.find(:all)
		puts "==========order list========="
		puts order_list.inspect
		puts "==================="
		# Create new order
			# order = ShopifyAPI::Order.new(
			#   :line_items => [
			#     ShopifyAPI::LineItem.new(
			#       :quantity => 3,
			#       :variant_id => 19496400257
			#     )
			#   ]
			# )
			# order.save
			# p order
			discount_list = ShopifyAPI::ShippingZone.new(
				"id":240844161,"name":"maldives","countries":[{"id":243053313,"name":"Maldives","tax":0.06,"code":"MV","tax_name":"GST","provinces":[]}],"weight_based_shipping_rates":[{"id":596421633,"weight_low":1000.0,"weight_high":2000.0,"name":"demo","price":"10.00","shipping_zone_id":240844161}],"price_based_shipping_rates":[{"id":26304961,"name":"delivery charge","min_order_subtotal":"200.00","price":"20.00","max_order_subtotal":"400.00","shipping_zone_id":240844161}],"carrier_shipping_rate_providers":[]
				)
			# discount_list.save
			# discount_list.name = 'aks'
			# discount_list.callback_url = 'http:\/\/shippingrateprovider.com'	
			# discount_list.format = 'json'
			# discount_list.service_discovery = true
			discount_list.save
			puts "==========ShippingZone list========="
			puts discount_list.inspect
			puts "==================="
			

			blog = ShopifyAPI::Blog.new
			blog.title = "Expert"
			blog.save
			# p blog

			# article = ShopifyAPI::Article.new
			# article.title = "what is your name?"
			# article.author = "John Smith"
			# article.tags = "This Post, Has Been Tagged"
			# article.body_html = "<h1>I like articles<\/h1>\n<p><strong>Yea<\/strong>, I like posting them through <span class=\"caps\">REST<\/span>.<\/p>"
			# article.published = false
			# article.save
			# p article
	end

	private

	def variant_params
		params.require(:variant).permit(:actual_price, :wood_type, :type_price, :variant_id)
	end
end
