class Chef::ReservationsController < ApplicationController
  before_action :authenticate_user!, :authenticate_chef!

  def index
    @masterclasses = current_user.given_masterclasses
  end
end
