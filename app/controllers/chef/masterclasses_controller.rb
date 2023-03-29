class Chef::MasterclassesController < ApplicationController
  before_action :authenticate_user!, only: :edit

  def index
    @chef = User.find_from_param(params[:chef_name])
    @masterclasses = @chef.given_masterclasses
  end

  def show; end

  def edit
    @categories = Category.all
    @masterclass = Masterclass.find_by(title: params[:title])
    if current_user == @masterclass.chef
      @recipes = current_user.taught_recipes
    else
      redirect_back fallback_location: root_path
    end
  end
end
