class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by(title: params[:title])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save!
      flash[:success] = 'Recette créée !'
      redirect_to recipe_path(@recipe)
    else
      flash[:alert] = "La recette n'a pas pu être créée !"
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :content, :duration, :difficulty)
  end
end
