class Chef::MasterclassesController < ApplicationController
  def index
    @chef = User.find_from_param(params[:chef_name])
    @masterclasses = @chef.given_masterclasses
  end
end
