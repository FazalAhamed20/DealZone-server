class UsersController < ApplicationController
    def create
        existing_user = User.find_by(email: validate_user_params[:email])

        if existing_user
            render json: { message: "User Already exist" }, status: :unprocessable_entity
        else
            @user = User.new(validate_user_params)
            if @user.save
              @token = encode_token(user_id: @user.id)
              response.headers['Authorization'] = "#{@token}"
              render json: { user: { _id: @user.id, email: @user.email, username: @user.username }, message: "Created successfully" }, status: :created
            else
              render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            end

        end
    end

    private

    def validate_user_params
      params.require(:user).permit(:email, :password, :username)
    end
end
