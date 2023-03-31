class ReservationsController < ApplicationController
  before_action :authenticate_user!

  # def show; end

  def create
    @reservation = Reservation.new(guest: current_user,
                                   meeting: Meeting.find(params[:meeting_id]))

    if @reservation.save
      flash[:success] = 'Inscription validée'
    else
      flash[:alert] = "Votre inscription n'a pas pu être validée"
    end

    redirect_back fallback_location: root_path
  end

  def update
    @reservation = Reservation.find(params[:id])

    if current_user == @reservation.meeting.chef && @reservation.status == false

      if @reservation.update(status: true)
        flash[:success] = "Reservation validée pour #{@reservation.guest.full_name}"
      else
        flash[:alert] = "La réservation n'a pas pu être validée"
      end

    else
      flash[:error] = "Il n'est pas possible de valider cette réservation"
    end

    redirect_back fallback_location: root_path
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    if current_user == @reservation.meeting.chef
      UserMailer.reservation_cancelled_by_chef_email(@reservation).deliver_now
      destroy_reservation
    elsif current_user == @reservation.guest
      UserMailer.reservation_cancelled_by_guest_email(@reservation).deliver_now
      ChefMailer.reservation_cancelled_by_guest_email(@reservation).deliver_now
      destroy_reservation
    else
      flash[:error] = "Vous n'êtes pas autorisé à annuler cette réservation"
    end

    redirect_back fallback_location: root_path
  end

  private

  def destroy_reservation
    if @reservation.destroy
      flash[:success] = 'Réservation annulée !'
    else
      flash[:alert] = "La réservation n'a pas pu être annulée"
    end
  end
end
