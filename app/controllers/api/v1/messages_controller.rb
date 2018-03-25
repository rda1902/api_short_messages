module Api
  module V1
    class MessagesController < ApiController

      before_action :token_authentication, only: :create

      def index
        hash = ActiveModelSerializers::SerializableResource.new(Message.all).as_json
        render json: hash
      end

      def create
        message = Message.new(message_params)
        message.user = @current_user
        return render json: { errors: message.errors }, status: 400 unless message.save
        hash = ActiveModelSerializers::SerializableResource.new(message).as_json
        render json: hash
      end

      private

      def message_params
        params.require(:messages).permit(:text)
      end

    end
  end
end
