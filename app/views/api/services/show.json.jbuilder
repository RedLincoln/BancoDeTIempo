json.service do
  json.(@service, :name, :description, :id)
  json.tags @service.tags.map &:name
  json.category @service.category.name
  json.partial! 'api/user/owner', service: @service
end
