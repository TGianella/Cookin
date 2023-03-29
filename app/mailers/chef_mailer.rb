class ChefMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def reservation_created_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.chef.email, subject: "#{@reservation.guest.full_name} veut réserver pour une session")
  end

  def reservation_validated_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.chef.email,
         subject: "Vous avez validé l'inscription de #{@reservation.guest.full_name} pour #{@reservation.masterclass.title} !")
  end

  def reservation_cancelled_by_guest_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.chef.email,
         subject: "#{@reservation.guest.full_name} a annulé son inscription pour #{@reservation.masterclass.title}")
  end
end
