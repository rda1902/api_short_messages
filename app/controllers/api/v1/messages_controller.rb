module Api
  module V1
    class MessagesController < ApiController

      before_action :token_authentication, only: :create

      def index
        hash = ActiveModelSerializers::SerializableResource.new(Message.all).as_json
        render json: hash
      end

      def create
        result = CreateMessage.call(message_params: message_params, current_user: @current_user)
        return render json: { errors: result.errors }, status: 400 if result.failure?
        hash = ActiveModelSerializers::SerializableResource.new(result.message).as_json
        render json: hash
      end

      private

      def message_params
        params.require(:messages).permit(:text)
      end

    end
  end
end
