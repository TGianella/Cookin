class MasterclassesController < ApplicationController
  def index
    @masterclasses = Masterclass.all.reject { |masterclass| masterclass.recipes.empty? }
  end

  def show
    find_masterclass
    @recipes = @masterclass.recipes
  end

  def new
    @masterclass = Masterclass.new
    @recipes = current_user.taught_recipes
  end

  def create
    @masterclass = Masterclass.new(masterclass_params)
    @masterclass.chef = current_user

    if @masterclass.save
      flash[:success] = 'Masterclass créée !'
      redirect_to masterclass_path(@masterclass)
    else
      flash[:alert] = "La masterclass n'a pas pu être créée"
      render :new
    end
  end


  def update
    find_masterclass
    if @masterclass.chef_id == current_user.id
      @masterclass.update(masterclass_params)
      if @masterclass.save!
        flash[:success] = 'Recette modifiée !'
        redirect_to masterclass_path(@masterclass)
      else
        flash[:alert] = "La recette n'a pas pu être modifiée !"
        render :new
      end
    else
      flash[:alert] = "Vous n'êtes pas le propriétaire de cette recette"
      render :new
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
