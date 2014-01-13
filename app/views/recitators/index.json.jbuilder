json.array!(@recitators) do |recitator|
  json.extract! recitator, :id, :name, :value
  json.url recitator_url(recitator, format: :json)
end
