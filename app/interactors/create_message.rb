class CreateMessage

  include Interactor

  def call
    message = Message.new(context.message_params)
    message.user = context.current_user
    if message.save
      context.message = message
    else
      context.errors = message.errors
      context.fail!(message: "create_user.failure")
    end
  end

end
