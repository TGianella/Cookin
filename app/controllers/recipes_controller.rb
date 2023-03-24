class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    find_recipe
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user

    if @recipe.save!
      flash[:success] = 'Recette créée !'
      redirect_to chef_recipe_path(current_user, @recipe)
    else
      flash[:alert] = "La recette n'a pas pu être créée !"
      render :new
    end
  end

  def update
    find_recipe
    if @recipe.chef_id == current_user.id
      @recipe.update(recipe_params)
      if @recipe.save!
        flash[:success] = 'Recette modifiée !'
        redirect_to recipe_path(@recipe)
      else
        flash[:alert] = "La recette n'a pas pu être modifiée !"
        render :new
      end
    else
      flash[:alert] = "Vous n'êtes pas le propriétaire de cette recette"
      render :edit
      puts "test commit"
    end
  end

  def destroy
    find_recipe
    @recipe.destroy
    flash[:success] = 'Recette supprimée !'
    redirect_to chef_path(current_user)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :content, :duration, :difficulty)
  end

  def find_recipe
    @recipe = Recipe.find_by(title: params[:title])
  end
end
