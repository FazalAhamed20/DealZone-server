class SessionsController < ApplicationController
    def create
       @user = User.find_by(email: validate_user_params[:email])
       puts "hello"

        if @user && @user.authenticated?(validate_user_params[:password])
            @token = encode_token(user_id: @user.id)
            response.headers['Authorization'] = @token
            render json: { user: { _id: @user.id, email: @user.email, username: @user.username }, message: "Login successfully" }, status: :ok
        else
            render json: { user: { message: "Password incorrect" } }, status: :unauthorized
        end
    end
    
    def destroy 
        sign_out 
        puts "after logout"
        render json: { message: "Logged out successfully" }, status: :ok 
    end

    private


    def validate_user_params
      params.require(:user).permit(:email, :password, :username)
      end
end
