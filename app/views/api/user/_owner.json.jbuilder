json.owner do
  json.name service.user.name
  json.role service.user.role
  json.id service.user.id
  json.information service.user.information
  json.avatar url_for(service.user.avatar)
end