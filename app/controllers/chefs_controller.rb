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
    authenticate_chef_identity
  end

  def update
    @chef = User.find_from_param(params[:name])
    authenticate_chef_identity
    if @chef.update(user_params)
      @errors = @chef.errors
      flash[:success] = 'Votre profil a bien été mis à jour'
      redirect_to chef_path(@chef)
    else
      flash[:danger] = "Votre profil n'a pas pu être mis à jour"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :city, :zip_code, :phone_number,
                                 :birth_date, :description)
  end

  def authenticate_chef_identity
    return if current_user == @chef

    flash[:danger] = "Ce n'est pas votre profil !"
    redirect_back fallback_location: root_path
  end
end
