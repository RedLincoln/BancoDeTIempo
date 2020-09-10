class CreateMessages
  attr_accessor :author, :service_petition, :message_content, :message

  def initialize(author:, service_petition:, message:)
    @author = author
    @message_content = message
    @service_petition = service_petition
  end

  def build
    @message = Message.new(author: @author, service_petition: @service_petition, message: @message_content)
  end

end