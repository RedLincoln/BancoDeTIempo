json.petitions do
  json.array! @transactions.map do |transaction|
    json.service do
      json.name transaction.service.name
      json.id transaction.service.id
    end

    json.additional_information transaction.additional_information
    json.status transaction.status
    json.datetime transaction.datetime.to_i
    json.datetime "#{transaction.date_format} #{transaction.duration_range}"
    json.duration transaction.duration
    json.is_client @user.have_transaction_as_client?(transaction)

    json.owner do
      json.name transaction.service.user.name
      json.id transaction.service.user.id
    end

    json.client do
      json.name transaction.client.name
      json.id transaction.client.id
    end
  end
end