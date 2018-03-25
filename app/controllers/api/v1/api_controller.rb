module Api
  module V1
    class ApiController < ApplicationController

      respond_to :json
      def token_authentication
        user = authenticate_with_http_token { |t, _o| User.find_by(api_token: t) }
        if user.blank?
          render plain: 'HTTP Token: Access denied.', status: 401
          return
        end
        @current_user = user
      end

    end
  end
end
