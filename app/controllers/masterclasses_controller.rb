class MasterclassesController < ApplicationController
  def index
    @masterclasses = Masterclass.all
  end

  def show; end
end
