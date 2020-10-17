json.users do
  json.array! @users do |user|
    json.name user.name
    json.id user.id
    json.avatar user.avatar.nil? ? nil : url_for(user.avatar)
    json.confirmed user.confirmed
    json.blocked user.blocked
    json.role user.role
    json.balance user.balance
    json.email user.email
    json.information user.information
  end
end

json.total User.count