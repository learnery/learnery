json.array!(@topics) do |topic|
  json.extract! topic, :name, :description, :event_id, :suggested_by_id, :presented_by_id
  json.url topic_url(topic, format: :json)
end