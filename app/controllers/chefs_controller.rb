class ChefsController < ApplicationController
  def index
    @chefs = User.chefs
    @chef = User.find_from_param(params[:name])
  end

  def show
    @chef = User.find_from_param(params[:name])
  end

  def edit
    @chef = User.find_from_param(params[:name])
  end

  def update
    @chef = User.find_from_param(params[:name])
    if @chef == current_user
      if @chef.update(user_params)
        @errors = @chef.errors
        flash[:success] = 'Votre profil a bien été mis à jour'
        redirect_to chef_path(@chef)
      else
        flash[:alert] = "Votre profil n'a pas pu être mis à jour"
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :zip_code, :phone_number, :birth_date)
  end
end
