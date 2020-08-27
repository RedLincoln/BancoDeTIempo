class CreateTransactions
  attr_accessor :datetime, :addition_information, :service, :client, :success, :transaction

  def initialize(datetime: '', addition_information: '', service_id: -1, client: nil)
    @datetime = datetime
    @addition_information = addition_information
    @service = get_service(service_id)
    @client = client
    @success = false
  end

  def build
    self.transaction = Transaction.new(datetime: @datetime, addition_information: @addition_information,
                                       service: @service, client: @client)
  end

  def create
    build
    @success = transaction.save
  end

  def success?
    @success
  end

  private

  def get_service(service_id)
    Service.exists?(service_id) ? Service.find(service_id) : nil
  end
end