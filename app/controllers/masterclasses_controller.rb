class MasterclassesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authenticate_chef!, except: %i[index show]

  def index
    if params[:search].present?
      initialize_search_variables
      chef_search
      category_search
      recipe_search
      masterclass_search
      @masterclasses = @masterclasses.uniq
    else
      @masterclasses = Masterclass.active.order(created_at: :desc)
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

    unless @masterclass.image.attached?
      @masterclass.image.attach(io: File.open("#{Rails.root}/app/assets/images/empty-placeholder.png"),
                                filename: 'empty-placeholder.png')
    end

    @masterclass.chef = current_user
    @recipes = current_user.taught_recipes

    if @masterclass.save
      flash[:success] = 'Masterclass créée !'
      redirect_to chef_masterclass_path(current_user, @masterclass)
    else
      flash[:danger] = "La masterclass n'a pas pu être créée"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all
    find_masterclass
    authenticate_owner_chef!(@masterclass)
    @recipes = current_user.taught_recipes
    end
  end

  def update
    @recipes = current_user.taught_recipes
    find_masterclass
    authenticate_owner_chef!(@masterclass)

    if @masterclass.update(masterclass_params)
      flash[:success] = 'Masterclass modifiée !'
      redirect_to chef_masterclass_path(current_user, @masterclass)
    else
      flash[:danger] = "La masterclass n'a pas pu être modifiée !"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    find_masterclass
    authenticate_owner_chef!(@masterclass)
    @masterclass.destroy
    flash[:success] = 'Masterclass supprimée !'
    redirect_to chef_path(current_user)
  end

  private

  def masterclass_params
    params.require(:masterclass).permit(:title, :description, :duration, :price, :image, category_ids: [],
                                                                                         recipe_ids: [])
  end

  def find_masterclass
    @masterclass = Masterclass.find_by(title: params[:title])
  end

  def initialize_search_variables
    @categories_search = Category.search_by_name(params[:search])
    @masterclasses_search = Masterclass.search_by_description_and_title(params[:search])
    @recipes_search = Recipe.search_by_description_and_title(params[:search])
    @chefs = User.search_by_name(params[:search])
    @chefs_search = @chefs.where(is_chef: true)
    @masterclasses = []
  end

  def chef_search
    @chefs_search.each do |chef|
      chef.given_masterclasses.each do |masterclass|
        @masterclasses << masterclass
      end
    end
  end

  def category_search
    @categories_search.each do |categorie|
      categorie.masterclasses.each do |masterclass|
        @masterclasses << masterclass
      end
    end
  end

  def recipe_search
    @recipes_search.each do |recipe|
      recipe.masterclasses.each do |masterclass|
        @masterclasses << masterclass
      end
    end
  end

  def masterclass_search
    @masterclasses_search.each do |masterclass|
      @masterclasses << masterclass
    end
  end
end
