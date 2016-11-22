class API::V1::ShipmentsController < ApplicationController
	require 'money'
	require 'geokit'
	def index
		@shipments = Shipment.all
		respond_to do |format|
      		format.json { render :json => @shipments }
    	end
	end

	def show
		@shipment = Shipment.find(params[:id])
		user_id = params[:id]
		respond_to do |format|
			@complete_service_json = @shipment.fedex_rates.each do |rate| 
				# service_name = rate.service_name
				# service_price = Money.new(rate.price, rate.currency).format
	      	end
	      	format.json { render :json => @complete_service_json }
      	end
	end

	def new
		@shipment = Shipment.new
	end

	def create
		tp = shipment_params
		postal_code = tp[:postal_code]
		location = geo = Geokit::Geocoders::GoogleGeocoder.geocode(postal_code)
		tp[:city] = location.city
		tp[:state] = location.state
		tp[:country] = location.country
		@shipment = Shipment.new(tp)
		respond_to do |format|
	      if @shipment.save
	        format.json { render :json => @shipment }
	      else
	        format.json { render :json => @shipment.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def edit
		@shipment = Shipment.find(params[:id])
	end

	def update
		@shipment = Shipment.find(params[:id])
		if @shipment.update_attributes(shipment_params)
		  redirect_to @shipment, notice: "The shipment has been successfully updated.  Below are your shipping options."
		else
		  render action: "edit"
		end
	end

	private

	def shipment_params
		params.require(:shipment).permit(:name, :country, :city, :state, :postal_code, :length, :width, :height, :weight, :cylinder)
	end
end
