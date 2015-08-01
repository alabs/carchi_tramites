json.array!(@inscriptions) do |inscription|
  json.extract! inscription, :id, :event_id, :first_name, :last_name, :phone, :email
  json.url inscription_url(inscription, format: :json)
end
