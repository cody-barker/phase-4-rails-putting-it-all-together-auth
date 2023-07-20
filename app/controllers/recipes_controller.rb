class RecipesController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    def index
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            render json: Recipe.all, include: :user, status: :created
        else
            render json: {errors: ["Unauthorized"]}, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, include: :user, status: :created
        else
            render json: {errors: ["Unauthorized"]}, status: :unauthorized
        end
    end

    private

    def recipe_params 
        params.permit(:title, :instructions, :minutes_to_complete)
    end

    def render_unprocessable_entity(exception)
        render json: {errors: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
