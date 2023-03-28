class UserMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def welcome_email(user)
    @user = user
    @url = 'https://cookin-project.herokuapp.com/'
    mail(to: @user.email, subject: 'Bienvenue sur notre site !')
  end

  def reservation_created_email(reservation)
    @reservation = reservation
    @url = new_user_session_url

    mail(to: @reservation.guest.email, subject: "Votre demande d'inscription pour #{@reservation.masterclass.title}")
  end

  def reservation_validated_email(reservation)
    @reservation = reservation
    @url = new_user_session_url

    mail(to: @reservation.guest.email,
         subject: "Votre inscription est validée pour #{@reservation.masterclass.title} !")
  end

  def reservation_cancelled_by_guest_email(reservation)
    @reservation = reservation
    @url = new_user_session_url

    mail(to: @reservation.guest.email,
         subject: "Vous avez annulé votre demande d'inscription pour #{@reservation.masterclass.title}")
  end

  def reservation_cancelled_by_chef_email(reservation)
    @reservation = reservation
    @url = new_user_session_url

    mail(to: @reservation.guest.email,
         subject: "Votre demande d'inscription a été annulée #{@reservation.masterclass.title}")
  end
end
