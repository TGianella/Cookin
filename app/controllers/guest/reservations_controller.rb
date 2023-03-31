class Guest::ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
  end

  # def show; end

  # def new; end

  # def create; end

  # def edit; end

  # def update; end

  # def destroy; end
end
