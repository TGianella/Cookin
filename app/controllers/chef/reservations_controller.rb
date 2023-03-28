class Chef::ReservationsController < ApplicationController
  def index
    @masterclasses = current_user.given_masterclasses
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
