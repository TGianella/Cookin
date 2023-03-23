class Chef::MasterclassesController < ApplicationController
  def index
    @chef = User.find_from_param(params[:chef_name])
    @masterclasses = @chef.given_masterclasses
  end

  def show; end

  def edit
    @masterclass = Masterclass.find_by(title: params[:title])
    @recipes = Recipe.where(chef_id: current_user.id)
  end
end
