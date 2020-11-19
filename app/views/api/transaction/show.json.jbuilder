json.partial! 'api/services/service', service: @transaction.service

json.petition do
  json.additional_information @transaction.additional_information
  json.status @transaction.status
  json.datetime @transaction.datetime.to_i
  json.duration @transaction.duration
  json.id @transaction.id
end