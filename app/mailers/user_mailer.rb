class UserMailer < ApplicationMailer
  default from: 'saeros@yopmail.com'

  def welcome_email(user)
    @user = user
    @url = 'https://cookin-project.herokuapp.com/'
    mail(to: @user.email, subject: 'Bienvenue sur notre site !')
  end
end
