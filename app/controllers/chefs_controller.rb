class ChefsController < ApplicationController
  def index
    @chefs = User.chefs
  end

  def show
    @chef = User.find_from_param(params[:name])
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
