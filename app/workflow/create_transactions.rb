class CreateTransactions
  attr_accessor :datetime, :addition_information, :service, :client, :transaction

  def initialize(datetime: '', addition_information: '', service_id: -1, client: nil)
    @datetime = datetime
    @addition_information = addition_information
    @service = get_service(service_id)
    @client = client
  end

  def build
    self.transaction = Transaction.new(datetime: @datetime, addition_information: @addition_information,
                                       service: @service, client: @client)
  end

  private

  def get_service(service_id)
     Service.exists?(service_id) ? Service.find(service_id) : nil
  end
end