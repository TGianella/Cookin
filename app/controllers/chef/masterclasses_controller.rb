class Chef::MasterclassesController < ApplicationController
  before_action :authenticate_user!, only: :edit

  def index
    @chef = User.find_from_param(params[:chef_name])
    @masterclasses = @chef.given_masterclasses
  end
end
