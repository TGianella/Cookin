class MasterclassesController < ApplicationController
  def index
    @masterclasses = Masterclass.all
  end

  def show
    @masterclass = Masterclass.find_by(title: params[:title])
    @recipes = @masterclass.recipes
    @user_is_owner = current_user == @masterclass.chef
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

  def edit; end

  def update; end

  def destroy; end

  private

  def masterclass_params
    params.require(:masterclass).permit(:title, :description, :duration, :price, recipe_ids: [])
  end
end
