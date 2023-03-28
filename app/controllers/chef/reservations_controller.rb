class Chef::ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
    @masterclasses = Masterclass.where(chef: current_user) 
    @meetings = Meeting.where(reservations: @reservations) 
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
