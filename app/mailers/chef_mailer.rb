class ChefMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def reservation_email(reservation)
    @meeting = reservation.meeting
    @guest = reservation.guest
    @url = 'https://thecookinproject.herokuapp.com/users/sign_in'

    mail(to: @meeting.chef.email, subject: "#{guest.full_name} veut réserver pour une session")
  end
end
