class MasterclassesController < ApplicationController
  def index
    if params[:search].present?
      @categories_search = Category.search_by_name(params[:search])
      @masterclasses_search = Masterclass.search_by_description_and_title(params[:search])
      @recipes_search = Recipe.search_by_description_and_title(params[:search])
      @chefs = User.search_by_name(params[:search])
      @chefs_search = @chefs.where(is_chef: true)
      @masterclasses = []
      @chefs_search.each do |chef|
        chef.given_masterclasses.each do |masterclass|
          @masterclasses << masterclass
        end
      end
      @categories_search.each do |categorie|
        categorie.masterclasses.each do |masterclass|
          @masterclasses << masterclass
        end
      end
      @recipes_search.each do |recipe|
        recipe.masterclasses.each do |masterclass|
          @masterclasses << masterclass
        end
      end

      @masterclasses_search.each do |masterclass|
        @masterclasses << masterclass
      end
      @masterclasses = @masterclasses.uniq
    else
      @masterclasses = Masterclass.all
    end
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

    if @masterclass.save!
      flash[:success] = 'Masterclass créée !'
      redirect_to chef_masterclass_path(current_user, @masterclass)
    else
      flash[:danger] = "La masterclass n'a pas pu être créée"
      render :new
    end
  end

  def edit
    @categories = Category.all
    find_masterclass
    if current_user == @masterclass.chef
      @recipes = current_user.taught_recipes
    else
      redirect_back fallback_location: root_path
    end
  end

  def update
    @recipes = current_user.taught_recipes
    find_masterclass
    if @masterclass.chef == current_user
      if @masterclass.update(masterclass_params)
        flash[:success] = 'Masterclass modifiée !'
        redirect_to chef_masterclass_path(current_user, @masterclass)
      else
        flash[:danger] = "La masterclass n'a pas pu être modifiée !"
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:danger] = "Vous n'êtes pas le propriétaire de cette masterclass"
      redirect_to chef_masterclass(@masterclass.chef, @masterclass)
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
    params.require(:masterclass).permit(:title, :description, :duration, :price, :image, recipe_ids: [])
  end

  def find_masterclass
    @masterclass = Masterclass.find_by(title: params[:title])
  end
end
