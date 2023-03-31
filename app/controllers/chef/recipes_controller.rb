class Chef::RecipesController < ApplicationController
  before_action :authenticate_user!, only: :edit
  def index
    @chef = User.find_from_param(params[:chef_name])
    @recipes = @chef.taught_recipes
  end
end