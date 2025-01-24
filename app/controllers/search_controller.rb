class SearchController < ApplicationController
  def index
    query = params[:query]
    user = current_user
    puts "search",user
    @results = Product.where("name ILIKE '%#{query}%'")
    .where.not(user_id: user)
    if @results
      render json: @results.as_json(include: :requests)
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

  def category_search
    @categories = Product.select(:category).distinct.all
    render json: {categories:@categories , message:"Categories fetched successfully"}, status: :ok
  
  end
  def filter_search
  query = params[:query]
  user = current_user
  if query == "Price: High to Low" 
    @results = Product.order(price: :desc)
    .where.not(user_id: user)
    render json: @results.as_json(include: :requests)
  elsif query == "Price: Low to High"
    @results = Product.order(price: :asc)
    .where.not(user_id: user)
    render json: @results.as_json(include: :requests)
  elsif query == "Sort By: A to Z"
    @results = Product.order(name: :asc)
    .where.not(user_id: user)
    render json: @results.as_json(include: :requests)
  else
    @results = Product.order(name: :desc)
    .where.not(user_id: user)
    render json: @results.as_json(include: :requests)

  end
  

  
  end

end



