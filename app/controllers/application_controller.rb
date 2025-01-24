require 'pagy'
require 'pagy/extras/metadata'
class ApplicationController < ActionController::API
  include Clearance::Controller
  include Pagy::Backend
  

  def encode_token(payload)
    JWT.encode(payload, 'fazalahamed123') 
end

def decoded_token
    header = request.headers['Authorization']
    if header
        token = header.split(" ")[1]
        puts "token",token
        begin
            JWT.decode(token, 'fazalahamed123')
        rescue JWT::DecodeError
            nil
        end
    end
end
def current_user
   if decoded_token 
    user_id = decoded_token[0]['user_id'] 
  return user_id
end 
end

def authorized
  unless !!current_user
  render json: { message: 'Please log in' }, status: :unauthorized
  end
end
end
