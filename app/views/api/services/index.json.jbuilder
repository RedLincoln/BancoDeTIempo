json.services do
  json.array! @services.map do |service|
    json.name service.name
    json.description service.description
    json.id service.id
    json.category service.category.name

    json.owner do
      json.name service.user.name
      json.role service.user.role
      json.id service.user.id
      json.information service.user.information
      json.avatar url_for(service.user.avatar)
    end
  end
end


json.total @services.count

