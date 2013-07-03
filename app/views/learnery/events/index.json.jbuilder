json.array!(@events) do |event|
  json.extract! event, :name, :starts, :ends, :venue, :description
  json.url event_url(event, format: :json)
end