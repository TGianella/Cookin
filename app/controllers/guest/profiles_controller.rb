class Guest::ProfilesController < ApplicationController

  def show
    puts '$' * 60
    @user = User.find_from_param(params[:name])
    puts params
    puts '$' * 60
  end

  def create; end

  def edit; end

  def update; end
end
