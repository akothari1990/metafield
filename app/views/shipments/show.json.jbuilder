json.array! @shipment.fedex_rates.each do |rate|
  json.shipping do
    json.service_name rate.service_name
    json.price number_to_currency(rate.price.to_f / 100)
  end 
end