class RequestsController < ApplicationController


    def create
        @request = Request.new(validate_request)
        user = current_user
        @request.user_id = user
        @request.status = "pending"
        if @request.save
         render json:{ message: "Request send successfully" },status: :ok
        else
           render json: { message: "Request unsuccessfull" },status: :unprocessable_entity
        end
      end

      private
      def validate_request
        puts params
        params.require(:product).permit(:product_id, :request_amount)
      end
end
