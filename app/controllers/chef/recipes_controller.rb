class Chef::RecipesController < ApplicationController
  def index
    first_name, last_name = params[:chef_name].split(' ')
    @chef = User.where(first_name: first_name, last_name: last_name).first
    @recipes = @chef.taught_recipes
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end
end
