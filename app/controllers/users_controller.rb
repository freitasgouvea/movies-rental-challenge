class UsersController < ApplicationController
  def recommendations
    user = User.find(params[:id])
    favorite_movies = user.favorites
    recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: recommendations
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def rented_movies
    user = User.find(params[:id])
    rented_movies = user.rented
    render json: rented_movies
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end

