json.user do
  json.(@user, :id, :name, :confirmed,
      :blocked, :role, :balance, :email, :telephone_visible, :email_visible, :telephone)
  json.avatar @user.avatar.nil? ? nil : url_for(@user.avatar)
  json.created_at @user.created_at.to_i
end

json.services do
  json.array! @user.services.map do |service|
    json.(service, :name, :id, :description, :service_type)
    json.category service.category
  end
end
