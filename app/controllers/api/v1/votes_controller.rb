module Api
  module V1
    class VotesController < ApiController

      before_action :token_authentication

      def update
        message = Message.find(Message.first.id)
        Vote.touch_vote(message, @current_user)
        head :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "message not found" }
      end

    end
  end
end
