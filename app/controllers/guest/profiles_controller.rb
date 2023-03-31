class Guest::ProfilesController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find_from_param(params[:name])
  end

  def edit
    @user = User.find_from_param(params[:name])
  end

  def update
    @user = User.find_from_param(params[:name])
    if @user == current_user
      if @user.update(user_params)
        flash[:success] = 'Votre profil a bien été mis à jour'
        redirect_to guest_profile_path(@user)
      else
        flash[:alert] = "Votre profil n'a pas pu être mis à jour"
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :zip_code, :phone_number, :birth_date, :description, :image)
  end

  def find_user 
    @user = User.find_from_param(params[:name])
  end
end
