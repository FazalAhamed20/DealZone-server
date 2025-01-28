class ProductsController < ApplicationController

    before_action :authorized
  
    def index
        user = current_user
        @pagy, @products = pagy(
          Product.includes(:requests)
                 .where.not(user_id: user.id)
                 .order(created_at: :desc)
        )
        render json: {
          products: @products.as_json(include: :requests), 
          pagy: pagy_metadata(@pagy), 
          message: "Products fetched successfully"
        }, status: :ok
      end
    
      
    def create
        @product=Product.new(validate_product)
        user = current_user
        @product.user_id = user.id
        if @product.save
            render json: { message: "Product created successfully" }, status: :created
        else
            render json: { message: "Unsuccessfull" }, status: :unprocessable_entity

        end
    end
    def update
        user_id = current_user
        puts """"
        @product = Product.find(params[:id])
        if @product.update(validate_product)
          render json: { message: "Updated Successfully" }, status: :ok
        else
           render json: { message: "Unsuccessfull" }, status: :unprocessable_entity
        end
      end
    def destroy
        @product = Product.find(params[:id])
        if @product
            @product.destroy
            render json: { message: "Deleted Successfully" }, status: :ok
        else
            render json: { message: "Unsuccessfull" }, status: :unprocessable_entity
        end
    end
    def my_products
        user = current_user
        @pagy,@products = pagy(Product.order(created_at: :desc).where(user_id: user.id))
        @requests = Request.order(created_at: :desc).all
        render json: { products: @products.as_json(include: :requests), requests: @requests.as_json(include: { product: { include: :user } }), pagy: pagy_metadata(@pagy), message: "My Product fetched successfully" }, status: :ok
    end
    def search_categories
        query= params[:query]
        user = current_user
        @products = Product.where(category: query).where.not(user_id: user.id)
        render json: { products: @products.as_json(include: :requests) }, status: :ok
    end

    private

    def validate_product
        puts "params", params
        params.require(:product).permit(:name, :description, :category, :price, :image)
    end
end
