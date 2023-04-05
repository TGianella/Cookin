class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name birth_date city zip_code phone_number email
                                               password password_confirmation])
  end

  def authenticate_chef!
    return if current_user.is_chef

    flash[:danger] = "Vous n'êtes pas autorisé à effectuer cette action"
    redirect_to root_path
  end

  def authenticate_owner_chef!(resource)
    return if current_user == resource.chef

    flash[:danger] = "Vous n'êtes pas autorisé à effectuer cette action car il ne s'agit pas de votre recette/cours"
    redirect_to root_path
  end
end
