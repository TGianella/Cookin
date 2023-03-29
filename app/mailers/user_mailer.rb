class UserMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def welcome_email(user)
    @user = user
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @user.email, subject: 'Bienvenue sur notre site !')
  end

  def reservation_created_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.guest.email, subject: "Votre demande d'inscription pour #{@reservation.masterclass.title}")
  end

  def reservation_validated_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.guest.email,
         subject: "Votre inscription est validée pour #{@reservation.masterclass.title} !")
  end

  def reservation_cancelled_by_guest_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.guest.email,
         subject: "Vous avez annulé votre demande d'inscription pour #{@reservation.masterclass.title}")
  end

  def reservation_cancelled_by_chef_email(reservation)
    @reservation = reservation
    @url = "https://#{HEROKU_APP_NAME}.herokuapp/users/sign_in"

    mail(to: @reservation.guest.email,
         subject: "Votre demande d'inscription a été annulée #{@reservation.masterclass.title}")
  end
end
