class MasterclassesController < ApplicationController
  def index
    @masterclasses = Masterclass.all
  end

  def show
    find_masterclass
    @is_owner = user_signed_in? && current_user.is_chef && @masterclass.chef == current_user
    @recipes = @masterclass.recipes
  end

  def new
    @masterclass = Masterclass.new
    @recipes = current_user.taught_recipes
  end

  def create
    @masterclass = Masterclass.new(masterclass_params)
    @masterclass.chef = current_user
    @recipes = current_user.taught_recipes

    if @masterclass.save
      flash[:success] = 'Masterclass créée !'
      redirect_to chef_masterclass_path(current_user, @masterclass)
    else
      flash[:alert] = "La masterclass n'a pas pu être créée"
      render :new
    end
  end

  def update
    find_masterclass
    if @masterclass.chef == current_user
      @masterclass.update(masterclass_params)
      if @masterclass.save!
        flash[:success] = 'Mastrclass modifiée !'
        redirect_to chef_masterclass_path(current_user, @masterclass)
      else
        flash[:alert] = "La masterclass n'a pas pu être modifiée !"
        render :edit
      end
    else
      flash[:alert] = "Vous n'êtes pas le propriétaire de cette masterclass"
      render :edit
    end
  end

  def destroy
    find_masterclass
    @masterclass.destroy
    flash[:success] = 'Masterclass supprimée !'
    redirect_to chef_path(current_user)
  end

  private

  def masterclass_params
    params.require(:masterclass).permit(:title, :description, :duration, :price, recipe_ids: [])
  end

  def find_masterclass
    @masterclass = Masterclass.find_by(title: params[:title])
  end
end
