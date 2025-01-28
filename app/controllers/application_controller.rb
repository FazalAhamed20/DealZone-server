require 'pagy'
require 'pagy/extras/metadata'

class ApplicationController < ActionController::API
  include Clearance::Controller
  include Pagy::Backend
  include ActionController::Cookies

  private

  
  def current_user

    if cookies[:remember_token]
      token = cookies[:remember_token]
      @current_user = User.find_by(remember_token: token)
    end
  end

  def authorized
    unless current_user
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
