class Guest::ProfilesController < ApplicationController
  def show
    @user = User.find_from_param(params[:name])
  end

  def edit
    @user = User.find_from_param(params[:name])
  end

  def update
    @user = User.find_from_param(params[:name])
    puts '*' * 60
    puts @user
    puts '*' * 60
    if @user == current_user
      puts '$' * 60
      @user.update!(user_params)
      puts '$' * 60
      flash[:success] = 'Votre profil a bien été mis à jour'
      redirect_to guest_profile_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :city, :zip_code, :phone_number, :birth_date)
  end
end
