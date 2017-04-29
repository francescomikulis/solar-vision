json.array!(@panels) do |panel|
  json.extract! panel, :id, :name, :power
  json.url panel_url(panel, format: :json)
end
