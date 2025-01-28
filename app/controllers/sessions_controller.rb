class SessionsController < Clearance::SessionsController
  def create
    @user = User.find_by(email: validate_user_params[:email])
    if @user && @user.authenticated?(validate_user_params[:password])
      sign_in(@user)
      Rails.logger.debug "Cookies: #{response.headers}"

      render json: { user: { _id: @user.id, email: @user.email, username: @user.username }, message: "Login successfully" }, status: :ok
    else
      render json: { user: { message: "Password incorrect" } }, status: :unauthorized
    end
  end
    
    def destroy 
        sign_out 
        cookies.delete(:remember_token, domain: 'localhost')
        render json: { message: "Logged out successfully" }, status: :ok 
    end

    private


    def validate_user_params
      params.require(:user).permit(:email, :password, :username)
    end
end



  # @token = @user.remember_token
            # response.set_cookie(
            #     :token,
            #     {
            #       value: @token,
            #       httponly: true,
            #     }
            #   )