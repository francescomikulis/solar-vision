json.array!(@appliances) do |appliance|
  json.extract! appliance, :id, :name, :power, :average_time, :all_day
  json.url appliance_url(appliance, format: :json)
end
