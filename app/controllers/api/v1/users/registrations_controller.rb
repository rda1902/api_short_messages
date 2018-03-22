module Api
  module V1
    module Users
      class RegistrationsController < Api::V1::ApiController

        def create
          if (user = User.find_for_authentication(email: user_params[:email]))
            return render json: { errors: user.errors }, status: 403
          end
          user = User.new(user_params)
          return render json: { errors: user.errors }, status: 400 unless user.save
          user.generate_api_token
          hash = ActiveModelSerializers::SerializableResource.new(user).as_json
          render json: hash
        end

        private

        def user_params
          params.require(:users).permit(:email, :password)
        end

      end
    end
  end
end
