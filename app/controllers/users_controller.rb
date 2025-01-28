class UsersController < Clearance::UsersController
  def form_authenticity_token; end
    def create
        existing_user = User.find_by(email: validate_user_params[:email])
        if existing_user
            render json: { message: "User Already exist" }, status: :conflict
        else
            @user = User.new(validate_user_params)
            if @user.save
              sign_in(@user)
              render json: { user: { _id: @user.id, email: @user.email, username: @user.username }, message: "Created successfully" }, status: :created
            else
              render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
            end

        end
    end

    private

    def validate_user_params
      puts params
      params.require(:user).permit(:email, :password, :username)
    end
end
