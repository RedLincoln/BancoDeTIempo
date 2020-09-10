class CreateMessages
  attr_accessor :author, :service_petition, :message_content, :success, :message

  def initialize(author:, service_petition:, message:)
    @author = author
    @message_content = message
    @service_petition = service_petition
    @success = false
  end

  def build
    @message = Message.new(author: @author, service_petition: @service_petition, message: @message_content)
  end

  def create
    @success = User.exists?(id: @author.id) && Transaction.exists?(id: @service_petition.id)
    build.save if @success
  end

  def success?
    @success
  end
end