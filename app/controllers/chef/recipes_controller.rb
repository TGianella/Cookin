class Chef::RecipesController < ApplicationController
  def index
    @chef = User.find_from_param(params[:chef_name])
    @recipes = @chef.taught_recipes
  end
end
