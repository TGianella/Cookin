class Chef::ReservationsController < ApplicationController
  def index
    @masterclasses = current_user.given_masterclasses
  end
end
