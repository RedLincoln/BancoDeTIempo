json.services do
  json.array! @services.map do |service|
    json.name service.name
    json.description service.description
    json.id service.id
    json.category service.category.name

    json.partial! 'api/user/owner', service: service
  end
end


json.total @total

