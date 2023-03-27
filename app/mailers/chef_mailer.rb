class ChefMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def reservation_created_email(reservation)
    @reservation = reservation
    @url = 'https://thecookinproject.herokuapp.com/users/sign_in'

    mail(to: @reservation.chef.email, subject: "#{@reservation.guest.full_name} veut réserver pour une session")
  end
end
