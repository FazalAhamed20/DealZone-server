class RequestsController < ApplicationController


  def index
    user = current_user
    @requests = Request.where(user_id:user)
    render json: {requests:@requests.as_json(include: :product), message:"Request fetched successfull"},status: :ok
  end
    def create
        @request = Request.new(validate_request)
        user = current_user
        @request.user_id = user
        @request.status = "pending"
        if @request.save
         render json: { message: "Request send successfully" }, status: :ok
        else
           render json: { message: "Request unsuccessfull" }, status: :unprocessable_entity
        end
    end
    def update
      @request = Request.find(params[:id])
      if params[:product][:action]=="accepted"
       @request.update(status: "accepted")
         render json: {message:"Accepted Successfully"},status: :ok
      elsif params[:product][:action]=="rejected"
         @request.update(status: "rejected")
         render json: {message:"Rejected Successfully"},status: :ok
      else
         render json: {message: "UnSuccessfull"},status: :ok
    end

  end

      private
      def validate_request
        puts params
        params.require(:product).permit(:product_id, :request_amount)
      end
end
