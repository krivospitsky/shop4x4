json.array!(@manufacturers) do |manufacturer|
  json.extract! manufacturer, :name, :description
  json.url manufacturer_url(manufacturer, format: :json)
end
