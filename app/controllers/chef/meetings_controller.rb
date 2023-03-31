class Chef::MeetingsController < ApplicationController
  def new
    @masterclass = params[:title]
    @meeting = Meeting.new
  end

  # def index; end

  # def show; end

  # def create; end

  # def edit; end

  # def update; end

  # def destroy; end
end
