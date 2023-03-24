class Chef::RecipesController < ApplicationController
  def index
    @chef = User.find_from_param(params[:chef_name])
    @recipes = @chef.taught_recipes
  end

  def show; end

  def edit
    @recipe = Recipe.find_by(title: params[:title])
    return if current_user == @recipe.chef

    redirect_back fallback_location: root_path
  end

  def destroy; end
end
