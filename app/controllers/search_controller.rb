class SearchController < ApplicationController
  def index
    query = params[:query]
    user = current_user
    puts "search",user
    @results = Product.includes(:requests)
    .where("name ILIKE '%#{query}%'")
    .where.not(user_id: user)
    .where.not(id: Request.where(user_id: user).where.not(status:"rejected").select(:product_id))

    if @results
      render json: @results
    else
      render json: []
    end
  end

  def my_product_search
    query = params[:query]
    user = current_user
    @results = Product.where("name ILIKE '%#{query}%'").where(user_id:user)
    if @results
      render json: @results
    else
      render json: []
    end
  end
end


def category_search

end
