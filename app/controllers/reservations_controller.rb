class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def create
    @reservation = Reservation.new(guest: current_user,
                                   meeting: Meeting.find(params[:id]))

    if @reservation.save
      flash[:success] = 'Inscription validée'
    else
      flash[:alert] = "Votre inscription n'a pas pu être validée"
    end

    redirect_back fallback_location: root_path
  end

  def destroy; end
end
