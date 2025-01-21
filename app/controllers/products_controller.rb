class ProductsController < ApplicationController
    # before_action :authorized
    def index
        user = current_user
        puts 'id.....',user
        @products = Product.where.not(user_id:user)
        if @products
            render json: { products: @products, message: "Product fetched successfully" }, status: :ok
        else
            render json: { products: [], message: "Product fetched successfully" }, status: :ok

        end

    end
    def create
        puts "params",validate_product
        @product=Product.new(validate_product)
        user_id = current_user
        @product.user_id = user_id
        if @product.save
            render json: {message:"Product created successfully"}, status: :created
        else
            render json:{message:"Unsuccessfull"}, status: :unprocessable_entity

        end


    end
    def destroy
        puts ",,,,,", params
        @product = Product.find(params[:id])
        if @product
            @product.destroy
            render json:{message:"Deleted Successfully"},status: :ok
        else
            render json:{message:"Unsuccessfull"},status: :unprocessable_entity
        end

    end
    def my_products
        user = current_user
        @products = Product.where(user_id:user)
        render json: { products: @products, message: "My Product fetched successfully" }, status: :ok

    end
    def search_categories
        query= params[:query]
        user = current_user
        @products = Product.where(category:query).where.not(user_id: user)
        render json: {products: @products},status: :ok

    end

    private

    def validate_product
        
        params.require(:product).permit(:name,:description,:price,:category,:image)

    end
end
